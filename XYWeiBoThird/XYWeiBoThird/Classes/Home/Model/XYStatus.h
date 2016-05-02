//
//  XYStatus.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYUser;

@interface XYStatus : NSObject
/**
 *  转发的微博
 */
@property (nonatomic, strong) XYStatus *retweeted_status;
/**
 *  用户
 */
@property (nonatomic, strong) XYUser *user;
/**
 *  微博创建的时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  点赞数
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  配图 (XYPhoto) 需要将其成员转换为模型
 */
@property (nonatomic, strong) NSArray *pic_urls;
@end
