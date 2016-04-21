//
//  XYUser.m
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYUser.h"

@implementation XYUser


- (void)setMbtype:(int)mbtype{
    _mbrank = mbtype;
    _vip = mbtype > 2;
}
@end
