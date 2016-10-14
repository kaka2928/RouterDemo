//
//  CCBusinessManager.h
//  RouterDemo
//
//  Created by caochao on 16/10/14.
//  Copyright © 2016年 snailCC. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  
 *  url 格式：business://[action]?[params]
 */
@interface CCBusinessManager : NSObject

+ (instancetype)sharedInstance;
/**
 *  执行本地事务
 *
 *  @param url 登录事务url
 *  @param completion 结果回调
 */
-(void) openLocalURL:(NSURL *)url
          completion:(void (^)(NSDictionary *result,NSError *error))completion;
/**
 *  openURL
 *
 *  @param url          URL
 *  @param sourceAppKey sourceAppKey
 *
 *  @return YES/NO
 */
-(BOOL) openCallBackURL:(NSURL *)url
           sourceAppKey:(NSString *)sourceAppKey;
@end
