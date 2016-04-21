//
//  XYBaseParam.h
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
// 参数的基类， 继承这个方法 就拥有的access_token

#import <Foundation/Foundation.h>

@interface XYBaseParam : NSObject

@property (nonatomic, copy) NSString *access_token;

/**
 *  初始化创建类
 *  并且为access_token赋值
 */
+ (instancetype)baseParam;
@end
