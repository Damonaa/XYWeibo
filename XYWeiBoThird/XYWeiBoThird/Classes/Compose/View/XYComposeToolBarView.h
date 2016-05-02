//
//  XYToolBarView.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYComposeToolBarView;

@protocol XYComposeToolBarViewDelegate <NSObject>

- (void)toolBarView:(XYComposeToolBarView *)toolBarView didClickBtnAtIndex:(NSInteger)index;
@end

@interface XYComposeToolBarView : UIImageView

@property (nonatomic, weak) id<XYComposeToolBarViewDelegate> delegate;
@end
