//
//  XYMessageViewController.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYMessageViewController.h"
#import "XYOneVC.h"

@implementation XYMessageViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
}


- (void)rightClick{
    XYOneVC *oneVC = [[XYOneVC alloc] init];
    
    [self.navigationController pushViewController:oneVC animated:YES];
}
@end
