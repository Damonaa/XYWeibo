//
//  XYComposePhotosView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/23.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYComposePhotosView.h"

@interface XYComposePhotosView ()


@end

@implementation XYComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        创建9个imageView
        for (int i = 0 ; i < 9; i ++) {
            UIImageView *iv = [[UIImageView alloc] init];
            iv.contentMode = UIViewContentModeScaleToFill;
            iv.clipsToBounds = YES;
            [self addSubview:iv];
        }
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat ivWH = (XYScreenW - margin * 2) / 3;
    
    int i = 0;
    for (UIImageView *iv in self.subviews) {
        
        int colume = i % 3;
        int row = i / 3;
        CGFloat ivX = (ivWH + margin) * colume;
        CGFloat ivY = (ivWH + margin) * row;
        iv.frame = CGRectMake(ivX, ivY, ivWH, ivWH);
        
        i ++;
    }
}
@end
