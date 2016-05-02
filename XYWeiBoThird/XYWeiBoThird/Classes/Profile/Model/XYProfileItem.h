//
//  XYProfileItem.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OperationBlock)();

@interface XYProfileItem : NSObject
/**
 *  图标
 */
@property (nonatomic, strong) UIImage *icon;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subTitle;
/**
 *  要跳转到的控制器
 */
@property (nonatomic, assign) Class vcClass;


@property (nonatomic, copy) OperationBlock operationBlock;

/**
 *  item 模型
 *
 *  @param icon     图标
 *  @param title    标题
 *  @param subTitle 子标题
 *
 *  @return XYProfileItem模型
 */
+ (instancetype)profileItemWithIcon:(UIImage *)icon title:(NSString *)title subTitle:(NSString *)subTitle;

/**
 *  item 模型
 *
 *  @param icon     图标
 *  @param title    标题
 *  @param subTitle 子标题
 *  @param vc       要跳转到的控制器
 *
 *  @return XYProfileItem模型
 */
+ (instancetype)profileItemWithIcon:(UIImage *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVC:(Class)vc;
@end
