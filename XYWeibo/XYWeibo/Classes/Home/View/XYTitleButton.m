//
//  XYTitleButton.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYTitleButton.h"

@implementation XYTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.currentImage == nil) {
        return;
    }
    
    //重新布局title与image的位置
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    [self sizeToFit];
}
@end
