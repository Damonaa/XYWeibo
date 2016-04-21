//
//  XYAccountResult.h
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
// 用户获取到access_token后 即授权成功，获取de结果模型，保存到沙盒
/**
 *  "access_token" = "2.00NEQu4CmT7slC223af57f600pFkgv";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 2185529525;
 */

#import <Foundation/Foundation.h>

@interface XYAccountResult : NSObject<NSCoding>

/**
 *  借口授权后获得的令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  access_token的声明周期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  access_token的声明周期  将被弃用
 */
@property (nonatomic, copy) NSString *remind_in;
/**
 *  当前授权用户的UID
 */
@property (nonatomic, copy) NSString *uid;

#warning !!!
//设置账户过期的时间

/**
 *  用户昵称 （XYUser  name）
 */
@property (nonatomic, copy) NSString *name;
//初始化创建方法
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
