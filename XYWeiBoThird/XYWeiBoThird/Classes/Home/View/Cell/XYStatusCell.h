//
//  XYStatusCell.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYStatusFrame;

@interface XYStatusCell : UITableViewCell

@property (nonatomic, strong) XYStatusFrame *statusFrame;
/**
 *  初始化创建cell
 */
+ (instancetype)statusCellWithTableView:(UITableView *)tableView;

@end
