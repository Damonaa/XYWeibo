//
//  XYStatusFrame.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYStatus;

@interface XYStatusFrame : NSObject
/**
 *  一条微博的模型
 */
@property (nonatomic, strong) XYStatus *status;

/***********************原创微博的frame******************************/
/**
 *原创微博的frame
 */
@property (nonatomic, assign) CGRect originalViewFrame;
/**
 *原创微博头像的frame
 */
@property (nonatomic, assign) CGRect originalIconFrame;
/**
 *原创微博昵称的frame
 */
@property (nonatomic, assign) CGRect originalNameFrame;
/**
 *原创微博VIP的frame
 */
@property (nonatomic, assign) CGRect originalVipFrame;
/**
 *原创微博时间的frame
 */
@property (nonatomic, assign) CGRect originalTimeFrame;
/**
 *原创微博来源的frame
 */
@property (nonatomic, assign) CGRect originalSourceFrame;
/**
 *原创微博文字的frame
 */
@property (nonatomic, assign) CGRect originalTextFrame;
/**
 *原创微博图片的frame
 */
@property (nonatomic, assign) CGRect originalPhotosFrame;

/***********************转发微博的frame******************************/
/**
 *转发微博的frame
 */
@property (nonatomic, assign) CGRect retweetedViewFrame;

/**
 *转发微博昵称的frame
 */
@property (nonatomic, assign) CGRect retweetedNameFrame;

/**
 *转发微博文字的frame
 */
@property (nonatomic, assign) CGRect retweetedTextFrame;
/**
 *转发微博图片的frame
 */
@property (nonatomic, assign) CGRect retweetedPhotosFrame;

/***********************工具条的frame******************************/
@property (nonatomic, assign) CGRect toolBarFrame;

/**
 *  行高
 */
@property (nonatomic, assign) CGFloat rowHeight;


@end
