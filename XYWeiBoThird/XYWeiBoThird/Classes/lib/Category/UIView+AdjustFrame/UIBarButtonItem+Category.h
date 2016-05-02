//
//  UIBarButtonItem+Category.h
//  Weibo
//
//  Created by 李小亚 on 16/3/2.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Category)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action controlEvent:(UIControlEvents )controlEvent;
@end
