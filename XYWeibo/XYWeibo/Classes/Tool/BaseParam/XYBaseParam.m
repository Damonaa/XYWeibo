//
//  XYBaseParam.m
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYBaseParam.h"

#import "XYAccountResult.h"
#import "XYAccountTool.h"

@implementation XYBaseParam

+ (instancetype)baseParam{
    XYBaseParam *baseParam = [[self alloc] init];
    baseParam.access_token = [XYAccountTool account].access_token;
    
    return baseParam;
}

@end
