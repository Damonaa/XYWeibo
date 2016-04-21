//
//  XYStatusCacheTool.m
//  Weibo
//
//  Created by 李小亚 on 16/3/23.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatusCacheTool.h"
#import "XYStatusParam.h"
#import "FMDB.h"
#import "XYAccountResult.h"
#import "XYAccountTool.h"
#import "XYStatus.h"
#import "MJExtension.h"

@implementation XYStatusCacheTool


static FMDatabase *_db;

//初始化创建数据库
+ (void)initialize{
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"statuses.sqlite"];
    //1创建 打开数据库
    _db = [FMDatabase databaseWithPath:filePath];
    
    if ([_db open]) {
        NSLog(@"open success");
    }else{
        NSLog(@"open failure");
    }
    
    //2 创建表格
    BOOL flag = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, idstr text, access_token text, dict bolb);"];
    if (flag) {
        NSLog(@"create success");
    }else{
        NSLog(@"create failure");
    }
}

/**
 *  保存数据到本地数据库
 *
 *  @param statuses 字典 数组
 */
+ (void)saveWithStatuses:(NSArray *)statuses{
    
    for (NSDictionary *dict in statuses) {
        NSString *idstr = dict[@"idstr"];
        NSString *accessToken = [XYAccountTool account].access_token;
        
        //字典转二进制
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        
        //写入数据库
        BOOL flag = [_db executeUpdate:@"insert into t_status (idstr, access_token, dict) values (?, ?, ?);", idstr, accessToken, data];
        
        if (flag) {
            NSLog(@"insert success");
        }else{
            NSLog(@"insert failure");
        }
        
    }
    
}

/**
 *  从服务器中获取数据
 *
 *  @param param 请求参数
 *
 *  @return 默认20条数据 模型
 */
+ (NSArray *)stattusesWithParam:(XYStatusParam *)param{
    //查询语句, 首次进入程序 查询20条数据
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;", param.access_token];
    
    if (param.since_id) {//获取新的
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@' order by idstr desc limit 20", param.access_token, param.since_id];
    }else if (param.max_id){//获取旧的
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr < '%@' order by idstr desc limit 20", param.access_token, param.max_id];
    }
    
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *arrayM = [NSMutableArray array];
    //遍历渠道的数据
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        //字典转模型
        XYStatus *status = [XYStatus objectWithKeyValues:dict];
        
        [arrayM addObject:status];
    }
    
    return arrayM;
}

@end
