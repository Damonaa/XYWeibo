//
//  UIImage+XYCategory.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "UIImage+XYCategory.h"

@implementation UIImage (XYCategory)


+ (UIImage *)imageWithOringal:(UIImage *)image{
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageStretchableWithImage:(UIImage *)image{
    return [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
}
@end
