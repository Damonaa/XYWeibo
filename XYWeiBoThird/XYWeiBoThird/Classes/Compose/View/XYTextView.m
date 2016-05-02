//
//  XYTextView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYTextView.h"

@interface XYTextView ()
/**
 *  占位标签
 */
@property (nonatomic, weak) UILabel *placeLable;

@end

@implementation XYTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        
        [self setupChildView];
    }
    return self;
}
//添加label
- (void)setupChildView{
    UILabel *placeLable = [[UILabel alloc] init];
    self.placeLable = placeLable;
    [self addSubview:placeLable];
    placeLable.textColor = [UIColor lightGrayColor];
    placeLable.textAlignment = NSTextAlignmentLeft;
    
}

//设置label的内容
- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.placeLable.text = placeHolder;
    [self.placeLable sizeToFit];
}

- (void)setHiddenPlaceHolder:(BOOL)hiddenPlaceHolder{
    _hiddenPlaceHolder = hiddenPlaceHolder;
    
    self.placeLable.hidden = hiddenPlaceHolder;
}
//设置label的origin
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.placeLable.x = 5;
    self.placeLable.y = 7;
    
}
//设置label和textView的字体一致
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeLable.font = font;
}
@end
