//
//  XYTextView.h
//  Weibo
//
//  Created by 李小亚 on 16/3/22.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYTextView : UITextView

/**
 *  占位符
 */
@property (nonatomic, copy) NSString *placeHold;
/**
 *  隐藏占位符
 */
@property (nonatomic, assign) BOOL hidenPlaceHoldLabel;

@end
