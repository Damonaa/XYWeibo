//
//  XYProfileViewController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/24.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYProfileViewController.h"
#import "XYSettingViewController.h"
#import "XYProfileView.h"
#import "XYUsersTool.h"
#import "XYUsersResult.h"
#import "XYProfileTableViewController.h"
#import "XYAccountTool.h"
#import "XYAccountResult.h"

@interface XYProfileViewController ()
/**
 *  背景视图容器
 */
@property (nonatomic, weak) UIScrollView *bgView;

/**
 *  简介card
 */
@property (nonatomic, weak) XYProfileView *profileView;
/**
 *  展示tableView的容器
 */
@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, strong) XYProfileTableViewController *profileTabelVC;
/**
 *  存放组信息
 */
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation XYProfileViewController

- (NSMutableArray *)groups{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加子控件
    [self setupChildView];
    //赋值
    
    [XYUsersTool getUsersShowWithSuccess:^(XYUsersResult *result) {
        self.profileView.usersResult = result;
        
        //头像的URL赋值给account,保存到沙盒
        XYAccountResult *accountResult = [XYAccountTool accountResult];
        accountResult.profile_url = result.profile_image_url;
        [XYAccountTool saveAccount:accountResult];
        
    } failure:^(NSError *error) {
        XYLog(@"%@", error);
    }];
}
//添加子控件
- (void)setupChildView{
    
    UIScrollView *bgView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgView];
    self.bgView = bgView;
    self.bgView.backgroundColor = [UIColor colorWithWhite:0.865 alpha:1.000];
    self.bgView.contentSize = CGSizeMake(self.view.width, 64 + 105 + 5 * 12 + 11 * 35 + 44);
    self.bgView.showsHorizontalScrollIndicator = NO;
    
    //添加简介card
    XYProfileView *profileView = [[XYProfileView alloc] initWithFrame:CGRectMake(0, 5, XYScreenWidth, 105)];
    profileView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:profileView];
    self.profileView = profileView;
    
    //添加tableView
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_profileView.frame) - 18, self.view.width, 11 * 35 + 30)];
    [self.bgView addSubview:contentView];
//    contentView.backgroundColor = [UIColor magentaColor];
    self.contentView = contentView;
    self.profileTabelVC = [[XYProfileTableViewController alloc] init];
    self.profileTabelVC.view.backgroundColor = [UIColor clearColor];
    [contentView addSubview:_profileTabelVC.view];

    
}

#pragma mark - navigationBtnClick
- (void)rightBtnClick{
    
    XYSettingViewController *settingVC = [[XYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

- (void)leftBtnClick{
    
}


@end
