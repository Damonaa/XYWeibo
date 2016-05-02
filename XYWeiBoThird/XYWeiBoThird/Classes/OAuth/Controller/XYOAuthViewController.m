//
//  XYOAuthViewController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYOAuthViewController.h"
#import "MBProgressHUD+CZ.h"
#import "XYAccountTool.h"
#import "XYRootVC.h"

@interface XYOAuthViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;


@property (nonatomic, strong) NSURLRequest *request;
@end

@implementation XYOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] init];
    self.webView = webView;
    [self.view addSubview:webView];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = XYClient_id;
    NSString *redirect_uri = XYRedirect_uri;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseUrl, client_id, redirect_uri];
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [webView loadRequest:_request];
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在登陆..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    //api.weibo.com/oauth2/authorize?client_id=2539724958&redirect_uri=https://www.baidu.com
    XYLog(@"%@", urlStr);
    //https://www.baidu.com/?code=4eb131e5bebe288d13db1610780c73c9
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length > 0) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        XYLog(@"%@", code);
        //请求授权登陆
        [XYAccountTool getAccessTokenWithCode:code success:^{
            [XYRootVC setRootVCWithWindow:XYKeyWindow];
            
        } failure:^(NSError *error) {
            XYLog(@"%@", error);
        }];
        return NO;
    }
    
    return YES;
}

- (void)dealloc{
    self.request = nil;
    XYLog(@"oauth 销毁");
}
@end
