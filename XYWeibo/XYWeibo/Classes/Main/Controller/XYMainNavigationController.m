//
//  XYMainNavigationController.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYMainNavigationController.h"

@interface XYMainNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDeleagte;

@end

@implementation XYMainNavigationController

//初始化设置UIBarButtonItem的字体颜色 大小
+ (void)initialize{
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = XYNavItemFont;
    attr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [barButtonItem setTitleTextAttributes:attr forState:UIControlStateNormal];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //保存系统的手势滑动代理
    self.popDeleagte = self.interactivePopGestureRecognizer.delegate;
    //移除手势滑动的代理，即使自定义返回按钮，依旧可以手势返回
//    self.interactivePopGestureRecognizer.delegate = nil;
    
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
//    NSLog(@"%ld", self.viewControllers.count);
    
//    不是跟视图的时候隐藏tab bar view
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate
//移除底部的tab bar view上系统自带的UITabBarButton
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UITabBarController *tabBarCtr = (UITabBarController *)XYKeyWindow.rootViewController;
    
    for (UIView *tabBarItem in tabBarCtr.tabBar.subviews) {
        if ([tabBarItem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarItem removeFromSuperview];
        }
    }
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //如果是根视图控制器，还原手势滑动代理
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popDeleagte;
    }else{//其他情况 移除手势代理
        //移除手势滑动的代理，即使自定义返回按钮，依旧可以手势返回
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
@end
