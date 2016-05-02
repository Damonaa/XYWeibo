//
//  XYUsersTool.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/27.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYUsersResult.h"

@interface XYUsersTool : NSObject
/**
 *  请求获取用户的信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getUsersShowWithSuccess:(void (^)(XYUsersResult *result))success failure:(void (^)(NSError *error))failure;

@end
