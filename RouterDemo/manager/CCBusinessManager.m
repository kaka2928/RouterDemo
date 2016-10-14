//
//  CCBusinessManager.m
//  RouterDemo
//
//  Created by caochao on 16/10/14.
//  Copyright © 2016年 snailCC. All rights reserved.
//

#import "CCBusinessManager.h"
#import "CCRouter.h"
@interface CCBusinessManager()

@property (nonatomic,copy) CCRouterCallbackBlock block;

@end
@implementation CCBusinessManager
+ (instancetype)sharedInstance
{
    static CCBusinessManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CCBusinessManager alloc] init];
    });
    return manager;
}
-(void) openLocalURL:(NSURL *)url completion:(void (^)(NSDictionary *result,NSError *error))completion{
    
    NSString *businessName =url.scheme;
    NSString *actionName = url.host;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    [[CCRouter sharedInstance]performBusiness:businessName action:actionName params:params completion:completion];
}
-(BOOL) openCallBackURL:(NSURL *)url sourceAppKey:(NSString *)sourceAppKey{
    
    BOOL flag = [[[CCRouter sharedInstance] performRemoteActionWithUrl:url sourceAppKey:sourceAppKey completion:^(NSDictionary *response, NSError *error) {
        if (self.block !=nil) {
            self.block(response,error);
        }
    }] boolValue];
    //    self.block = nil;
    return flag;
    
}
@end
