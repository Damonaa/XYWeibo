//
//  UIBarButtonItem+XYCategory.h
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XYCategory)
/**
 *  创建UIBarButtonItem （UIButton封装）
 *
 *  @param normalImage      正常的图片
 *  @param highligetedImage 高亮的图片
 *  @param action           响应事件
 *  @param event            响应方式
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithNormalImage:(UIImage *)normalImage highligetedImage:(UIImage *)highligetedImage target:(id)target action:(SEL)action events:(UIControlEvents)event;
@end
