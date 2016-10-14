//
//  Business_loginmodule.m
//  RouterDemo
//
//  Created by caochao on 16/10/14.
//  Copyright © 2016年 snailCC. All rights reserved.
//

#import "Business_loginmodule.h"

@implementation Business_loginmodule
- (void) Action_login:(NSDictionary *)info{

    CCRouterCallbackBlock callback = nil;
    
    for (NSString *key in [info allKeys]) {
        if ([key isEqualToString:COMPLETION]) {
            callback= info[COMPLETION];
            break;
        }
    }
    if ([self paramCheckWith:@[@"userName",@"password"] params:info completion:callback]) {
        return;
    }
    NSMutableDictionary *response = [NSMutableDictionary dictionaryWithDictionary:info];
    [response setObject:@"1" forKey:@"msgcode"];
    [response setObject:@"login success" forKey:@"message"];
    callback(response,nil);
}
@end
