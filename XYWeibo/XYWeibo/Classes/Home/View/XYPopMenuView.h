//
//  XYPopMenuView.h
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPopMenuView : UIImageView

/**
 *  展示内容
 */
@property (nonatomic, weak) UIView *contentView;

/**
 *  创建并展示视图在rect上
 */
+ (instancetype)popMenuInRect:(CGRect)rect;

/**
 *  隐藏
 */
+ (void)hiden;
@end
