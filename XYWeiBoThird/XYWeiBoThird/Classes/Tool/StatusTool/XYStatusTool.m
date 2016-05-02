//
//  XYStatusTool.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatusTool.h"
#import "XYHttpTool.h"
#import "XYStatusParam.h"
#import "XYStatusResult.h"
#import "XYStatusCacheTool.h"

@implementation XYStatusTool


+ (void)getNewStatusesWithSinceID:(NSString *)sinceID success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure{
    //请求参数
    XYStatusParam *param = [XYStatusParam baseParam];
    if (sinceID) {
        param.since_id = sinceID;
    }
    //先尝试从本地获取数据
    NSArray *statuses = [XYStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    
    [XYHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
        //responseObject返回结果转为模型
        XYStatusResult *result = [XYStatusResult mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
        //保存到数据库
        [XYStatusCacheTool saveWithStatus:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getMoreStatusesWithSinceID:(NSString *)maxID success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure{
    //请求参数
    XYStatusParam *param = [XYStatusParam baseParam];
    if (maxID) {
        param.max_id = maxID;
    }
    
    
    //先尝试从本地获取数据
    NSArray *statuses = [XYStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    
    [XYHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
        //responseObject返回结果转为模型
        XYStatusResult *result = [XYStatusResult mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
        //保存到数据库
        [XYStatusCacheTool saveWithStatus:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
