//
//  XYStatusTool.m
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatusTool.h"
#import "XYHttpTool.h"
#import "XYStatusParam.h"
#import "XYStatusResult.h"
#import "MJExtension.h"
#import "XYStatusCacheTool.h"

@implementation XYStatusTool

/**
 *  请求新的微博数据
 *
 *  @param since_id 返回ID比since_id大的微博 默认为0
 *  @param success  回调成功
 *  @param failure  回调失败
 */
+ (void)newStatusesWithSinceID:(NSString *)since_id success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure{
    
    //参数模型
    XYStatusParam *param = [XYStatusParam baseParam];

    if (since_id) {
        param.since_id = since_id;
    }
    
    //先从本地数据库中取数据
    NSArray *statuses = [XYStatusCacheTool stattusesWithParam:param];
    if (statuses.count) {
        //如果去得到，就把数据传出去
        if (success) {
            success(statuses);
        }
        
        return;
    }
    
    
    //param.keyValues 模型转字典
    //发送请求
    [XYHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
//        NSLog(@"statuses: %@", responseObject);
        //返回json格式的数据 转成模型
        XYStatusResult *statuses = [XYStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(statuses.statuses);
        }
        
        //将新取到的数据保存的本地  保存原始的全部数据
        [XYStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


/**
 *  请求新的微博数据
 *
 *  @param since_id 返回ID小于或等于max_id的微博，默认为0
 *  @param success  回调成功
 *  @param failure  回调失败
 */
+ (void)moreStatusesWithMaxID:(NSString *)max_id success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure{
    //请求参数模型
    XYStatusParam *param = [XYStatusParam baseParam];
    if (max_id) {
        param.max_id = max_id;
    }
    
    //先从本地数据库中取数据
    NSArray *statuses = [XYStatusCacheTool stattusesWithParam:param];
    if (statuses.count) {
        //如果去得到，就把数据传出去
        if (success) {
            success(statuses);
        }
        
        return;
    }
    
    
    [XYHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        XYStatusResult *statuses = [XYStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(statuses.statuses);
        }
        
        //将新取到的数据保存的本地  保存原始的全部数据
        [XYStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
