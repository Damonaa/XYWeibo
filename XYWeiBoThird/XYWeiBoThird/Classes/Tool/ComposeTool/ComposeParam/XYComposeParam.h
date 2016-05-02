//
//  XYComposeParam.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYBaseParam.h"

@interface XYComposeParam : XYBaseParam


/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, copy) NSString *status;
/**
 *  int	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0
 */
@property (nonatomic, strong) NSNumber *visible;

/**
 *
 必选	类型及范围	说明
 access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
 status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 visible	false	int	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0
 */
@end
