//
//  XYStatus.h
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@class XYUser;

@interface XYStatus : NSObject<MJKeyValue>
/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博表态数
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  配图 URL组成 将URL转换成模型 --> XYPhoto
 (thumbnail_pic" = "http://ww3.sinaimg.cn/thumbnail/64d55a7fjw1f23k2qq3krj20c80gfgmz.jpg";)
 */
@property (nonatomic, strong) NSArray *pic_urls;
/**
 *  转发的微博
 */
@property (nonatomic, strong) XYStatus *retweeted_status;
/**
 *  用户
 */
@property (nonatomic, strong) XYUser *user;




@end
