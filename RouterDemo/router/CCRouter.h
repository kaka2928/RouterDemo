//
//  CCRouter.h
//  SnailKit
//
//  Created by caochao on 16/10/11.
//  Copyright © 2016年 snailCC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  业务路由中心

 */
@interface CCRouter : NSObject

+ (instancetype)sharedInstance;


/**
 *  本地事务路由接口
 *
 *  @param businessName 事务名称
 *  @param actionName   事件名称
 *  @param params       参数
 *  @param completion   回调
 */
- (void)performBusiness:(NSString *)businessName action:(NSString *)actionName params:(NSDictionary *)params completion:(CCRouterCallbackBlock)completion;
/**
 *  远程openURL
 *
 *  @param url          URL
 *  @param sourceAppKey 调用APP bundle identifer
 *  @param completion   回调
 *
 *  @return  YES/NO
 */
- (id)performRemoteActionWithUrl:(NSURL *)url sourceAppKey:(NSString *)sourceAppKey completion:(CCRouterCallbackBlock)completion;

@end
