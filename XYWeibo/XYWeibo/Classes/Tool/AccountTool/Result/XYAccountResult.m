//
//  XYAccountResult.m
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#define XYAccess_token @"kAccess_token"
#define XYExpires_in   @"kExpires_in"
#define XYRemind_in    @"kRemind_in"
#define XYUID          @"kUID"
#define XYName         @"kName"
#import "XYAccountResult.h"

@implementation XYAccountResult

//初始化创建方法
+ (instancetype)accountWithDict:(NSDictionary *)dict{
    XYAccountResult *accountResult = [[self alloc] init];
    [accountResult setValuesForKeysWithDictionary:dict];
    return accountResult;
}


//编码
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:XYAccess_token];
    [aCoder encodeObject:self.expires_in forKey:XYExpires_in];
    [aCoder encodeObject:self.remind_in forKey:XYRemind_in];
    [aCoder encodeObject:self.uid forKey:XYUID];
    [aCoder encodeObject:self.name forKey:XYName];
}

//解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:XYAccess_token];
        self.expires_in = [aDecoder decodeObjectForKey:XYExpires_in];
        self.remind_in = [aDecoder decodeObjectForKey:XYRemind_in];
        self.uid = [aDecoder decodeObjectForKey:XYUID];
        self.name = [aDecoder decodeObjectForKey:XYName];
    }
    return self;
}
@end
