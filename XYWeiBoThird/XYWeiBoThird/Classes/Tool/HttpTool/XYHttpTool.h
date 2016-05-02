//
//  XYHttpTool.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYComposePhoto;

@interface XYHttpTool : NSObject
/**
 *  封装AFN，发送post请求
 *
 *  @param URLString  URL string基本
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  封装AFN，发送get请求
 *
 *  @param URLString  URL string基本
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  上传数据（上传微博图片）
 *
 *  @param URLString    基本URL string
 *  @param parameters   请求参数
 *  @param composePhoto 上传图片的模型
 *  @param success      成功回调
 *  @param failure      失败回调
 */
+ (void)POSTData:(NSString *)URLString parameters:(id)parameters composePhoto:(XYComposePhoto *)composePhoto success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
