//
//  XYBaseParam.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYBaseParam.h"
#import "XYAccountTool.h"
#import "XYAccountResult.h"

@implementation XYBaseParam

+ (instancetype)baseParam{
    XYBaseParam *baseParam = [[self alloc] init];
    XYAccountResult *account = [XYAccountTool accountResult];
    
    baseParam.access_token = account.access_token;
    
    return baseParam;
}
@end
