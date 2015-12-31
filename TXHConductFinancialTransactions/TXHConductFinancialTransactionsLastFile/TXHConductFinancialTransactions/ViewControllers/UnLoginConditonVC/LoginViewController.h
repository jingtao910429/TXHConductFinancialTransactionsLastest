//
//  LoginViewController.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/4.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

//区分是登录还是设置密码
@property (nonatomic, assign) BOOL isConfirmPassword;
//区分是忘记密码还是注册
@property (nonatomic, assign) BOOL isRegisterSetPassword;
@property (nonatomic, copy)   NSString *userName;

@end
