//
//  XYAccountManageController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYAccountManageController.h"
#import "XYAccountResult.h"
#import "XYAccountTool.h"
#import "UIImageView+WebCache.h"
#import "XYOAuthViewController.h"
#import "XYRootVC.h"

@interface XYAccountManageController ()

@property (nonatomic, strong) NSMutableArray *accountsM;

@end

@implementation XYAccountManageController

- (NSMutableArray *)accountsM{
    if (!_accountsM) {
        _accountsM = [NSMutableArray array];
        
        //取出字典中的值obj(XYAccountResult)赋值给数组
        NSMutableDictionary *dict = [XYAccountTool accountsDict];
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            XYLog(@"%@,   %@", key, obj);
            [_accountsM addObject:obj];
        }];
    }
    
    return _accountsM;
}

- (instancetype)init{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accountsM.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reusedID = @"accountCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
    }
    
    //为cell赋值
    if (indexPath.row < _accountsM.count) {
        XYAccountResult *accountResult = _accountsM[indexPath.row];
        NSURL *url = [NSURL URLWithString:accountResult.profile_url];
        [cell.imageView sd_setImageWithURL:url];
        cell.textLabel.text = accountResult.name;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"compose_trendbutton_background"];
        cell.textLabel.text = @"添加账号";
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//点击某个cell
//这里并不能真正的切换账号
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _accountsM.count) {//添加账号
        //清除account的uid
//        XYAccountResult *currentAccount = [XYAccountTool accountResult];
//        currentAccount.access_token = nil;
//        [XYAccountTool saveAccount:currentAccount];
//        
        //跳转到oath授权
        XYOAuthViewController *oauthVC = [[XYOAuthViewController alloc] init];
        XYKeyWindow.rootViewController = oauthVC;
    }else{//回到主页
        XYAccountResult *accountResult = _accountsM[indexPath.row];
        XYLog(@"%@", accountResult.name);
        [XYRootVC setRootVCWithWindow:XYKeyWindow];
    }
    
}


//可以编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _accountsM.count) {
        return NO;
    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {//删除
        
    }
}
@end
