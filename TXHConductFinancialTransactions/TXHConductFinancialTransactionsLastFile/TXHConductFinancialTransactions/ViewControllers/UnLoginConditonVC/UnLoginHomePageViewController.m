//
//  UnLoginHomePageViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/3.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "UnLoginHomePageViewController.h"
#import "TestAPICmd.h"
#import "MyaccountnumberVC.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RecentdynamicsVC.h"
#import "RechargeVC.h"


@interface UnLoginHomePageViewController () <APICmdApiCallBackDelegate>

//网络请求，需要继承RYBaseAPICmd并实现RYBaseAPICmdDelegate，说明接口请求类型和用途
@property (nonatomic, strong) TestAPICmd *testAPICmd;

@property (nonatomic, strong) UIImageView *BackGroudView;
//注册按钮
@property (nonatomic, strong) UIButton *freeRegisteBtn;
//登录按钮
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation UnLoginHomePageViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - APICmdApiCallBackDelegate

//数据请求成功
- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
}
//请求失败
- (void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error {
    
}

#pragma mark - event response

//登录
- (void)loginBtnClick {
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:loginViewController animated:YES];
}

//注册
- (void)registeBtn {
    
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerViewController animated:YES];
}


#pragma mark - private method

//设置UI
- (void)configUI {

    [self navigationBarStyleWithTitle:@"投小猴" titleColor:[UIColor whiteColor]  leftTitle:nil leftImageName:nil leftAction:nil rightTitle:nil rightImageName:nil rightAction:nil];
    
    //添加视图
    [self.view addSubview:self.BackGroudView];
    [self.view addSubview:self.freeRegisteBtn];
    [self.view addSubview:self.loginBtn];
}

#pragma mark--测试我的账号
-(void)onleftAction{
 
    MyaccountnumberVC *vc = [[MyaccountnumberVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark - getters and setters

- (UIImageView *)BackGroudView {
    
    if (!_BackGroudView) {
        _BackGroudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_prologue"]];
        _BackGroudView.contentMode = UIViewContentModeScaleAspectFill;
        _BackGroudView.frame = CGRectMake(0, -64, kScreenWidth, kScreenHeight + 64);
    }
    return _BackGroudView;
}

- (UIButton *)freeRegisteBtn {
    
    if (!_freeRegisteBtn) {
        
        _freeRegisteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _freeRegisteBtn.frame = CGRectMake(15, kScreenHeight * 4/ 7, kScreenWidth - 30, 44);
        _freeRegisteBtn.backgroundColor = COLOR(239, 71, 26, 1.0);
        _freeRegisteBtn.layer.cornerRadius = 4;
        _freeRegisteBtn.layer.masksToBounds = YES;
        [_freeRegisteBtn setTitle:@"免费注册" forState:UIControlStateNormal];
        [_freeRegisteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_freeRegisteBtn addTarget:self action:@selector(registeBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _freeRegisteBtn;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(15, self.freeRegisteBtn.frame.origin.y + self.freeRegisteBtn.frame.size.height + 20, kScreenWidth - 30, 44);
        _loginBtn.backgroundColor = [UIColor orangeColor];
        _loginBtn.layer.cornerRadius = 4;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginBtn;
}

- (TestAPICmd *)testAPICmd {
    if (!_testAPICmd) {
        _testAPICmd = [[TestAPICmd alloc] init];
        _testAPICmd.delegate = self;
        _testAPICmd.reformParams = @{};
    }
    return _testAPICmd;
}


@end
