//
//  XYHttpTool.m
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYHttpTool.h"
#import "AFNetworking.h"
#import "XYComposePhotosParam.h"

@implementation XYHttpTool

/**
 *  POST请求
 *
 *  @param URLString  基本URL
 *  @param parameters 请求参数
 *  @param success    成功后回调
 *  @param failure    失败后回调
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //AFN内部请求回调成功
        //来到此处，将responseObject传出去
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
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
    failure:(void (^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //AFN内部请求回调成功
        //来到此处，将responseObject传出去
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  上传文件
 *
 *  @param urlStr      基本url
 *  @param parammeters 请求参数
 *  @param photoParam  文件模型
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)uploadWithUrlStr:(NSString *)urlStr parameters:(id)parammeters composePhotos:(XYComposePhotosParam *)photoParam success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    //上传文件
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:parammeters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //拼接文件
        [formData appendPartWithFileData:photoParam.fileData name:photoParam.name fileName:photoParam.fileName mimeType:photoParam.mineType];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
