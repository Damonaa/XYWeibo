//
//  XYRemindTool.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/27.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYRemindTool.h"
#import "XYHttpTool.h"
#import "XYRemindParam.h"
#import "XYRemindResult.h"
#import "XYAccountTool.h"
#import "XYAccountResult.h"

@implementation XYRemindTool

+ (void)getUnreadStatusesSuccess:(void (^)(XYRemindResult *result))success failure:(void (^)(NSError *error))failure{
    //请求参数
    XYRemindParam *param = [XYRemindParam baseParam];
    param.uid = [XYAccountTool accountResult].uid;
    
    [XYHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
        if (success) {
            XYRemindResult *result = [XYRemindResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
