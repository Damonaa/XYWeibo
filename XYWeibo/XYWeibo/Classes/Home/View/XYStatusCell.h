//
//  XYStatusCell.h
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//  自定义status cell
//  分成三部分  原创微博  转发微博  工具栏
#import <UIKit/UIKit.h>

@class XYStatusFrame;

@interface XYStatusCell : UITableViewCell


@property (nonatomic, strong) XYStatusFrame *statusesFrame;

/**
 *  初始化自定义的cell
 */
+ (instancetype)statusCellWithTableView:(UITableView *)tableView;
@end
