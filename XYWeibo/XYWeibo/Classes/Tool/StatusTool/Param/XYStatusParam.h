//
//  XYStatusParam.h
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
// 请求新的微博所需要的参数

#import "XYBaseParam.h"

@interface XYStatusParam : XYBaseParam

/**
 *  返回ID比since_id大的微博 默认为0
 */
@property (nonatomic, copy) NSString *since_id;
/**
 *  返回ID小于或等于max_id的微博，默认为0
 */
@property (nonatomic, copy) NSString *max_id;

@end
