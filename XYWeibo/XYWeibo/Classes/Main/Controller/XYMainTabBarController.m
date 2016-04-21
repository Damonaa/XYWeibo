//
//  XYMainTabBarController.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYMainTabBarController.h"
#import "UIImage+XYCategory.h"
#import "XYTabBarView.h"
#import "XYMainNavigationController.h"
#import "XYHomeViewController.h"
#import "XYMessageViewController.h"
#import "XYProfileViewController.h"
#import "XYDiscoverViewController.h"
#import "XYUnreadCountTool.h"
#import "XYUnreadCountResult.h"
#import "XYComposeViewController.h"

@interface XYMainTabBarController ()<XYTabBarViewDelegate>

/**
 *  存放系统的tabBarItem， (UITabBarItem)
 */
@property (nonatomic, strong) NSMutableArray *tabBarItems;

@property (nonatomic, strong) XYHomeViewController *home;
@property (nonatomic, strong) XYMessageViewController *message;
@end

@implementation XYMainTabBarController

- (NSMutableArray *)tabBarItems{
    if (!_tabBarItems) {
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    NSMutableDictionary *att = [NSMutableDictionary dictionary];
//    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    [[UITabBarItem appearance] setTitleTextAttributes:att forState:UIControlStateSelected];
    
    //1, 设置全部的子控制器
    [self setupAllChildVC];
    //2, 设置 TabBarView
    [self setupTabBarView];
    
    //设置定时器 更新检测用户未读消息数
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateUnreadCount) userInfo:nil repeats:YES];
    
}
//更新检测用户未读消息数
- (void)updateUnreadCount{
    //设置 badgeValue
    [XYUnreadCountTool unreadCountWithSuccess:^(XYUnreadCountResult *result) {
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
    } failure:^(NSError *error) {
        NSLog(@"unreadCount :%@", error);
    }];
}
// 设置 TabBarView
- (void)setupTabBarView{
    XYTabBarView *tabBarView = [[XYTabBarView alloc] initWithFrame:self.tabBar.bounds];
    tabBarView.tabBarItems = self.tabBarItems;
    tabBarView.delegate = self;
    [self.tabBar addSubview:tabBarView];
//    [self.tabBar removeFromSuperview];
}

//设置全部的子控制器
- (void)setupAllChildVC{
    XYHomeViewController *home = [[XYHomeViewController alloc] init];
    [self setupOneChildVC:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"] title:@"主页"];
    self.home = home;
    
    XYMessageViewController *message = [[XYMessageViewController alloc] init];
    message.view.backgroundColor = [UIColor orangeColor];
//    message.tabBarItem.badgeValue = @"11";
    [self setupOneChildVC:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"] title:@"消息"];
    self.message = message;
    
    XYDiscoverViewController *discover = [[XYDiscoverViewController alloc] init];
    discover.view.backgroundColor = [UIColor yellowColor];
//    discover.tabBarItem.badgeValue = @"10";
    [self setupOneChildVC:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected"] title:@"发现"];
    
    XYProfileViewController *profile = [[XYProfileViewController alloc] init];
    profile.view.backgroundColor = [UIColor greenColor];
    [self setupOneChildVC:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected"] title:@"我"];
}

//设置一个子控制器
- (void)setupOneChildVC:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = [UIImage imageWithOringal:selectedImage];
    
    //将创建的 系统的 tabBarItem添加到数组
    [self.tabBarItems addObject:vc.tabBarItem];
    
    XYMainNavigationController *nav = [[XYMainNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - XYTabBarViewDelegate
//切换视图控制器
- (void)tabBarView:(XYTabBarView *)tabBarView selectBtn:(NSInteger)index{
    
    //index == 0 当前页面是第0页
    if (self.selectedIndex == 0 && index == 0) {
        [self.home refreshStatus];
    }
    
    self.selectedIndex = index;
}

- (void)tabBarViewCenterBtnClick{
    NSLog(@"%s", __func__);
    
    XYComposeViewController *composeVC = [[XYComposeViewController alloc] init];
    XYMainNavigationController *nav = [[XYMainNavigationController alloc] initWithRootViewController:composeVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}
@end
