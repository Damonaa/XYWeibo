//
//  XYRepostParam.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/5/1.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYBaseParam.h"

@interface XYRepostParam : XYBaseParam
/**
 *  要转发的微博的id
 */
@property (nonatomic, assign) NSInteger id;
/**
 *  添加转发的文本
 */
@property (nonatomic, copy) NSString *status;
/**
 *  是否在转发的时候同时发表评论，0：否， 1：评论给当前的微博， 2：评论给原微博， 3：都评论
 */
@property (nonatomic, assign) int is_comment;

@end
