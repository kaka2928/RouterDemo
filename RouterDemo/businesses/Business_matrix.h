//
//  Business_matrix.h
//  SnailKit
//
//  Created by caochao on 16/10/11.
//  Copyright © 2016年 snailCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business_matrix : NSObject

- (void) actionNotFound:(NSDictionary *)actionInfo;
- (void) businessNotFound:(NSDictionary *)businessInfo;

- (void) Action_remoteCallBack:(NSDictionary *)callBackInfo;
- (BOOL) paramCheckWith:(NSArray *)keys params:(NSDictionary *)params completion:(CCRouterCallbackBlock )completion;
@end
