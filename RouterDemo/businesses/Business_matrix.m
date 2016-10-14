//
//  Business_matrix.m
//  SnailKit
//
//  Created by caochao on 16/10/11.
//  Copyright © 2016年 snailCC. All rights reserved.
//

#import "Business_matrix.h"

@implementation Business_matrix
- (void) actionNotFound:(NSDictionary *)actionInfo{

    CCRouterCallbackBlock callback = nil;
    for (NSString *key in [actionInfo allKeys]) {
        if ([key isEqualToString:COMPLETION]) {
            callback= actionInfo[COMPLETION];
            break;
        }
    }
    
    if (callback) {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
        [userInfo setObject:[NSString stringWithFormat:@"< %@ > action of [ %@ ] business not found",[actionInfo valueForKey:ACTION],[actionInfo valueForKey:BUSINESS]] forKey:NSLocalizedDescriptionKey];
        
        NSError *error = [[NSError alloc]initWithDomain:ERRORMODIN code:-2 userInfo:userInfo];
        callback(nil,error);
    }
}
- (void) businessNotFound:(NSDictionary *)businessInfo{

    CCRouterCallbackBlock callback = nil;
    for (NSString *key in [businessInfo allKeys]) {
        if ([key isEqualToString:COMPLETION]) {
            callback= businessInfo[COMPLETION];
            break;
        }
    }
    
    if (callback) {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
        [userInfo setObject:[NSString stringWithFormat:@"[ %@ ] business not found",[businessInfo valueForKey:BUSINESS]] forKey:NSLocalizedDescriptionKey];
        
        NSError *error = [[NSError alloc]initWithDomain:ERRORMODIN code:-3 userInfo:userInfo];
        callback(nil,error);
    }
}

- (void) Action_remoteCallBack:(NSDictionary *)callBackInfo{
    
    CCRouterCallbackBlock callback = nil;
    for (NSString *key in [callBackInfo allKeys]) {
        if ([key isEqualToString:COMPLETION]) {
            callback= callBackInfo[COMPLETION];
            break;
        }
        
    }
    
    if (callback) {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
        [userInfo setObject:@"this business is not responsble for remoteURL openning" forKey:NSLocalizedDescriptionKey];
        
        NSError *error = [[NSError alloc]initWithDomain:ERRORMODIN code:-1 userInfo:userInfo];
        callback(nil,error);
    }
    
}
- (BOOL) paramCheckWith:(NSArray *)keys params:(NSDictionary *)params completion:(CCRouterCallbackBlock )completion{

    BOOL flag = NO;
    NSString *invalidKey;
    for (NSString *key in keys) {
        if ([params valueForKey:key]==nil) {
            invalidKey = key;
            flag = YES;
        }
    }
    NSError *error = nil;
    if (flag) {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
        [userInfo setObject:[NSString stringWithFormat:@"value for key:%@  is invalid ",invalidKey] forKey:NSLocalizedDescriptionKey];
        
        error = [[NSError alloc]initWithDomain:ERRORMODIN code:-4 userInfo:userInfo];
        if (completion!=nil) {
            completion(nil,error);
        }
        
    }
    return flag;
}
@end
