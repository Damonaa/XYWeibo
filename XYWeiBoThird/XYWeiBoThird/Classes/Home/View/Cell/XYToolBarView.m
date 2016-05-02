//
//  XYToolBarView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYToolBarView.h"
#import "XYStatusFrame.h"
#import "XYStatus.h"
#import "XYStatusCell.h"

@interface XYToolBarView ()
@property (nonatomic, weak) UIButton *retweetBtn;

@property (nonatomic, weak) UIButton *commentBtn;

@property (nonatomic, weak) UIButton *unlikeBtn;

/**
 *  存放按钮
 */
@property (nonatomic, strong) NSMutableArray *btns;
/**
 *  存放分割线
 */
@property (nonatomic, strong) NSMutableArray *lines;
@end

@implementation XYToolBarView


- (NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)lines{
    if (!_lines) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage stretchableImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        //        设置子控件， 三个按钮
        [self setupAllChildView];
        
    }
    return self;
}

//        设置子控件， 三个按钮
- (void)setupAllChildView{
    UIButton *retweetBtn = [self setupOneBtnWithImage:[UIImage imageNamed:@"timeline_icon_retweet"] title:@"转发"];
    self.retweetBtn = retweetBtn;
    
    
    UIButton *commentBtn = [self setupOneBtnWithImage:[UIImage imageNamed:@"timeline_icon_comment"] title:@"评论"];
    self.commentBtn = commentBtn;
    
    UIButton *unlikeBtn = [self setupOneBtnWithImage:[UIImage imageNamed:@"timeline_icon_unlike"] title:@"赞"];
    self.unlikeBtn = unlikeBtn;
    
    for (int i = 0; i < 2; i ++) {
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        
        [self.lines addObject:line];
        [self addSubview:line];
        
    }
}
//创建一个按钮
- (UIButton *)setupOneBtnWithImage:(UIImage *)image title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.tag = self.btns.count;
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    [btn addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
//布局按钮的位置
- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger count = self.btns.count;
    
    CGFloat btnW = self.bounds.size.width / count;
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    int i = 0;
    for (UIButton *btn in self.btns) {
        btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i ++;
    }
    
    int j = 1;
    for (UIImageView *imageView in self.lines) {
        UIButton *btn = self.btns[j];
        imageView.x = btn.x;
        j ++;
    }
    
}

//设置按钮上的文字
- (void)setStatusFrame:(XYStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    XYStatus *status = statusFrame.status;
    
    [self setButton:self.retweetBtn count:status.reposts_count];
    [self setButton:self.commentBtn count:status.comments_count];
    [self setButton:self.unlikeBtn count:status.attitudes_count];
    
}
//设置按钮的title
- (void)setButton:(UIButton *)btn count:(int)count{
    if (count == 0) {
        return;
    }
    if (count >= 10000) {
        float i = (float)count / 10000;
        NSString *countStr =[NSString stringWithFormat:@"%.1fw", i];
        [countStr stringByReplacingOccurrencesOfString:@"0" withString:@""];
        [btn setTitle:countStr forState:UIControlStateNormal];
        
    }else{
        [btn setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
    }
    
}

//响应工具栏按钮的点击
- (void)clickToolBarBtn:(UIButton *)button{
    XYStatusCell *cell = (XYStatusCell *)button.superview.superview.superview;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickToolBarBtn" object:self userInfo:@{@"clickToolBarBtn": @(button.tag), @"clickCell": cell}];
}
@end
