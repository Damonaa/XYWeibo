//
//  XYCoverView.h
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYCoverView;

@protocol XYCoverViewDelegate <NSObject>

@optional
- (void)coverViewClick:(XYCoverView *)coverView;

@end

@interface XYCoverView : UIView

@property (nonatomic, weak) id<XYCoverViewDelegate> delegate;


+ (instancetype)show;
+ (void)hiden;
@end
