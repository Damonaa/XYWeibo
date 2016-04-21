//
//  UIBarButtonItem+XYCategory.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "UIBarButtonItem+XYCategory.h"

@implementation UIBarButtonItem (XYCategory)

+ (UIBarButtonItem *)barButtonItemWithNormalImage:(UIImage *)normalImage highligetedImage:(UIImage *)highligetedImage target:(id)target action:(SEL)action events:(UIControlEvents)event{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highligetedImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:event];
    [btn sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
