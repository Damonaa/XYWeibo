//
//  XYPopListView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/25.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYPopListView.h"

@implementation XYPopListView

//显示
+ (instancetype)popListViewAtRect:(CGRect)rect{
    XYPopListView *popView = [[XYPopListView alloc] initWithFrame:rect];
    popView.image = [UIImage stretchableImage:[UIImage imageNamed:@"popover_background"]];
    popView.userInteractionEnabled = YES;
    
    [XYKeyWindow addSubview:popView];
    
    return popView;
}
//添加View
- (void)setContentView:(UIView *)contentView{
    
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
}

//隐藏
+ (void)hide{
    for (UIView *popView in XYKeyWindow.subviews) {
        if ([popView isKindOfClass:self]) {
            [popView removeFromSuperview];
        }
    }
}
//布局内容的frame
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat y = 9;
    CGFloat w = self.width - margin * 2;
    CGFloat h = self.height - margin - y;
    _contentView.frame = CGRectMake(x, y, w, h);
}
@end
