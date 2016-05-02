//
//  XYTabBarButton.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/24.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYTabBarButton.h"
#import "XYBadgeView.h"

@interface XYTabBarButton ()

@property (nonatomic, weak) XYBadgeView *badgeView;

@end

@implementation XYTabBarButton

- (XYBadgeView *)badgeView{
    if (!_badgeView) {
        XYBadgeView *badgeView = [XYBadgeView buttonWithType:UIButtonTypeCustom];
        _badgeView = badgeView;
        [self addSubview:badgeView];
    }
    return _badgeView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //title 和image的位置
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.height * 0.6;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 4;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}

- (void)setItem:(UITabBarItem *)item{
    _item = item;
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
    self.badgeView.badgeValue = item.badgeValue;
    
    //kvo监听item的变化
    
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

//item的值发生变化，响应
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    self.badgeView.badgeValue = _item.badgeValue;
}

- (void)dealloc{
    //销毁监听
    [self removeObserver:self forKeyPath:@"image"];
    [self removeObserver:self forKeyPath:@"selectedImage"];
    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"badgeValue"];
}
@end
