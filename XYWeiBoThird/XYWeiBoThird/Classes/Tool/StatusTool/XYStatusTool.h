//
//  XYStatusTool.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYStatusTool : NSObject

/**
 *  获取最新的微博数据
 *
 *  @param sinceID sinceId
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getNewStatusesWithSinceID:(NSString *)sinceID success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure;

/**
 *  获取更多旧的微博数据
 *
 *  @param maxID maxID
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getMoreStatusesWithSinceID:(NSString *)maxID success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure;
@end
