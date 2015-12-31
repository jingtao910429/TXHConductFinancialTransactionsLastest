//
//  ActivityDetailViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "ActivityDetailViewController.h"

#define NowYEAR 12345

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBodyUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setBodyUI{
    
    [self navigationBarStyleWithTitle:@"活动详情" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    
    [self.contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    [self.view addSubview:self.contentWebView];
    
}

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getters and setters

- (UIWebView *)contentWebView{
    
    if (!_contentWebView) {
        _contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        _contentWebView.userInteractionEnabled = YES;
        _contentWebView.delegate = self;
        _contentWebView.backgroundColor = [UIColor whiteColor];
    }
    
    return _contentWebView;
}

- (UIActivityIndicatorView *)activityIndicator{
    
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [_activityIndicator setCenter:_contentWebView.center];
        [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    
    return _activityIndicator;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view setTag:NowYEAR];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    [view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
    UIView *acView = (UIView*)[self.view viewWithTag:NowYEAR];
    [acView removeFromSuperview];
}

#pragma mark - event response

- (void)onClickBack:(UIButton*)sender{
    
    self.navigationController.navigationBar.translucent = YES;
    kPop;
}

@end
