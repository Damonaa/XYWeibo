//
//  XYComposeTool.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYComposeTool : NSObject
/**
 *  发送文字微博
 *
 *  @param status  文字内容
 *  @param visible 可见性 （可选）
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)sendStatusWithStatus:(NSString *)status visible:(NSNumber *)visible success:(void (^)())success failure:(void (^)(NSError *error))failure;


/**
 *  发送带文字的微博
 *
 *  @param status  文字内容
 *  @param photo   图片
 *  @param visible 可见性 （可选）
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)sendPhotosWithStatus:(NSString *)status photo:(UIImage *)photo visible:(NSNumber *)visible success:(void (^)())success failure:(void (^)(NSError *error))failure;

/**
 *  转发无文字的微博
 *
 *  @param status  文本内容
 *  @param idStr   转发微博的idstr
 *  @param comment 是否评论
 *  @param visible 可见性
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)repostStatusWithStatus:(NSString *)status idStr:(NSString *)idStr comment:(int)comment visible:(NSNumber *)visible success:(void (^)())success failure:(void (^)(NSError *error))failure;

/**
 *  评论微博
 *
 *  @param comment     评论的内容，不可为空
 *  @param idStr       评论的微博的id
 *  @param comment_ori 当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)commentStatusWithComment:(NSString *)comment idStr:(NSString *)idStr comment_ori:(int)comment_ori success:(void (^)())success failure:(void (^)(NSError *error))failure;
@end
