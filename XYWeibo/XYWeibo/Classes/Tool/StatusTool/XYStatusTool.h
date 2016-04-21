//
//  XYStatusTool.h
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
// 请求获取微博数据

#import <Foundation/Foundation.h>

@interface XYStatusTool : NSObject
/**
 *  请求新的微博数据
 *
 *  @param since_id 返回ID比since_id大的微博 默认为0
 *  @param success  回调成功
 *  @param failure  回调失败
 */
+ (void)newStatusesWithSinceID:(NSString *)since_id success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure;

/**
 *  请求新的微博数据
 *
 *  @param since_id 返回ID小于或等于max_id的微博，默认为0
 *  @param success  回调成功
 *  @param failure  回调失败
 */
+ (void)moreStatusesWithMaxID:(NSString *)max_id success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure;
@end
