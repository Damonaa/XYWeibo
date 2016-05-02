//
//  XYMainTabBarController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/23.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYMainTabBarController.h"
#import "XYTabBar.h"
#import "XYMainNavigationController.h"
#import "XYHomeViewController.h"
#import "XYProfileViewController.h"
#import "XYDiscoverViewController.h"
#import "XYRemindTool.h"
#import "XYRemindResult.h"
#import "XYComposeViewController.h"

@interface XYMainTabBarController ()<XYTabBarDelegate>
/**
 *  存放控制器的tabBarItem
 */
@property (nonatomic, strong) NSMutableArray *items;
/**
 *  主页
 */
@property (nonatomic, strong) XYHomeViewController *homeVC;
/**
 *  消息
 */
@property (nonatomic, strong) UIViewController *messageVC;
/**
 *  发现
 */
@property (nonatomic, strong) XYDiscoverViewController *discoverVC;
/**
 *  我
 */
@property (nonatomic, strong) XYProfileViewController *profileVC;
/**
 *  重复提醒时间间隔
 */
@property (nonatomic, assign) NSInteger updateInterval;

@end

@implementation XYMainTabBarController


- (NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
//初始化设置字体颜色
+ (void)initialize{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [tabBarItem setTitleTextAttributes:attr forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupAllViewController];
    
    //添加自定义的tabBar
    XYTabBar *tabBar = [[XYTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.tabBarBtns = self.items;
    [self.tabBar addSubview:tabBar];
    tabBar.delegate = self;
//添加定时器
    [self setupTimer];
}

#pragma mark - 添加定时器
- (void)setupTimer{
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:XYSelectedIndex];
    switch (index) {
        case 0:
            self.updateInterval = 30;
            break;
            
        case 1:
            self.updateInterval = 120;
            break;
            
        case 2:
            self.updateInterval = 300;
            break;
            
        case 3:
            self.updateInterval = MAXFLOAT;
            break;
        default:
            self.updateInterval = 30;
            break;
    }
    
    //添加定时器，检测是否有未读消息
    NSTimer *timer = [NSTimer timerWithTimeInterval:_updateInterval target:self selector:@selector(checkingRemind) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    XYLog(@"%ld", _updateInterval);
}
#pragma  mark  - 检测是否有未读消息
- (void)checkingRemind{
    [XYRemindTool getUnreadStatusesSuccess:^(XYRemindResult *result) {
//        XYLog(@"%@", result);
        
        self.homeVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        self.messageVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageNum];
        self.profileVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalNum;
        
    } failure:^(NSError *error) {
        XYLog(@"%@", error);
    }];
}

#pragma  mark  - 添加控制器
- (void)setupAllViewController{
    self.homeVC = [[XYHomeViewController alloc] init];
    [self setupOneViewControllerWithVC:self.homeVC image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"] title:@"主页"];
    
    
    self.messageVC = [[UIViewController alloc] init];
    [self setupOneViewControllerWithVC:self.messageVC image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"] title:@"消息"];
    self.messageVC.view.backgroundColor = [UIColor whiteColor];
    
    self.discoverVC = [[XYDiscoverViewController alloc] init];
    
    [self setupOneViewControllerWithVC:self.discoverVC image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected"] title:@"发现"];
    self.discoverVC.view.backgroundColor = [UIColor blueColor];
    
    self.profileVC = [[XYProfileViewController alloc] init];
    
    [self setupOneViewControllerWithVC:self.profileVC image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected"] title:@"我"];
}

//创建一个子控制器
- (void)setupOneViewControllerWithVC:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    
    vc.tabBarItem.image = image;
//    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.selectedImage = [UIImage imageWithOriginal:selectedImage];
    vc.title = title;
    [self.items addObject:vc.tabBarItem];
    
    XYMainNavigationController *mainNav = [[XYMainNavigationController alloc] initWithRootViewController:vc];
    
    
    [self addChildViewController:mainNav];
}


#pragma mark - XYTabBarDelegate
- (void)tabBarDidClickCenterBtn{
    XYComposeViewController *composeVC = [[XYComposeViewController alloc] init];
     XYMainNavigationController *mainNav = [[XYMainNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:mainNav animated:YES completion:nil];
}
- (void)tabBarDidClickTabBarItemWithIndex:(NSInteger)index{
    self.selectedIndex = index;
    if (index == 0 && self.selectedIndex == 0) {
        [self.homeVC refreshTableViewHeader];
    }
    
}

@end
