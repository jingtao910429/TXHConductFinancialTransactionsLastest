//
//  RegisterViewController.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/4.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController

@property (nonatomic,strong) NSTimer *timer;
@property (assign,nonatomic) NSInteger second;
@property (strong,nonatomic) UIAlertView *alertView;

@property (nonatomic, assign) BOOL isRestPassword;

@end
