//
//  XYProfileViewCell.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYProfileItem;

@interface XYProfileViewCell : UITableViewCell

/**
 *  cell 信息模型
 */
@property (nonatomic, strong) XYProfileItem *profileItem;



/**
 *  初始化创建cell
 */
+ (instancetype)profileViewCellWithTableView:(UITableView *)tableView;
@end
