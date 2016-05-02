//
//  XYIntervalViewController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/5/1.
//  Copyright © 2016年 李小亚. All rights reserved.
//



#import "XYIntervalViewController.h"
#import "XYProfileItem.h"
#import "XYProfileGroup.h"
#import "XYSettingViewCell.h"

@interface XYIntervalViewController ()
/**
 *  被选中的cell
 */
@property (nonatomic, strong) UITableViewCell *selectedCell;

@end

@implementation XYIntervalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XYProfileItem *item1 = [XYProfileItem profileItemWithIcon:nil title:@"每半分钟" subTitle:nil destVC:nil];
    XYProfileItem *item2 = [XYProfileItem profileItemWithIcon:nil title:@"每2分钟" subTitle:nil destVC:nil];
    XYProfileItem *item3 = [XYProfileItem profileItemWithIcon:nil title:@"每5分钟" subTitle:nil destVC:nil];
    XYProfileItem *item4 = [XYProfileItem profileItemWithIcon:nil title:@"关闭" subTitle:nil destVC:nil];
    XYProfileGroup *group1 = [[XYProfileGroup alloc] init];
    group1.groupItems = @[item1,item2, item3, item4];
    
    [self.groups addObject:group1];
}

#pragma mark - uitableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYSettingViewCell *cell = [XYSettingViewCell settingViewCellWithTableView:tableView];
    
    NSArray *items = [self.groups[indexPath.section] groupItems];
    XYProfileItem *profileItem = items[indexPath.row];
    cell.profileItem = profileItem;

    //从偏好设置中取保存的index
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:XYSelectedIndex];
    if (indexPath.row == index) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        self.selectedCell = cell;
    }
    
    return cell;
}

//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectedCell setAccessoryType:UITableViewCellAccessoryNone];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    self.selectedCell = cell;
    
    //保存选中的cell
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:XYSelectedIndex];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //发出通知，选中某个cell
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedInterval" object:nil userInfo:@{@"selectedInterval": @(indexPath.row)}];
}

@end
