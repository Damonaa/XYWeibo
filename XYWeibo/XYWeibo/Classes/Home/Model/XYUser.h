//
//  XYUser.h
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  微博头像URL
 */
@property (nonatomic, strong) NSURL *profile_image_url;
/**
 *  会员类型 > 2 代表是会员
 */
@property (nonatomic, assign) int mbtype;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  否是会员
 */
@property (nonatomic, assign, getter=isVip) BOOL vip;

@end
