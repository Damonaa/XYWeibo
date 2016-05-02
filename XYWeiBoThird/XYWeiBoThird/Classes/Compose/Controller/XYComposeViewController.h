//
//  XYComposeViewController.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYStatus;

@interface XYComposeViewController : UIViewController

/**
 *  转发微博的文本
 */
@property (nonatomic, copy) NSString *repostText;
/**
 *  转发微博的占位符
 */
@property (nonatomic, copy) NSString *repostPlacehold;
/**
 *  是否是转发微博， 默认是NO
 */
@property (nonatomic, assign, getter=isRepostStatus) BOOL repostStatus;
/**
 *  是否是评论微博，默认是NO
 */
@property (nonatomic, assign, getter=isCommentStatus) BOOL commentStatus;


/**
 *  转发的微博模型
 */
@property (nonatomic, strong) XYStatus *status;

@end
