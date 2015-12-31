//
//  RegisterViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/4.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "RegisterViewController.h"
#import "FactoryManager.h"
#import "RYSmsManager.h"
#import "GetVertifyCodeAPICmd.h"
#import "LoginViewController.h"
#import "CheckSmsVerifyCodeAPICmd.h"
#import "RegisterAPICmd.h"

#define CELL_NUMBERS 6
#define CELL_HEIGHT 45

@interface RegisterViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,APICmdApiCallBackDelegate>

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UIView *vertifyCodeView;
@property (nonatomic, strong) UIButton *getVertifyBtn;

@property (nonatomic, strong) UIButton    *registerBtn;

@property (nonatomic, strong) UITextField *phoneNumberTF;
@property (nonatomic, strong) UITextField *smsTF;

//数据请求
@property (nonatomic, strong) GetVertifyCodeAPICmd *getVertifyCodeAPICmd;
//校对验证码
@property (nonatomic, strong) CheckSmsVerifyCodeAPICmd *checkSmsVerifyCodeAPICmd;
//注册/重置密码
@property (nonatomic, strong) RegisterAPICmd *registerAPICmd;

@end

@implementation RegisterViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initTimerSecond];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configData];
    [self configUI];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configData {
    
}

- (void)configUI {
    
    if (self.isRestPassword) {
        
        if (![Tool getUserInfo] || [[Tool getUserInfo] isKindOfClass:[NSNull class]] || [[Tool getUserInfo] count] == 0) {
            
            [self navigationBarStyleWithTitle:@"重置密码" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:@"登录" rightImageName:nil rightAction:@selector(loginBtnClick)];

        }else{
            
            [self navigationBarStyleWithTitle:@"重置密码" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];

        }
        
            }else{
        [self navigationBarStyleWithTitle:@"注册" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:@"登录" rightImageName:nil rightAction:@selector(loginBtnClick)];
    }
    
    self.alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    
    [self.view addSubview:self.contentTableView];
    
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (2 == indexPath.row) {
        return 5;
    }else if (4 == indexPath.row) {
        return 60;
    }
    
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return CELL_NUMBERS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Identifier";
    
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!tableViewCell) {
        
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableViewCell.contentView.backgroundColor = COLOR(232, 232, 232, 1.0);
        
        if (1 == indexPath.row) {
            
            self.phoneView = [[FactoryManager shareManager] createCellViewWithFrame:CGRectMake(20, 0, kScreenWidth - 40, CELL_HEIGHT) imageName:@"ic_login_num" placeHolder:@"请输入手机号" imageTag:indexPath.row textFiledTag:indexPath.row * 10 cellHeight:CELL_HEIGHT target:self isNeedImage:YES];
            
            self.phoneNumberTF = (UITextField *)[self.phoneView viewWithTag:indexPath.row * 10];
            
            self.phoneNumberTF.frame = CGRectMake(self.phoneNumberTF.frame.origin.x, self.phoneNumberTF.frame.origin.y, self.phoneNumberTF.frame.size.width - 10, self.phoneNumberTF.frame.size.height);
            
            self.phoneNumberTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.phoneNumberTF.returnKeyType = UIReturnKeyNext;
            self.phoneNumberTF.keyboardType  = UIKeyboardTypeNumberPad;
            
            if ([RYSmsManager defaultManager].mobile) {
                self.phoneNumberTF.text = [RYSmsManager defaultManager].mobile;
            }
            
            [tableViewCell.contentView addSubview:self.phoneView];
            
        }else if (3 == indexPath.row) {
            
            self.vertifyCodeView = [[FactoryManager shareManager] createCellViewWithFrame:CGRectMake(20, 0, kScreenWidth - 40, CELL_HEIGHT) imageName:@"ic_login_num" placeHolder:@"短信验证码" imageTag:indexPath.row textFiledTag:indexPath.row * 10  cellHeight:CELL_HEIGHT target:self isNeedImage:YES];
            
            self.smsTF = (UITextField *)[self.vertifyCodeView viewWithTag:indexPath.row * 10];
            
            self.smsTF.returnKeyType = UIReturnKeyDone;
            
            self.smsTF.frame = CGRectMake(self.smsTF.frame.origin.x, self.smsTF.frame.origin.y, self.smsTF.frame.size.width - (kScreenWidth - 40 - 20)*1.0/4 - 15, self.smsTF.frame.size.height);
            
            [tableViewCell.contentView addSubview:self.vertifyCodeView];
            
            [self.vertifyCodeView addSubview:self.getVertifyBtn];
            
        }else if (5 == indexPath.row) {
            [tableViewCell.contentView addSubview:self.registerBtn];
        }
        
    }
    
    return tableViewCell;
}

#pragma mark - APICmdApiCallBackDelegate

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
    if (baseAPICmd == self.getVertifyCodeAPICmd) {
        
        if ([responseData[@"result"] integerValue] != 1){
            [self.timer invalidate];
            [self canGetVerifyCode];
            if (![responseData[@"msg"] isEqual:[NSNull null]]){
                
                self.alertView.message = responseData[@"msg"];
                [self.alertView show];
            }
        }else{
            
            [RYSmsManager defaultManager].count = self.second  + [RYSmsManager defaultManager].second;
            //将手机号和时间以键值存入字典中(针对多个手机号同时获取验证码时间显示)
            [[RYSmsManager defaultManager].infoDictionary  setObject:[NSString stringWithFormat:@"%ld",(long)[RYSmsManager defaultManager].count] forKey:[RYSmsManager defaultManager].mobile];
        }
        
    }else if (baseAPICmd == self.checkSmsVerifyCodeAPICmd) {
        //如果是校验验证码
        
        if ([responseData[@"result"] integerValue] != 1){
            
            if (![responseData[@"msg"] isEqual:[NSNull null]]){
                
                self.alertView.message = responseData[@"msg"];
                [self.alertView show];
            }
        }else {
            
            [self.timer invalidate];
            [self canGetVerifyCode];
            
            //设置密码
            
            LoginViewController *registerLoginVC = [[LoginViewController alloc] init];
            registerLoginVC.isConfirmPassword = YES;
            
            if (!self.isRestPassword) {
                registerLoginVC.isRegisterSetPassword = YES;
            }else{
                registerLoginVC.isRegisterSetPassword = NO;
            }
            
            registerLoginVC.userName = self.phoneNumberTF.text;
            [self.navigationController pushViewController:registerLoginVC animated:YES];
            
        }
        
    }
    
}

- (void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error {
    
    if (baseAPICmd == self.checkSmsVerifyCodeAPICmd) {
        
        [Tool ToastNotification:@"验证码获取失败"];
        [self.timer invalidate];
        [self canGetVerifyCode];
    }
    
    
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    if (textField == self.phoneNumberTF) {
        [self.smsTF becomeFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneNumberTF) {

        //invertedSet方法是去反字符,把所有的除了kNumber里的字符都找出来(包含去空格功能)
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kkNumber] invertedSet];
        //按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];

        return canChange;

    }else if (textField == self.smsTF){

        //invertedSet方法是去反字符,把所有的除了kNumber里的字符都找出来(包含去空格功能)
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kkValidChar] invertedSet];
        //按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];

        return canChange;

    }

    return YES;
}

#pragma mark - event response

//获取验证码
- (void)getVertifyBtnClick {
    
    UITextField *phoneTF = (UITextField *)[self.phoneView viewWithTag:10];
    
    if ([self isMobileNumber:phoneTF.text]) {
        
        [RYSmsManager defaultManager].mobile = phoneTF.text;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        //网络请求
        [self.getVertifyCodeAPICmd loadData];
        
    }
    else
    {
        self.alertView.message = @"手机号码输入错误";
        [self.alertView show];
    }
    
}

//验证手机号
- (void)registerBtnClick {
    
    if (0 == self.smsTF.text.length) {
        self.alertView.message = @"验证码不能为空";
        [self.alertView show];
    }else{
        
        NSString * regex = @"[0-9]{6}";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:self.smsTF.text];
        
        if (!isMatch) {
            self.alertView.message = @"验证码格式不正确";
            [self.alertView show];
        }else{
            [self.checkSmsVerifyCodeAPICmd loadData];
        }
    }
    
    
}

#pragma mark - private method

- (void)popVC {
    
    if (![Tool getUserInfo] || [[Tool getUserInfo] isKindOfClass:[NSNull class]] || [[Tool getUserInfo] count] == 0) {
        //没有登录过
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//登录
- (void)loginBtnClick {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)timerFireMethod {
    
    if (self.second == 1) {
        [self.timer invalidate];
        [self canGetVerifyCode];
    }else{
        self.second--;
        [self gettingVerifyCode];
    }
    
}

//倒计时开启状态
-(void)gettingVerifyCode{
    
    self.getVertifyBtn.enabled = NO;
    NSString *title = [NSString stringWithFormat:@"%lds后可重发",(long)self.second];
    [self.getVertifyBtn setTitle:title forState:UIControlStateNormal];
}
//倒计时关闭状态
-(void)canGetVerifyCode{
    
    self.second = 60;
    self.getVertifyBtn.enabled = YES;
    [self.getVertifyBtn setTitle:@"重新获取" forState:UIControlStateNormal];
}

//进入当前页面时状态
-(void)initTimerSecond
{
    self.second = 60;
    if ([RYSmsManager defaultManager].infoDictionary.count > 0 ) {
        NSString *secondString = [[RYSmsManager defaultManager].infoDictionary  objectForKey:[RYSmsManager defaultManager].mobile];
        
        if ([RYSmsManager defaultManager].mobile && !self.isRestPassword) {
            self.phoneNumberTF.text = [RYSmsManager defaultManager].mobile;
        }
        if (secondString != nil) {
            self.second = [secondString integerValue] - [RYSmsManager defaultManager].second;
            if (self.second < 1) {
                [self canGetVerifyCode];
            }
            if ( self.second != 0  && self.second != 60) {
                self.getVertifyBtn.enabled = NO;
                [self gettingVerifyCode];
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            }
        }
        else
        {
            self.second = 60;
        }
    }
}

//手机号码判断
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * regex = @"1[0-9]{10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    return isMatch;
}

#pragma mark - getters and setters

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.scrollEnabled = NO;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
    }
    return _contentTableView;
}

- (UIButton *)getVertifyBtn {
    if (!_getVertifyBtn) {
        _getVertifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getVertifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getVertifyBtn.titleLabel.font = [UIFont systemFontOfSize:14.5];
        [_getVertifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getVertifyBtn addTarget:self action:@selector(getVertifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _getVertifyBtn.layer.cornerRadius = 2;
        _getVertifyBtn.layer.masksToBounds = YES;
    }
    _getVertifyBtn.frame = CGRectMake(self.vertifyCodeView.frame.size.width - (kScreenWidth - 40 - 20)*1.0/4 - 20, 6, (kScreenWidth - 40 - 20)*1.0/4 + 10, CELL_HEIGHT - 12);
    _getVertifyBtn.backgroundColor = COLOR(239, 71, 26, 1.0);
    return _getVertifyBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.frame = CGRectMake(20, 10, kScreenWidth - 40, 44);
        _registerBtn.backgroundColor = COLOR(239, 71, 26, 1.0);
        _registerBtn.layer.cornerRadius = 4;
        _registerBtn.layer.masksToBounds = YES;
        [_registerBtn setTitle:@"验证手机号码" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerBtn;
}

- (GetVertifyCodeAPICmd *)getVertifyCodeAPICmd {
    if (!_getVertifyCodeAPICmd) {
        _getVertifyCodeAPICmd = [[GetVertifyCodeAPICmd alloc] init];
        _getVertifyCodeAPICmd.delegate = self;
        _getVertifyCodeAPICmd.path = API_VertifyCode;
        
    }
    _getVertifyCodeAPICmd.reformParams = @{@"type":[NSString stringWithFormat:@"%@",self.isRestPassword?@"2":@"1"],@"phoneNumber":self.phoneNumberTF.text};
    return _getVertifyCodeAPICmd;
}

- (CheckSmsVerifyCodeAPICmd *)checkSmsVerifyCodeAPICmd {
    
    if (!_checkSmsVerifyCodeAPICmd) {
        _checkSmsVerifyCodeAPICmd = [[CheckSmsVerifyCodeAPICmd alloc] init];
        _checkSmsVerifyCodeAPICmd.delegate = self;
        _checkSmsVerifyCodeAPICmd.path = API_CheckVertifyCode;
    }
    _checkSmsVerifyCodeAPICmd.reformParams = @{@"phoneNumber":self.phoneNumberTF.text,@"verifyCode":self.smsTF.text};
    return _checkSmsVerifyCodeAPICmd;
    
}

- (RegisterAPICmd *)registerAPICmd {
    if (!_registerAPICmd) {
        _registerAPICmd = [[RegisterAPICmd alloc] init];
        _registerAPICmd.delegate = self;
        _registerAPICmd.path = API_Register;
    }
    _registerAPICmd.reformParams = @{@"phoneNumber":self.phoneNumberTF.text,@"verifyCode":self.smsTF.text};
    return _registerAPICmd;
}

@end
