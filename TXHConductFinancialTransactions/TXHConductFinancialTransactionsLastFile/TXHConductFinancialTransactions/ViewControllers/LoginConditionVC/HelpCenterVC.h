//
//  HelpCenterVC.h
//  TXHConductFinancialTransactions
//
//  Created by 吴建良 on 15/11/8.
//  Copyright © 2015年 rongyu. All rights reserved.
//  帮助中心

#import "BaseViewController.h"

@interface HelpCenterVC : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)  UIWebView *contentWebView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, copy)  NSString *url;
//
@property (nonatomic, assign) BOOL isGTturl;





@end
