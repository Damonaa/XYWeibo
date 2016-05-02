//
//  XYRemindParam.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/27.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYBaseParam.h"

@interface XYRemindParam : XYBaseParam

/**
 *  需要获取消息未读数的用户UID，必须是当前登录用户
 */
@property (nonatomic, copy) NSString *uid;

/**
 *
 必选	类型及范围	说明
 source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 uid	true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。
 */
@end
