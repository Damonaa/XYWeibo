//
//  XYPopListView.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/25.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPopListView : UIImageView
/**
 *  存放内容的容器
 */
@property (nonatomic, weak) UIView *contentView;

+ (instancetype)popListViewAtRect:(CGRect)rect;

+ (void)hide;
@end
