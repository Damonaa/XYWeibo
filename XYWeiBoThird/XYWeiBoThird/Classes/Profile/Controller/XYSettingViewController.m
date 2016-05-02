//
//  XYSettingViewController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/24.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYSettingViewController.h"
#import "XYProfileItem.h"
#import "XYProfileGroup.h"
#import "XYSettingViewCell.h"
#import "XYAccountManageController.h"
#import "XYProfileItemArrow.h"
#import "XYNotifiViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+CZ.h"

@interface XYSettingViewController ()

@property (nonatomic, strong) XYProfileItem *item6;

@end

@implementation XYSettingViewController

- (instancetype)init{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.865 alpha:1.000];
    self.title = @"设置";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    XYProfileItem *item1 = [XYProfileItemArrow profileItemWithIcon:nil title:@"账号管理" subTitle:nil destVC:[XYAccountManageController class]];
    XYProfileItem *item2 = [XYProfileItemArrow profileItemWithIcon:nil title:@"账号安全" subTitle:nil destVC:nil];
    XYProfileGroup *group1 = [[XYProfileGroup alloc] init];
    group1.groupItems = @[item1, item2];
    
    
    XYProfileItem *item3 = [XYProfileItemArrow profileItemWithIcon:nil title:@"通知" subTitle:nil destVC:[XYNotifiViewController class]];
    XYProfileItem *item4 = [XYProfileItemArrow profileItemWithIcon:nil title:@"隐私" subTitle:nil destVC:nil];
    XYProfileItem *item5 = [XYProfileItemArrow profileItemWithIcon:nil title:@"通用设置" subTitle:nil destVC:nil];
    XYProfileGroup *group2 = [[XYProfileGroup alloc] init];
    group2.groupItems = @[item3, item4, item5];
    
    
    __weak typeof(self) weakSelf = self;
    self.item6 = [XYProfileItemArrow profileItemWithIcon:nil title:@"清理缓存" subTitle:[self setupCacheSize] destVC:nil];
    self.item6.operationBlock = ^{//清理缓存

        [MBProgressHUD showMessage:@"清理中..."];
        [[SDImageCache sharedImageCache] clearDisk];
        NSUInteger size = [SDImageCache sharedImageCache].getSize;
        if (size == 0) {//清除成功
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"清理完毕"];
            
            weakSelf.item6.subTitle = @"0KB";
            
            [weakSelf.tableView reloadData];
        }
    };
    
    XYProfileItem *item7 = [XYProfileItemArrow profileItemWithIcon:nil title:@"意见反馈" subTitle:nil destVC:nil];
    XYProfileItem *item8 = [XYProfileItemArrow profileItemWithIcon:nil title:@"关于微博" subTitle:nil destVC:nil];
    XYProfileGroup *group3 = [[XYProfileGroup alloc] init];
    group3.groupItems = @[self.item6, item7, item8];
    
    XYProfileItem *item9 = [XYProfileItemArrow profileItemWithIcon:nil title:nil subTitle:nil destVC:nil];
    XYProfileGroup *group4 = [[XYProfileGroup alloc] init];
    group4.groupItems = @[item9];
    
    [self.groups addObjectsFromArray:@[group1, group2, group3, group4]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - uitableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYSettingViewCell *cell = [XYSettingViewCell settingViewCellWithTableView:tableView];
    
    //最后一组cell上放置按钮
    if (indexPath.section == 3) {
        UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cell.contentView addSubview:logOutBtn];
        [logOutBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [logOutBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [logOutBtn sizeToFit];
        logOutBtn.x = (XYScreenWidth - logOutBtn.width ) / 2;
        logOutBtn.y = (cell.height - logOutBtn.height) / 2;
        
        [logOutBtn addTarget:self action:@selector(logOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        NSArray *items = [self.groups[indexPath.section] groupItems];
        XYProfileItem *profileItem = items[indexPath.row];
        cell.profileItem = profileItem;
    }
    
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 2 && indexPath.row == 0) {
//        [MBProgressHUD showMessage:@"清理中..."];
//        [[SDImageCache sharedImageCache] clearDisk];
//        NSUInteger size = [SDImageCache sharedImageCache].getSize;
//        if (size == 0) {//清除成功
//            [MBProgressHUD hideHUD];
//            [MBProgressHUD showSuccess:@"清理完毕"];
//            //            item6.subTitle = nil;
//            
//            
//            [self.tableView reloadData];
//        }
//    }
//}

//注销
- (void)logOutBtnClick{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

//计算缓存
- (NSString *)setupCacheSize{
    NSString *cacheStr;
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    if (size > 1024 * 1024) {
        CGFloat floatSize = size / 1024.0 / 1024.0;
        cacheStr = [NSString stringWithFormat:@"%.fM",floatSize];
    }else if (size > 1024){
        CGFloat floatSize = size / 1024.0;
        cacheStr = [NSString stringWithFormat:@"%.fKB",floatSize];
    }else if(size > 0)
    {
        cacheStr = [NSString stringWithFormat:@"%ldKB",size];
    }else{
        cacheStr = @"0KB";
    }
    
    return cacheStr;
}
@end
