//
//  XYBaseTableView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYBaseTableViewController.h"
#import "XYProfileGroup.h"
#import "XYProfileViewCell.h"
#import "XYProfileItem.h"

@interface XYBaseTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation XYBaseTableViewController


- (NSMutableArray *)groups{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    
    return _groups;
}
- (instancetype)init{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithWhite:0.865 alpha:1.000];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_groups[section] groupItems].count;
}
//点击表格cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items = [_groups[indexPath.section] groupItems];
    XYProfileItem *profileItem = items[indexPath.row];
    if (profileItem.vcClass) {//有设置下一个控制器
        id vc = [[profileItem.vcClass alloc] init];
        [vc setTitle:profileItem.title];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (profileItem.operationBlock){//有设置block，执行
        profileItem.operationBlock();
    }
}

//设置头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    XYProfileGroup *group = _groups[section];
    return group.headerTitle;
}
//设置尾标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    XYProfileGroup *group = _groups[section];
    return group.footerTitle;
}
@end
