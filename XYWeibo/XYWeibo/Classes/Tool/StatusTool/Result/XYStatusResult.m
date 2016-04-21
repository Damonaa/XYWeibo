//
//  XYStatusResult.m
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatusResult.h"
#import "XYStatus.h"

@implementation XYStatusResult

/**
 *  将数组中的元素转换为模型
 */
- (NSDictionary *)objectClassInArray{
    return @{@"statuses": [XYStatus class]};
}
@end
