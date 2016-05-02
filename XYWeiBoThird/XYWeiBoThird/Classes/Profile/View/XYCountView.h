//
//  XYCountView.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCountView : UIView

/**
 *  类型名称（微博，关注， 粉丝）
 */
@property (nonatomic, copy) NSString *name;

/**
 *  总数目
 */
@property (nonatomic, copy) NSString *count;


@end
