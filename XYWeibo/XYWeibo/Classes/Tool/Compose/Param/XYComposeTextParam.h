//
//  XYComposeTextParam.h
//  Weibo
//
//  Created by 李小亚 on 16/3/23.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYBaseParam.h"

@interface XYComposeTextParam : XYBaseParam

/**
 *  要发布的微博的文本内容， 140字以内
 */
@property (nonatomic, copy) NSString *status;
@end
