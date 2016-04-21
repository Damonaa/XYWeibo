//
//  XYTabBarButton.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYTabBarButton.h"
#import "XYBadgeView.h"

@interface XYTabBarButton ()

@property (nonatomic, weak) XYBadgeView *badgeView;

@end


@implementation XYTabBarButton

//懒加载 将badgeView添加到自定义的按钮上去
- (XYBadgeView *)badgeView{
    if (!_badgeView) {
        XYBadgeView *badgeView = [XYBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:badgeView];
        self.badgeView = badgeView;
    }
    return _badgeView;
}
//去除按钮的高亮属性
- (void)setHighlighted:(BOOL)highlighted{};
//自定义初始化按钮，设置按钮内部UI的属性
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //title
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        //image
        self.imageView.contentMode = UIViewContentModeCenter;
        
    }
    return self;
}

//重新布局自定义按钮的位置
//图片在上， 文字在下， 右上角为badgeView
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.7;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame);
    CGFloat titleW = imageW;
    CGFloat titleH = self.bounds.size.height - imageH;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat badgeX = imageW - self.badgeView.bounds.size.width - 10;
    CGFloat badgeY = 0;
    self.badgeView.frame = (CGRect){{badgeX, badgeY}, self.badgeView.bounds.size};
}

//KVO 监听系统的 UIBarButtonItem的参数，为自定义的按钮参数赋值
- (void)setTabBarItem:(UITabBarItem *)barButtonItem{
    _tabBarItem = barButtonItem;
#warning !!!
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    //监听title，image selectedImage badgeValue
    [barButtonItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [barButtonItem addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [barButtonItem addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [barButtonItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

//监听的值发生变化，调用才方法，为自定义的按钮赋值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    [self setTitle:_tabBarItem.title forState:UIControlStateNormal];
    [self setImage:_tabBarItem.image forState:UIControlStateNormal];
    [self setImage:_tabBarItem.selectedImage forState:UIControlStateSelected];
    
    self.badgeView.badgeValue = _tabBarItem.badgeValue;
}
@end
