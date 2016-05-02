//
//  XYTabBar.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/24.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYTabBarDelegate <NSObject>

- (void)tabBarDidClickCenterBtn;
- (void)tabBarDidClickTabBarItemWithIndex:(NSInteger)index;

@end

@interface XYTabBar : UIImageView

@property (nonatomic, weak) id<XYTabBarDelegate> delegate;

/**
 *  存放控制器传来的tabBarItem
 */
@property (nonatomic, strong) NSArray *tabBarBtns;

@end
