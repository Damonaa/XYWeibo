//
//  XYAccountTool.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYAccountResult;

@interface XYAccountTool : NSObject



/**
 *  获取access token授权
 *
 *  @param code    回调成功的code
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getAccessTokenWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *error))failure;

/**
 *  保存到沙盒
 *
 *  @param accountResult 授权成功结果
 */
+ (void)saveAccount:(XYAccountResult *)accountResult;
/**
 *  从沙盒中取数据
 *
 *  @return account access token
 */
+ (XYAccountResult *)accountResult;
/**
 *  存放已经登陆过的账号
 */
+ (NSMutableDictionary *)accountsDict;
@end
