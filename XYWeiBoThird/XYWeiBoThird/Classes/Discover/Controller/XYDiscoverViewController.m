//
//  XYDiscoverViewController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/25.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYDiscoverViewController.h"
#import "XYSearchField.h"

@interface XYDiscoverViewController ()

@property (nonatomic, weak) XYSearchField *searchField;

@end

@implementation XYDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XYSearchField *searchField = [[XYSearchField alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, 33)];
    searchField.placeholder = @"what...";
    self.searchField = searchField;
    self.navigationItem.titleView = searchField;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchField resignFirstResponder];
}
@end
