//
//  XYTabBarButton.h
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
// 自定义按钮， 替换系统的 UIBarButtonItem，
//使用kvo 为自定义按钮赋值

#import <UIKit/UIKit.h>

@interface XYTabBarButton : UIButton

@property (nonatomic, strong) UITabBarItem *tabBarItem;

@end
