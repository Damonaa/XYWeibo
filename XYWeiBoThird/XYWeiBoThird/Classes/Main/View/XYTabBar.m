//
//  XYTabBar.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/24.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYTabBar.h"
#import "XYTabBarButton.h"

@interface XYTabBar ()
/**
 *  中间的按钮
 */
@property (nonatomic, weak) UIButton *centerBtn;
/**
 *  存放自定义的按钮
 */
@property (nonatomic, strong) NSMutableArray *btns;

/**
 *  选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation XYTabBar

- (NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (UIButton *)centerBtn{
    if (!_centerBtn) {
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:centerBtn];
        [centerBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [centerBtn setImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [centerBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [centerBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [centerBtn sizeToFit];
        self.centerBtn = centerBtn;
        
        [centerBtn addTarget:self action:@selector(centerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

- (void)setTabBarBtns:(NSArray *)tabBarBtns{
    _tabBarBtns = tabBarBtns;
    
    for (UITabBarItem *item in tabBarBtns) {
        XYTabBarButton *btn = [XYTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = item;
        btn.tag = self.btns.count;
        [self.btns addObject:btn];
        [self addSubview:btn];
        
        
        [btn addTarget:self action:@selector(clickTabBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage stretchableImage:[UIImage imageNamed:@"tabbar_background"]];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat itemW = w / (self.btns.count + 1);
    CGFloat itemH = h;
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    
    int i = 0;
    for (XYTabBarButton *btn in self.btns) {
        
        if (i == 0) {
            [self clickTabBarBtn:btn];
        }
        
        if (i == 2) {
            i = 3;
        }
        itemX = itemW * i;
        btn.frame = CGRectMake(itemX, itemY, itemW, itemH);

        i ++;
        
    }
    
    self.centerBtn.center = CGPointMake(w / 2, h / 2);
}

- (void)centerBtnClick{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickCenterBtn)]) {
        [self.delegate tabBarDidClickCenterBtn];
    }
}


- (void)clickTabBarBtn:(XYTabBarButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickTabBarItemWithIndex:)]) {
        [self.delegate tabBarDidClickTabBarItemWithIndex:btn.tag];
    }
}
@end
