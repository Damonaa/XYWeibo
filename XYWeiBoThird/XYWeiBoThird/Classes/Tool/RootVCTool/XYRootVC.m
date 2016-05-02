//
//  XYRootVC.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#define XYBundleVersion @"bundleVersion"

#import "XYRootVC.h"
#import "XYMainTabBarController.h"
#import "XYFeatureViewController.h"

@implementation XYRootVC
/**
 *  设置根控制器
 *
 *  @param window
 */
+ (void)setRootVCWithWindow:(UIWindow *)window{
    //取出当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //取出沙盒之前保存的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:XYBundleVersion];
    
    if ([currentVersion isEqualToString:lastVersion]) {//无新版本
        XYMainTabBarController *tabBarCtr = [[XYMainTabBarController alloc] init];
        
        window.rootViewController = tabBarCtr;
    }else{//新版本
        XYFeatureViewController *featureVC = [[XYFeatureViewController alloc] init];
        window.rootViewController = featureVC;
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:XYBundleVersion];
        
    }
}
@end
