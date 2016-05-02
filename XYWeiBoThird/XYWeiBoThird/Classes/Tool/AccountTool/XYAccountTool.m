//
//  XYAccountTool.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYAccountTool.h"
#import "XYHttpTool.h"
#import "XYAccountParam.h"
#import "MJExtension.h"
#import "XYAccountResult.h"

@implementation XYAccountTool

static XYAccountResult *accountResult;
static NSMutableDictionary *accountsDict;

+ (void)getAccessTokenWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *error))failure{
    NSString *baseUrl = @"https://api.weibo.com/oauth2/access_token";
    XYAccountParam *param = [[XYAccountParam alloc] init];
    param.client_id = XYClient_id;
    param.client_secret = XYApp_Secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = XYRedirect_uri;
    //param 模型转字典
    
    [XYHttpTool POST:baseUrl parameters:param.mj_keyValues success:^(id responseObject) {
        XYLog(@"%@", responseObject);
        //成功，获取令牌, 保存
        XYAccountResult *account = [XYAccountResult accountResultWithDict:responseObject];
        [XYAccountTool saveAccount:account];
        
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
 *  保存到沙盒
 *
 *  @param accountResult 授权成功结果
 */
+ (void)saveAccount:(XYAccountResult *)accountResult{
    //当前的账号存到沙盒
    [NSKeyedArchiver archiveRootObject:accountResult toFile:[self accountPath]];
    //保存账号到字典中
    self.accountsDict[accountResult.uid] = accountResult;
    [NSKeyedArchiver archiveRootObject:accountsDict toFile:[self accountsManagePath]];
}

//从沙盒中取出全部的账号
+ (NSMutableDictionary *)accountsDict{
    accountsDict = [NSKeyedUnarchiver unarchiveObjectWithFile:[self accountsManagePath]];
    if (!accountsDict) {
        accountsDict = [NSMutableDictionary dictionary];
    }
    
    return accountsDict;
}
/**
 *  从沙盒中取数据
 *
 *  @return account access token
 */
+ (XYAccountResult *)accountResult{
    if (!accountResult) {
        accountResult = [NSKeyedUnarchiver unarchiveObjectWithFile:[self accountPath]];
        //判断账号是否过期
        if ([[NSDate date] compare:accountResult.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    return accountResult;
}

+ (NSString *)accountPath{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"];
}

+ (NSString *)accountsManagePath{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountsManage.archive"];
}
@end
