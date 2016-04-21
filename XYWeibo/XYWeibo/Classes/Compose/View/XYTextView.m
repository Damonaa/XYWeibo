//
//  XYTextView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/22.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYTextView.h"

@interface XYTextView ()

@property (nonatomic, weak) UILabel *placeHoldLabel;

@end

@implementation XYTextView

//添加placeHoldLabel
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *placeHL = [[UILabel alloc] init];
        [self addSubview:placeHL];
        self.placeHoldLabel = placeHL;
    }
    return self;
}
//设置placeHoldLabel的original
- (void)setPlaceHoldLabel:(UILabel *)placeHoldLabel{
    _placeHoldLabel = placeHoldLabel;
    _placeHoldLabel.x = 5;
    _placeHoldLabel.y = 7;
}
//设置placeHoldLabel的内容，size
- (void)layoutSubviews{
    [super layoutSubviews];
    self.placeHoldLabel.text = self.placeHold;
    [self.placeHoldLabel sizeToFit];
}

//设置placeHoldLabel的字体 使之与UITextView一致
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeHoldLabel.font = font;
}
//placeHoldLabel隐藏
- (void)setHidenPlaceHoldLabel:(BOOL)hidenPlaceHoldLabel{
    _hidenPlaceHoldLabel = hidenPlaceHoldLabel;
    self.placeHoldLabel.hidden = hidenPlaceHoldLabel;
}
@end
