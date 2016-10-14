//
//  CCRouter.m
//  SnailKit
//
//  Created by caochao on 16/10/11.
//  Copyright © 2016年 snailCC. All rights reserved.
//

#import "CCRouter.h"
NSString * const CCRouterBusinessMatrix = @"Business_matrix";

NSString * const BusinessNotFountAction = @"businessNotFound:";
NSString * const ActionNotFountAction = @"actionNotFound:";
NSString * const RemoteCallBackAction = @"remoteCallBack";

@implementation CCRouter
+ (instancetype)sharedInstance
{
    static CCRouter *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[CCRouter alloc] init];
    });
    return router;
}
- (void)performBusiness:(NSString *)businessName action:(NSString *)actionName params:(NSDictionary *)params completion:(CCRouterCallbackBlock)completion{
    
     NSMutableDictionary *newParams = [NSMutableDictionary dictionaryWithDictionary:params];
    if (completion != nil) {
        [newParams setObject:completion forKey:COMPLETION];
    }
    [self performBusiness:businessName action:actionName params:[newParams copy]];
}
- (id)performRemoteActionWithUrl:(NSURL *)url sourceAppKey:(NSString *)sourceAppKey completion:(CCRouterCallbackBlock)completion{

    if ([sourceAppKey isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]]) {
        // 避免自身通过远程方式调用
        return @(NO);
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    // 每个子事务重写 remoteCallBack 方法，实现对应第三方应用的 openURL，同时注意：事务名称需要与该第三方scheme保持一致
    [self performBusiness:url.scheme action:RemoteCallBackAction params:params completion:^(NSDictionary *response, NSError *error) {
        if (completion) {
            completion(response,error);
        }
    }];

    return @(YES);
}
#pragma mark - private method
- (void)performBusiness:(NSString *)businessName action:(NSString *)actionName params:(NSDictionary *)params;
{
    
    NSString *businessClassString = [NSString stringWithFormat:@"%@_%@",BUSINESSLEVEL, businessName];
    NSString *actionString = [NSString stringWithFormat:@"%@_%@:",ACTIONLEVEL,actionName];
    
    NSString *businessParam = (businessName == nil)?@"":businessName;
    NSString *actionParam = (actionName == nil)?@"":actionName;

    
    Class targetClass = NSClassFromString(businessClassString);
    id target = [[targetClass alloc] init];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) {
        // 处理无响应请求的地方之一，当找不到对应事务时，调用 Business_Matrix，返回 找不到 对应businessName 事务的结果；
        NSString *matrixClassString = CCRouterBusinessMatrix;
        Class matrixClass = NSClassFromString(matrixClassString);
        id target = [[matrixClass alloc] init];
        SEL action = NSSelectorFromString(BusinessNotFountAction);
        IMP imp = [target methodForSelector:action];
        if (imp!=NULL) {
            void (*func)(id, SEL,NSDictionary *) = (void *)imp;
            NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];
            [parameters setObject:businessParam forKey:BUSINESS];

            func(target, action,parameters);
        }

    }else{
    
        if ([target respondsToSelector:action]) {
            IMP imp = [target methodForSelector:action];
            void (*func)(id, SEL,NSDictionary *) = (void *)imp;
            if (imp!=NULL) {
                func(target, action,params);
            }
        } else {
            // 这里是处理无响应请求的地方，如果无响应，调用 Business_Matrix 基础方法，返回 找不到 对应 actionName 操作的结果；
            SEL action = NSSelectorFromString(ActionNotFountAction);
            IMP imp = [target methodForSelector:action];
            void (*func)(id, SEL,NSDictionary *) = (void *)imp;
            if (imp!=NULL) {
                NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];
                [parameters setObject:businessParam forKey:BUSINESS];
                [parameters setObject:actionParam forKey:ACTION];
                func(target, action,[parameters copy]);
            }
        }
    }
    

}
@end
