//
//  XYCover.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/25.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYCover.h"

@implementation XYCover

+ (instancetype)show{
    XYCover *cover = [[XYCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [XYKeyWindow addSubview:cover];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.5;
    return cover;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.12 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(coverDidClick)]) {
            [self.delegate coverDidClick];
        }
        
        [self removeFromSuperview];
    }];
}

@end
