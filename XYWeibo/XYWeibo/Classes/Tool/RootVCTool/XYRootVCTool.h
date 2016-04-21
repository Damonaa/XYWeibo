//
//  XYRootVCTool.h
//  Weibo
//
//  Created by 李小亚 on 16/3/19.
//  Copyright © 2016年 李小亚. All rights reserved.
//判断是否进入新特性界面

#import <Foundation/Foundation.h>

@interface XYRootVCTool : NSObject

/**
 *  判断版本号，决定根控制器
 *
 *  @param window 主窗口
 */
+ (void)setupRootVCWithWindow:(UIWindow *)window;

@end
