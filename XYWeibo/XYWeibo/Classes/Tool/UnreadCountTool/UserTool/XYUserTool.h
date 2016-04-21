//
//  XYUserTool.h
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYUser;

@interface XYUserTool : NSObject

/**
 *  请求获取用户信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)userInfoWithSuccess:(void(^)(XYUser *user))success failure:(void (^)(NSError *error))failure;
@end
