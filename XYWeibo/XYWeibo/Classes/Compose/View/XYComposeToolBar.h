//
//  XYComposeToolBar.h
//  Weibo
//
//  Created by 李小亚 on 16/3/22.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYComposeToolBar;

@protocol  XYComposeToolBarDelegate <NSObject>

- (void)composeToolBar:(XYComposeToolBar *)composeToolBar toolBtn:(UIButton *)button;

@end

@interface XYComposeToolBar : UIView


@property (nonatomic, weak) id<XYComposeToolBarDelegate> delegate;
@end
