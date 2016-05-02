//
//  XYStatusCacheTool.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatusCacheTool.h"
#import "FMDB.h"
#import "XYAccountTool.h"
#import "XYAccountResult.h"
#import "XYStatusParam.h"
#import "XYStatus.h"

@implementation XYStatusCacheTool

static FMDatabase *_db;
//初始化数据库
+ (void)initialize{
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [dir stringByAppendingPathComponent:@"status.sqlite"];
    //创建数据库
    _db = [FMDatabase databaseWithPath:path];
    //打开数据库
    if ([_db open]) {
        XYLog(@"success");
    }else{
        XYLog(@"failure");
    }
    //创建表格
    BOOL flag = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, idstr text, access_token text, dict bolb);"];
    if (flag) {
        XYLog(@"create succeee");
    }else{
        XYLog(@"create failure");
    }
}

//保存数据到数据库
+ (void)saveWithStatus:(NSArray *)statuses{
    for (NSDictionary *status in statuses) {
        NSString *idStr = status[@"idstr"];
        NSString *accessToken = [XYAccountTool accountResult].access_token;
        //字典转二进制
        NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:status];
        
        BOOL flag = [_db executeUpdate:@"insert into t_status (idstr, access_token, dict) values (?, ?, ?);",idStr, accessToken, dictData];
        
        if (flag) {
            XYLog(@"save success");
        }else{
            XYLog(@"save failure");
        }
    }
}

//取数据
+ (NSArray *)statusesWithParam:(XYStatusParam *)param{
    //首次进入程序，执行此查询//
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;", param.access_token];
    
    if (param.since_id) {
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@' order by idstr desc limit 20;", param.access_token, param.since_id];
    }else if(param.max_id){
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr < '%@' order by idstr desc limit 20;", param.access_token, param.max_id];
    }
    
    FMResultSet *result = [_db executeQuery:sql];
    NSMutableArray *arrayM = [NSMutableArray array];
    while ([result next]) {
        NSData *dictData = [result dataForColumn:@"dict"];
        
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        //字典转模型
        XYStatus *status = [XYStatus mj_objectWithKeyValues:dict];
        [arrayM addObject:status];
    }
    
    return arrayM;
}

@end
