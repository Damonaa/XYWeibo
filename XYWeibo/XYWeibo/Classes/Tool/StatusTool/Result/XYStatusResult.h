//
//  XYStatusResult.h
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
// 请求微博后 得到的返回结果模型

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface XYStatusResult : NSObject<MJKeyValue>

/**
 *  微博详情 （XYStatus构成的数组）将数组转换为模型
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  近期的微博个数
 */
@property (nonatomic, assign) int total_number;

@end
