//
//  XYUnreadCountTool.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYUnreadCountTool.h"
#import "XYUnreadCountParam.h"
#import "XYUnreadCountResult.h"
#import "XYHttpTool.h"
#import "XYAccountTool.h"
#import "XYAccountResult.h"
#import "MJExtension.h"

@implementation XYUnreadCountTool
/**
 *  请求获取未读消息数目
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)unreadCountWithSuccess:(void(^)(XYUnreadCountResult *result))success failure:(void (^)(NSError *error))failure{
    //请求参数
    XYUnreadCountParam *param = [XYUnreadCountParam baseParam];
    param.uid = [XYAccountTool account].uid;
    //发出请求
    [XYHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
//        NSLog(@"unreadCount: %@", responseObject);
        //将请求结果转成模型
        XYUnreadCountResult *result = [XYUnreadCountResult objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
