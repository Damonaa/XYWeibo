//
//  UIImage+XYCategory.h
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYCategory)
/**
 *  设置图片最原始的样式，不渲染
 */
+ (UIImage *)imageWithOringal:(UIImage *)image;
/**
 *  拉伸图片
 */
+ (UIImage *)imageStretchableWithImage:(UIImage *)image;
@end
