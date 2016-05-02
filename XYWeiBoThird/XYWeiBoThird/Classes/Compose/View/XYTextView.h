//
//  XYTextView.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYTextView : UITextView

/**
 *  占位符
 */
@property (nonatomic, copy) NSString *placeHolder;
/**
 *  是否隐藏占位符，默认NO
 */
@property (nonatomic, assign, getter=isHiddenPlaceHolder) BOOL hiddenPlaceHolder;


@end
