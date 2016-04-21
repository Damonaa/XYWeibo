//
//  XYToolBarView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYToolBarView.h"
#import "UIImage+XYCategory.h"

@interface XYToolBarView ()

/**
 *  转发按钮
 */
@property (nonatomic, weak) UIButton *retweetBtn;
/**
 *  评论按钮
 */
@property (nonatomic, weak) UIButton *commentBtn;
/**
 *  点赞按钮
 */
@property (nonatomic, weak) UIButton *unlikeBtn;

/**
 *  全部的工具按钮
 */
@property (nonatomic, strong) NSMutableArray *btns;

/**
 *  全部的分割线
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
        self.image = [UIImage imageStretchableWithImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        [self setupAllChildView];
        
    }
    return self;
}

//添加子控件
- (void)setupAllChildView{
    UIButton *retweetBtn = [self setupToolBtnWithNormalImage:[UIImage imageNamed:@"timeline_icon_retweet"] title:@"转发"];
    self.retweetBtn = retweetBtn;
    
    UIButton *commentBtn = [self setupToolBtnWithNormalImage:[UIImage imageNamed:@"timeline_icon_comment"] title:@"评论"];
    self.commentBtn = commentBtn;
    
    UIButton *unlikeBtn = [self setupToolBtnWithNormalImage:[UIImage imageNamed:@"timeline_icon_unlike"] title:@"赞"];
    self.unlikeBtn = unlikeBtn;
    
    for (int i = 0; i < 2; i ++) {
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self.lines addObject:line];
        [self addSubview:line];
    }
    
}
//布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnW = XYScreenW / self.btns.count;
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    //布局按钮的位置
    int i = 0;
    for (UIButton *btn in self.btns) {
        
        btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        i ++;
    }
    
    //布局分割线的位置
    int j = 0;
    for (UIImageView *iv in self.lines) {
        UIButton *btn = self.btns[j+1];
        iv.x = btn.x;
        j ++;
    }
}

/**
 *  创建一个按钮
 *
 *  @param normalImage normal状态下的图片
 */
- (UIButton *)setupToolBtnWithNormalImage:(UIImage *)normalImage title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    [self addSubview:btn];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    btn.tag = self.btns.count;
    [self.btns addObject:btn];
    
    [btn addTarget:self action:@selector(toolBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

//点击按钮
- (void)toolBarBtnClick:(UIButton *)button{
    NSLog(@"%s --- %ld", __func__, button.tag);
}

@end
