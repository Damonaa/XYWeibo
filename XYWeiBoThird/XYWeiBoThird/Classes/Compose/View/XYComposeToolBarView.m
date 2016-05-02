//
//  XYToolBarView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYComposeToolBarView.h"

@implementation XYComposeToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildView];
        
        self.image = [UIImage stretchableImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        self.userInteractionEnabled = YES;
    }
    return self;
}
//添加子控件，按钮
- (void)setupChildView{
    //picture
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_toolbar_picture"] highlightedImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"]];
    
    //@
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]];
    //#
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_trendbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]];
    //表情
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    
    //keyboard
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"]];
}
//添加一个按钮
- (void)setupOneBtnWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = self.subviews.count;
    [self addSubview:btn];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnW = self.width / self.subviews.count;
    CGFloat btnH = 35;
    
    int i = 0;
    for (UIButton *btn in self.subviews) {
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        i ++;
    }
    
}

//响应点击 事件
- (void)clickToolBarBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(toolBarView:didClickBtnAtIndex:)]) {
        [self.delegate toolBarView:self didClickBtnAtIndex:btn.tag];
    }
}
@end
