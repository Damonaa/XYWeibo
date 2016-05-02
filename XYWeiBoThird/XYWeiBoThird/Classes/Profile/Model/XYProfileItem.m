//
//  XYProfileItem.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYProfileItem.h"

@implementation XYProfileItem


/**
 *  item 模型
 *
 *  @param icon     图标
 *  @param title    标题
 *  @param subTitle 子标题
 *
 *  @return XYProfileItem模型
 */
+ (instancetype)profileItemWithIcon:(UIImage *)icon title:(NSString *)title subTitle:(NSString *)subTitle{
    XYProfileItem *profileItem = [self profileItemWithIcon:icon title:title subTitle:subTitle destVC:nil];
    return profileItem;    
}

/**
 *  item 模型
 *
 *  @param icon     图标
 *  @param title    标题
 *  @param subTitle 子标题
 *  @param vc       要跳转到的控制器
 *
 *  @return XYProfileItem模型
 */
+ (instancetype)profileItemWithIcon:(UIImage *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVC:(Class)vcClass{
    XYProfileItem *profileItem = [[self alloc] init];
    profileItem.icon = icon;
    profileItem.title = title;
    profileItem.subTitle = subTitle;
    profileItem.vcClass = vcClass;
    
    return profileItem;
}

@end
