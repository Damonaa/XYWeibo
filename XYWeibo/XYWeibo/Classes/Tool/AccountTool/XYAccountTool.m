//
//  XYAccountTool.m
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//


#define XYAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountData"]

#import "XYAccountTool.h"
#import "XYHttpTool.h"
#import "XYAccountParam.h"
#import "XYAccountResult.h"
#import "MJExtension.h"

@implementation XYAccountTool

static XYAccountResult *_accountResult;

/**
 *  获取AccessToken 并且保存账户到沙盒
 *
 *  @param code            回调取得的code
 *  @param success         回调成功，不传参数给外界调用， 外界将要进入主视图或者新特性界面
 *  @param saveAccountWith 并且保存账户到沙盒
 *  @param failure         失败回调  传递错误
 */
+ (void)getAccessTokenWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    XYAccountParam *accountParam = [[XYAccountParam alloc] init];
    accountParam.client_id = XYClient_id;
    accountParam.client_secret = XYClient_secret;
    accountParam.grant_type = @"authorization_code";
    accountParam.code = code;
    accountParam.redirect_uri = XYRedirect_Uri;
    
    [XYHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:accountParam.keyValues success:^(id responseObject) {
        //字典转模型
        XYAccountResult *result = [XYAccountResult accountWithDict:responseObject];
        //保存到沙盒
        [XYAccountTool saveAccountWith:result];
        
        //成功 回调，不传参数
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  保存账号
 *
 *  @param account 账号返回值模型
 */
+ (void)saveAccountWith:(XYAccountResult *)account{
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountData"];
    [NSKeyedArchiver archiveRootObject:account toFile:XYAccountPath];
    
}

/**
 *  从沙盒中取出账号
 *
 *  @return 保存的账号
 */
+ (XYAccountResult *)account{
    if (!_accountResult) {//如果为空就去取
        _accountResult = [NSKeyedUnarchiver unarchiveObjectWithFile:XYAccountPath];
#warning !!!
        //过期
    }
    
    return _accountResult;
}

@end
