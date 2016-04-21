//
//  XYUnreadCountResult.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYUnreadCountResult.h"

@implementation XYUnreadCountResult
/**
 *  消息badge
 *
 *  @return cmt + dm + mention_status + mention_cmt
 */
- (int)messageCount{
    return _cmt + _dm + _mention_status + _mention_cmt;
}

/**
 *  全部消息数
 */
- (int)totalCount{
    return _status + _follower + self.messageCount;
}
@end
