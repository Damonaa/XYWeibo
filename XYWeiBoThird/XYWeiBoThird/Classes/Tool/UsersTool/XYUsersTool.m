//
//  XYUsersTool.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/27.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYUsersTool.h"
#import "XYHttpTool.h"
#import "XYUsersResult.h"
#import "XYAccountTool.h"
#import "XYAccountResult.h"
#import "XYRemindParam.h"

@implementation XYUsersTool


+ (void)getUsersShowWithSuccess:(void (^)(XYUsersResult *result))success failure:(void (^)(NSError *error))failure{
    //请求参数
    XYRemindParam *param = [XYRemindParam baseParam];
    param.uid = [XYAccountTool accountResult].uid;
    
    [XYHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
//        XYLog(@"%@", responseObject);
        
        if (success) {
            XYUsersResult *result = [XYUsersResult mj_objectWithKeyValues:responseObject];
            result.userDescription = responseObject[@"description"];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
