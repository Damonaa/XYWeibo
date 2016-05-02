//
//  XYRemindTool.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/27.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYRemindResult;

@interface XYRemindTool : NSObject

/**
 *  请求获取用户未读消息数
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getUnreadStatusesSuccess:(void (^)(XYRemindResult *result))success failure:(void (^)(NSError *error))failure;
@end
