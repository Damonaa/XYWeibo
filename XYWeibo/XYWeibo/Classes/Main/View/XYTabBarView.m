//
//  XYTabBarView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYTabBarView.h"
#import "XYTabBarButton.h"

@interface XYTabBarView ()

/**
 *  自定义tabBarButton按钮 （XYTabBarButton）
 */
@property (nonatomic, strong) NSMutableArray *tabBarButtons;

/**
 *  中间的按钮
 */
@property (nonatomic, weak) UIButton *centerBtn;

/**
 *  选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation XYTabBarView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    }
    return self;
}

- (NSMutableArray *)tabBarButtons{
    if (!_tabBarButtons) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

/**
 *  变量系统传过来的UITabBarItem， 为自定义的button赋值
 */
- (void)setTabBarItems:(NSArray *)tabBarItems{
    _tabBarItems = tabBarItems;
    
    for (UITabBarItem *item in tabBarItems) {
        XYTabBarButton *btn = [XYTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.tabBarItem = item;
        btn.tag = self.tabBarButtons.count;
        [self.tabBarButtons addObject:btn];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(selectedBtnChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (UIButton *)centerBtn{
    if (!_centerBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(centerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        [self addSubview:btn];
        _centerBtn = btn;
    }
    return _centerBtn;
}

/**
 *  布局自定义按钮的位置
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    CGFloat w =  viewW / (self.tabBarButtons.count + 1);
    CGFloat h = viewH;
    CGFloat x = 0;
    CGFloat y = 0;
    
    int i = 0;
    for (XYTabBarButton *btn in self.tabBarButtons) {
        
        if (i == 2) {
            i = 3;
        }
        
        if (i == 0) {
            [self selectedBtnChange:btn];
        }
        
        x = w * i;
        btn.frame = CGRectMake(x, y, w, h);
        
        i ++;
    }
    
    self.centerBtn.center = CGPointMake(viewW / 2, viewH / 2);
//    
//    NSLog(@"%@", NSStringFromCGPoint(self.center));
//    
//    NSLog(@"%lf,  %lf", viewW, viewH);
}

/**
 *  响应自定义按钮的切换，切换视图控制器
 */
- (void)selectedBtnChange:(UIButton *)button{
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(tabBarView:selectBtn:)]) {
        [self.delegate tabBarView:self selectBtn:button.tag];
    }
}

/**
 *  点击中间按钮
 */
- (void)centerBtnClick{
    if ([self.delegate respondsToSelector:@selector(tabBarViewCenterBtnClick)]) {
        [self.delegate tabBarViewCenterBtnClick];
    }
    
}

@end
