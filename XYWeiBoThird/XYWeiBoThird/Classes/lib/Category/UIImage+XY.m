//
//  UIImage+XY.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/24.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "UIImage+XY.h"

@implementation UIImage (XY)

+ (UIImage *)imageWithOriginal:(UIImage *)image{
    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)stretchableImage:(UIImage *)image{
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
