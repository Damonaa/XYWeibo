//
//  AppDelegate.m
//  Weibo
//
//  Created by 李小亚 on 16/3/1.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "AppDelegate.h"
#import "XYRootVCTool.h"
#import "XYOAuthViewController.h"
#import "XYAccountTool.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //获取在icon上显示badgeValue的权限
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    
    [application registerUserNotificationSettings:setting];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //是否有授权，是否保存了账号
    if (![XYAccountTool account]) {//没有 去获取授权
        XYOAuthViewController *oauthVC = [[XYOAuthViewController alloc] init];
        self.window.rootViewController = oauthVC;
    }else{
        //判断版本号，决定根控制器
        [XYRootVCTool setupRootVCWithWindow:self.window];
    }

    [self.window makeKeyAndVisible];
    return YES;
}

//接受到系统的内存警告，结束SDWebImage的任务， 清除内存缓存
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    //提高后台运行的优先级，播放去声音乐
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    player.numberOfLoops = -1;
    [player prepareToPlay];
    [player play];
    self.player = player;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //后台运行
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:task];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 进入到前台后停止播放
    if (self.player.isPlaying) {
        [self.player stop];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
