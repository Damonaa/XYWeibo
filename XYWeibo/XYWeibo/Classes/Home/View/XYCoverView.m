//
//  XYCoverView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYCoverView.h"

@implementation XYCoverView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}


+ (instancetype)show{
    XYCoverView *coverView = [[XYCoverView alloc] init];
    [XYKeyWindow addSubview:coverView];
    return coverView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(coverViewClick:)]) {
        [self.delegate coverViewClick:self];
    }
}

+ (void)hiden{
    for (UIView *view in XYKeyWindow.subviews) {
        if ([view isKindOfClass:self]) {
            [view removeFromSuperview];
        }
    }
}
@end
