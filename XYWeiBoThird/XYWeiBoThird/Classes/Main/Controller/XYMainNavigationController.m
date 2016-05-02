//
//  XYMainNavigationController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/24.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYMainNavigationController.h"
#import "UIBarButtonItem+Category.h"
#import "XYTabBar.h"

@interface XYMainNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation XYMainNavigationController


+ (void)initialize{
    //设置标题属性
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrNav = [NSMutableDictionary dictionary];
    attrNav[NSFontAttributeName] = [UIFont systemFontOfSize:18];
//    attrNav[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [navBar setTitleTextAttributes:attrNav];
    navBar.tintColor = [UIColor colorWithWhite:0.386 alpha:1.000];
    
    
    //设置UIBarButtonItem属性
    UIBarButtonItem *barBtnItem = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrBar = [NSMutableDictionary dictionary];
    attrBar[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.386 alpha:1.000];
    attrBar[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [barBtnItem setTitleTextAttributes:attrBar forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.delegate = nil;
}


//隐藏tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    XYLog(@"%ld",self.viewControllers.count);
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //移除系统自带的tabBar
    
    UITabBarController *tabBarController = (UITabBarController *)XYKeyWindow.rootViewController;
    
    for (UIView *view in tabBarController.tabBar.subviews) {
        if (![view isKindOfClass:[XYTabBar class]]) {
            [view removeFromSuperview];
        }
    }
}
//设置手势代理
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.viewControllers[0]) {//是第一个控制器。则还原手势代理
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
@end
