//
//  XYUnreadCountTool.h
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYUnreadCountResult;

@interface XYUnreadCountTool : NSObject
/**
 *  请求获取未读消息数目
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)unreadCountWithSuccess:(void(^)(XYUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;
@end
