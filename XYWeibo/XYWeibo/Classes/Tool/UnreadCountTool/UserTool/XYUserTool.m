//
//  XYUserTool.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYUserTool.h"
#import "XYUser.h"
#import "XYUserParam.h"
#import "XYAccountResult.h"
#import "XYAccountTool.h"
#import "XYHttpTool.h"
#import "MJExtension.h"


@implementation XYUserTool

/**
 *  请求获取用户信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)userInfoWithSuccess:(void(^)(XYUser *user))success failure:(void (^)(NSError *error))failure{
    XYUserParam *param = [XYUserParam baseParam];
    param.uid = [XYAccountTool account].uid;
    
    [XYHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
       
        XYUser *user = [XYUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
