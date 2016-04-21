//
//  XYRootVCTool.m
//  Weibo
//
//  Created by 李小亚 on 16/3/19.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#define VersionKey @"versionKey"

#import "XYRootVCTool.h"
#import "XYMainTabBarController.h"
#import "XYNewFeatureController.h"

@implementation XYRootVCTool


+ (void)setupRootVCWithWindow:(UIWindow *)window{
    //判断版本号，决定根控制器
    //1，当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //2，获取之前存储的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];
    //3, 比较
    if ([currentVersion isEqualToString:lastVersion]) {
        XYMainTabBarController *mainController = [[XYMainTabBarController alloc] init];
        
        window.rootViewController = mainController;
    }else{//新的版本号，重新存储
        XYNewFeatureController *newFeatureController = [[XYNewFeatureController alloc] init];
        
        window.rootViewController = newFeatureController;
        
        //2,保存 （偏好设置存储）
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VersionKey];
    }
}
@end
