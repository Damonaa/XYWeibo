//
//  XYStatusResult.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYStatusResult : NSObject


/**
 *  微博数据（XYStatus）数组中的成员转模型
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  总的微博数
 */
@property (nonatomic, assign) NSInteger total_number;

@end
