//
//  UIImage+XY.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/24.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XY)
/**
 *  未经渲染的图片
 *
 *  @param image 图片
 *
 *  @return 未经渲染的图片
 */
+ (UIImage *)imageWithOriginal:(UIImage *)image;
/**
 *  拉伸图片
 */
+ (UIImage *)stretchableImage:(UIImage *)image;
@end
