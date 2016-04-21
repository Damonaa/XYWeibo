//
//  XYPopMenuView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYPopMenuView.h"
#import "UIImage+XYCategory.h"

@implementation XYPopMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage imageStretchableWithImage:[UIImage imageNamed:@"popover_background"]];
    }
    return self;
}

/**
 *  创建并展示视图在rect上
 */
+ (instancetype)popMenuInRect:(CGRect)rect{
    XYPopMenuView *popMenuView = [[XYPopMenuView alloc] initWithFrame:rect];
    
    [XYKeyWindow addSubview:popMenuView];
    
    [popMenuView bringSubviewToFront:XYKeyWindow];
    return popMenuView;
}

/**
 *  隐藏
 */
+ (void)hiden{
    for (UIView *view in XYKeyWindow.subviews) {
        if ([view isKindOfClass:self]) {
            [view removeFromSuperview];
        }
    }
    
}

- (void)setContentView:(UIView *)contentView{
#warning !!!
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
}
/**
 *  布局 contentView 的位置
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat y = 9;
    CGFloat x = 5;
    CGFloat margin = x;
    CGFloat w = self.width - margin * 2;
    CGFloat h = self.height - 9 - margin;
    
    self.contentView.frame = CGRectMake(x, y, w, h);
}
@end
