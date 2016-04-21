//
//  XYHttpTool.h
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//对AFN进行封装

#import <Foundation/Foundation.h>

@class XYComposePhotosParam;

@interface XYHttpTool : NSObject
/**
 *  POST请求
 *
 *  @param URLString  基本URL
 *  @param parameters 请求参数
 *  @param success    成功后回调
 *  @param failure    失败后回调
 */
+ (void)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;
/**
 *  GET请求
 *
 *  @param URLString  基本URL
 *  @param parameters 请求参数
 *  @param success    成功后回调
 *  @param failure    失败后回调
 */
+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  上传文件
 *
 *  @param urlStr      基本url
 *  @param parammeters 请求参数
 *  @param photoParam  文件模型
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)uploadWithUrlStr:(NSString *)urlStr parameters:(id)parammeters composePhotos:(XYComposePhotosParam *)photoParam success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
