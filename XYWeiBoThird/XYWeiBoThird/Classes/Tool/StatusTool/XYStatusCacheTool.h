//
//  XYStatusCacheTool.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYStatusParam;

@interface XYStatusCacheTool : NSObject


/**
 *  保存数据到数据库
 *
 *  @param statuses 需要保存的数据（字典）
 */
+ (void)saveWithStatus:(NSArray *)statuses;


/**
 *  取数据
 *
 *  @param param 数据筛选条件
 *
 *  @return 微博模型数组
 */
+ (NSArray *)statusesWithParam:(XYStatusParam *)param;
@end
