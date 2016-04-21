//
//  XYBadgeView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#define BadgeValueFont [UIFont systemFontOfSize:11]

#import "XYBadgeView.h"

@implementation XYBadgeView


/**
 *  初始化设置按钮的背景
 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = BadgeValueFont;
        [self sizeToFit];
        self.userInteractionEnabled = NO;
    }
    return self;
}

/**
 *  设置BadgeValue的内容
 */
- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
//    判断是否有值，是否隐藏
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
   CGSize valueSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName: BadgeValueFont}];
    //如果value太长，则只显示个小点，清空背景图，数值
    if (valueSize.width > self.frame.size.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }else{//显示数值，设置背景图，清空图片
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}
@end
