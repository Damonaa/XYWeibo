//
//  XYComposeToolBar.m
//  Weibo
//
//  Created by 李小亚 on 16/3/22.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYComposeToolBar.h"

@interface XYComposeToolBar ()

/**
 *  存放所有的按钮
 */
@property (nonatomic, strong) NSMutableArray *toolBtns;
@end

@implementation XYComposeToolBar


- (NSMutableArray *)toolBtns{
    if (!_toolBtns) {
        _toolBtns = [NSMutableArray array];
    }
    return _toolBtns;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupAllChildView];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
    }
    return self;
}
//设置子控件
- (void)setupAllChildView{
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_toolbar_picture"] highlightedImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"]];
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]];
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_trendbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]];
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    [self setupOneBtnWithNormalImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"]];
}

//创建一个按钮
- (void)setupOneBtnWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    btn.tag = self.toolBtns.count;
    [self.toolBtns addObject:btn];
    
    [btn addTarget:self action:@selector(toolBtnsClick:) forControlEvents:UIControlEventTouchUpInside];
}

//布局按钮的位置
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnW = XYScreenW / self.toolBtns.count;
    CGFloat btnH = 33;
    
    int i = 0;
    for (UIButton *btn in self.toolBtns) {
        CGFloat btnX = btnW * i;
        
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        i ++;
    }
}

//工具栏按钮的点击
- (void)toolBtnsClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:toolBtn:)]) {
        [self.delegate composeToolBar:self toolBtn:button];
    }
}
@end
