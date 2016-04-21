//
//  XYComposeTool.h
//  Weibo
//
//  Created by 李小亚 on 16/3/23.
//  Copyright © 2016年 李小亚. All rights reserved.
// 发微博

#import <Foundation/Foundation.h>

@interface XYComposeTool : NSObject

/**
 *  发送文本微博
 *
 *  @param ststus  文本内容
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)sendComposeWithStatus:(NSString *)ststus success:(void (^)())success failure:(void (^)(NSError *error))failure;

/**
 *  发送带图片的微博
 *
 *  @param ststus  文本内容
 *  @param photo   需要发送的图片
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)sendPhotosComposeWithStatus:(NSString *)ststus photo:(UIImage *)photo success:(void (^)())success failure:(void (^)(NSError *error))failure;
@end
