//
//  XYStatusCacheTool.h
//  Weibo
//
//  Created by 李小亚 on 16/3/23.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYStatusParam;

@interface XYStatusCacheTool : NSObject

/**
 *  保存数据到本地数据库
 *
 *  @param statuses 字典 数组
 */
+ (void)saveWithStatuses:(NSArray *)statuses;

/**
 *  从服务器中获取数据
 *
 *  @param param 请求参数
 *
 *  @return 默认20条数据 模型
 */
+ (NSArray *)stattusesWithParam:(XYStatusParam *)param;
@end
