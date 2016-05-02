//
//  XYStatusResult.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatusResult.h"
#import "MJExtension.h"
#import "XYStatus.h"

@implementation XYStatusResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"statuses": [XYStatus class]};
}
@end
