//
//  XYCommentParam.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/5/2.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYBaseParam.h"

@interface XYCommentParam : XYBaseParam
/**
 *  string	评论内容，必须做URLencode，内容不超过140个汉字
 */
@property (nonatomic, copy) NSString *comment;
/**
 *  int64	需要评论的微博ID
 */
@property (nonatomic, assign) NSInteger id;
/**
 *  int	当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0
 */
@property (nonatomic, assign) int comment_ori;


/**
 *
 必选	类型及范围	说明
 access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
 comment	true	string	评论内容，必须做URLencode，内容不超过140个汉字。
 id	true	int64	需要评论的微博ID。
 comment_ori	false	int	当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0。
 rip	false	string	开发者上报的操作用户真实IP，形如：211.156.0.1。
 */
@end
