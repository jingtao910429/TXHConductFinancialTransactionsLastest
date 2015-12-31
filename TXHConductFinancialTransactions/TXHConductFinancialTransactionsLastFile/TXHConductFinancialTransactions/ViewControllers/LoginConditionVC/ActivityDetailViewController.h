//
//  ActivityDetailViewController.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailViewController : BaseViewController <UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)  UIWebView *contentWebView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, copy)  NSString *url;

@end
