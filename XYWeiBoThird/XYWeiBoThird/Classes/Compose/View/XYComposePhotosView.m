//
//  XYComposePhotosView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYComposePhotosView.h"

@implementation XYComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView{
    for (int i = 0; i < 9; i ++) {
        UIImageView *iv = [[UIImageView alloc] init];
        [self addSubview:iv];
        iv.clipsToBounds = YES;
        iv.contentMode = UIViewContentModeScaleAspectFill;
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat ivWH = (XYScreenWidth - margin * 2) / 3;
    
    for (int i = 0; i < 9; i ++) {
        UIImageView *iv = self.subviews[i];
        
        int row = i / 3;
        int column = i % 3;
        
        CGFloat ivX = (margin + ivWH) * column;
        CGFloat ivY = (margin + ivWH) * row;
        iv.frame = CGRectMake(ivX, ivY, ivWH, ivWH);
    }
}
@end
