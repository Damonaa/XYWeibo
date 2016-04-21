//
//  XYTabBarView.h
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//自定义 tab bar 替换系统自带的TabBar
//上面放置自定义的XYTabBarButton

#import <UIKit/UIKit.h>

@class XYTabBarView;

@protocol XYTabBarViewDelegate <NSObject>

@optional

/**
 *  点击tabBar 切换视图
 *
 *  @param tabBarView tabBarView
 *  @param index      button 的tag
 */
- (void)tabBarView:(XYTabBarView *)tabBarView selectBtn:(NSInteger)index;
/**
 *  点击中间按钮
 */
- (void)tabBarViewCenterBtnClick;
@end


@interface XYTabBarView : UIView


@property (nonatomic, weak) id<XYTabBarViewDelegate> delegate;

/**
 *  存放系统的TabBar item， 用于给自定义的按钮赋值
 */
@property (nonatomic, weak) NSArray *tabBarItems;

@end
