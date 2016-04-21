//
//  XYProfileViewController.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYProfileViewController.h"

@implementation XYProfileViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
}


- (void)rightClick{
    
}

@end
