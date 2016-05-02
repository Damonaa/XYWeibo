//
//  XYCover.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/25.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYCoverDelegate <NSObject>

- (void)coverDidClick;

@end

@interface XYCover : UIView

+ (instancetype)show;

@property (nonatomic, weak) id<XYCoverDelegate> delegate;

@end
