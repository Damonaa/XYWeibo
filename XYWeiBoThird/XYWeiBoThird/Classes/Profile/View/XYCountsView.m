//
//  XYCountsView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYCountsView.h"
#import "XYCountView.h"
#import "XYUsersResult.h"

@interface XYCountsView ()

/**
 *  微博数
 */
@property (nonatomic, weak) XYCountView *statusesView;
/**
 *  关注数
 */
@property (nonatomic, weak) XYCountView *friendsView;
/**
 *  粉丝数
 */
@property (nonatomic, weak) XYCountView *followersView;
@end

@implementation XYCountsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildView];
    }
    return self;
}

//添加子控件，三个显示总数的countView
- (void)setupChildView{
    XYCountView *statusesView = [[XYCountView alloc] init];
    [self addSubview:statusesView];
    self.statusesView = statusesView;
    statusesView.name = @"微博";
    
    XYCountView *friendsView = [[XYCountView alloc] init];
    [self addSubview:friendsView];
    self.friendsView = friendsView;
    friendsView.name = @"关注";
    
    XYCountView *followersView = [[XYCountView alloc] init];
    [self addSubview:followersView];
    self.followersView = followersView;
    followersView.name = @"粉丝";

}

//设置数目
- (void)setUsersResult:(XYUsersResult *)usersResult{
    _usersResult = usersResult;
    self.statusesView.count = usersResult.statuses_count;
    self.friendsView.count = usersResult.friends_count;
    self.followersView.count = usersResult.followers_count;
}
//布局子控件位置
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat h = 40;
    CGFloat margin = 20;
    CGFloat w = (self.width - margin * 2) / 3;
    CGFloat y = 0;
    int i = 0;
    for (XYCountView *view in self.subviews) {
        if ([view isKindOfClass:[XYCountView class]]) {
            CGFloat x = (w + margin) * i;
            view.frame = CGRectMake(x, y, w, h);
            i ++;
        }
    }
}

@end
