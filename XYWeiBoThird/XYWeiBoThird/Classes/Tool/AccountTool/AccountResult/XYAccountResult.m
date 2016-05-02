//
//  XYAccountResult.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#define XYAccessToken  @"accessToken"
#define XYExpiresIn    @"expires_in"
#define XYRemindIn     @"remind_in"
#define XYUID          @"uid"
#define XYExpiresDate  @"expires_date"
#define XYName         @"name"
#define XYAccounts     @"accounts"
#define XYProfileUrl   @"profile_url"

#import "XYAccountResult.h"

@implementation XYAccountResult

//初始化
+ (instancetype)accountResultWithDict:(NSDictionary *)dict{
    XYAccountResult *accountResult = [[XYAccountResult alloc] init];
    [accountResult setValuesForKeysWithDictionary:dict];
    return accountResult;
}

//设置过期时间
- (void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

//编码
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:XYAccessToken];
    [aCoder encodeObject:self.expires_in forKey:XYExpiresIn];
    [aCoder encodeObject:self.remind_in forKey:XYRemindIn];
    [aCoder encodeObject:self.uid forKey:XYUID];
    [aCoder encodeObject:self.expires_date forKey:XYExpiresDate];
    [aCoder encodeObject:self.name forKey:XYName];
    [aCoder encodeObject:self.profile_url forKey:XYProfileUrl];
}

//解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:XYAccessToken];
        self.expires_in = [aDecoder decodeObjectForKey:XYExpiresIn];
        self.remind_in = [aDecoder decodeObjectForKey:XYRemindIn];
        self.uid = [aDecoder decodeObjectForKey:XYUID];
        self.expires_date = [aDecoder decodeObjectForKey:XYExpiresDate];
        self.name = [aDecoder decodeObjectForKey:XYName];
        self.profile_url = [aDecoder decodeObjectForKey:XYProfileUrl];
    }
    return self;
}

@end
