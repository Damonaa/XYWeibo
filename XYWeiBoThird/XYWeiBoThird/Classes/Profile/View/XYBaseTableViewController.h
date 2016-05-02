//
//  XYBaseTableView.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYBaseTableViewController : UITableViewController

/**
 *  存放全部的组的items (元素为数组XYSettingGroup ->数组)
 */
@property (nonatomic, strong) NSMutableArray *groups;
@end
