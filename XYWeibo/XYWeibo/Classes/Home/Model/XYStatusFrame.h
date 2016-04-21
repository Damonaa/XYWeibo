//
//  XYStatusFrame.h
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
// 视图模型 计算全部UI的frame

#import <Foundation/Foundation.h>

@class XYStatus;

@interface XYStatusFrame : NSObject

/**
 *  微博数据模型
 */
@property (nonatomic, strong) XYStatus *status;

/*******************原创微博的frame*****************/
/**
 *  原创微博的frame
 */
@property (nonatomic, assign) CGRect originalViewFrame;
/**
 *  原创微博icon的frame
 */
@property (nonatomic, assign) CGRect originalIconFrame;
/**
 *  原创微博作者昵称的frame
 */
@property (nonatomic, assign) CGRect originalNameFrame;
/**
 *  原创微博 VIP 的frame
 */
@property (nonatomic, assign) CGRect originalVipFrame;
/**
 *  原创微博 创建时间frame
 */
@property (nonatomic, assign) CGRect originalCreateTimeFrame;
/**
 *  原创微博来源frame
 */
@property (nonatomic, assign) CGRect originalSourceFrame;
/**
 *  原创微博正文frame
 */
@property (nonatomic, assign) CGRect originalTextFrame;
/**
 *  原创微博配图frame
 */
@property (nonatomic, assign) CGRect originalPhotoFrame;

/*******************转发微博的frame*****************/
/**
 *  转发微博的frame
 */
@property (nonatomic, assign) CGRect retweetViewFrame;
/**
 *  转发微博的作者昵称frame
 */
@property (nonatomic, assign) CGRect retweetNameFrame;
/**
 *  转发微博的正文
 */
@property (nonatomic, assign) CGRect retweetTextFrame;
/**
 *  转发微博的配图
 */
@property (nonatomic, assign) CGRect retweetPhotosFrame;

/*******************工具栏的frame*****************/
/**
 *  工具栏的frame
 */
@property (nonatomic, assign) CGRect toolBarFrame;


/**
 *  行高
 */
@property (nonatomic, assign) float rowHeight;

@end
