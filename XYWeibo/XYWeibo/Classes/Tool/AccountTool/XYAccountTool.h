//
//  XYAccountTool.h
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//该工具 用于 将获取到的账号 保存 取出

#import <Foundation/Foundation.h>

@class XYAccountResult;

@interface XYAccountTool : NSObject

/**
 *  获取AccessToken 并且保存账户到沙盒
 *
 *  @param code            回调取得的code
 *  @param success         回调成功，不传参数给外界调用， 外界将要进入主视图或者新特性界面
 *  @param saveAccountWith 并且保存账户到沙盒
 *  @param failure         失败回调  传递错误
 */
+ (void)getAccessTokenWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure;

/**
 *  保存账号
 *
 *  @param account 账号返回值模型
 */
+ (void)saveAccountWith:(XYAccountResult *)account;

/**
 *  取出账号
 *
 *  @return 保存的账号
 */
+ (XYAccountResult *)account;
@end
