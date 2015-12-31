//
//  HelpCenterVC.m
//  TXHConductFinancialTransactions
//
//  Created by 吴建良 on 15/11/8.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "HelpCenterVC.h"

#define NowYEAR 12345
@interface HelpCenterVC ()

@end
@implementation HelpCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}


-(void)setUI{
    
    
    NSString*url=@"";
    
    if (self.isGTturl) {
        [self navigationBarStyleWithTitle:@"帮助中心" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
        url=API_Help;
        
        

    }else{
        [self navigationBarStyleWithTitle:@"关于我们" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
        url=API_About;
        

    }
    
    [self.contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [self.view addSubview:self.contentWebView];
    
 
}


-(void)popVC{
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

//- (void)onClickBack:(UIButton*)sender{
//    
//    self.navigationController.navigationBar.translucent = YES;
//    kPop;
//}


@end
