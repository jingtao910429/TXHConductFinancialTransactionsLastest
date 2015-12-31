//
//  ItemTypeViewController.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/8.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "BaseViewController.h"

@interface ItemTypeViewController : BaseViewController <UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)  UIWebView *contentWebView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
