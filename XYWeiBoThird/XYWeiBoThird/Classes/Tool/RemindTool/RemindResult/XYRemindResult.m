//
//  XYRemindResult.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/27.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYRemindResult.h"

@implementation XYRemindResult

/**
 *  信息栏未读的消息数
 * cmt + dm + mention_status + mention_cmt
 *  @return cmt + dm + mention_status + mention_cmt
 */
- (int)messageNum{
    return _cmt + _dm + _mention_status + _mention_cmt;
}
/**
 *  全部的未读消息数
 *
 *  @return all
 */
- (int)totalNum{
    
    return self.messageNum + _status + _follower;
}

@end
