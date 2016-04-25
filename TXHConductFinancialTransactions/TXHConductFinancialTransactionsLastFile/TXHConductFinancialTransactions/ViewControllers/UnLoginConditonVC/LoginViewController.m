//
//  LoginViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/4.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginAPICmd.h"
#import "LoginHomePageViewController.h"
#import "Tool.h"
#import "RegisterAPICmd.h"

#define CELL_HEIGHT 45
#define CELL_NUMBER 5
#define CELL_IMAGE_FIRSTTAG   111
#define CELL_IMAGE_SENCONDTAG 112

@interface LoginViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,APICmdApiCallBackDelegate>

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UITextField *userNameTextFiled;
@property (nonatomic, strong) UITextField *passwordTextFiled;
@property (nonatomic, strong) UIButton    *forgetPasswordBtn;
@property (nonatomic, strong) UIButton    *loginBtn;

@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSArray *placeHolders;

//alertView
@property (nonatomic, strong) UIAlertView *forgetPassWordAlertView;

//登录
@property (nonatomic, strong) LoginAPICmd *loginAPICmd;
//注册/重置密码
@property (nonatomic, strong) RegisterAPICmd *registerAPICmd;

@end

@implementation LoginViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configData {
    
    if (self.isConfirmPassword) {
        
        self.images = @[@"ic_modify_password",@"",@"ic_modify_password"];
        self.placeHolders = @[@"请输入密码、长度6～16位",@"",@"确认密码"];
        
    }else {
        
        self.images = @[@"ic_modify_password",@"",@"ic_modify_password"];
        self.placeHolders = @[@"手机号",@"",@"登录密码"];
        
    }
    
}

- (void)configUI {
    
    if (self.isConfirmPassword) {
        [self navigationBarStyleWithTitle:@"设置密码" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    }else{
        [self navigationBarStyleWithTitle:@"登录" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:@"注册" rightImageName:nil rightAction:@selector(registeBtnClick)];
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self.contentTableView addGestureRecognizer:tapGestureRecognizer];
    
    [self.view addSubview:self.contentTableView];
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (1 == indexPath.row) {
        return 5;
    }else if (4 == indexPath.row) {
        return CELL_HEIGHT + 30;
    }
    
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CELL_NUMBER;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Identifier";
    
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!tableViewCell) {
        
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (1 != indexPath.row) {
            
            if (0 == indexPath.row || 2 == indexPath.row) {
                
                [tableViewCell.contentView addSubview:self.contentImageView];
                
                if (0 == indexPath.row) {
                    [tableViewCell.contentView addSubview:self.userNameTextFiled];
                }else{
                    [tableViewCell.contentView addSubview:self.passwordTextFiled];
                }
                
                tableViewCell.layer.cornerRadius = 5;
                tableViewCell.layer.masksToBounds = YES;
                
            }else if (3 == indexPath.row){
                [tableViewCell.contentView addSubview:self.forgetPasswordBtn];
            }else{
                [tableViewCell.contentView addSubview:self.loginBtn];
            }
            
            
        }
    }
    
    if (indexPath.row !=0 && indexPath.row != 2) {
        
        tableViewCell.contentView.backgroundColor = COLOR(232, 232, 232, 1.0);
        
    }else{
        
        tableViewCell.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = (UIImageView *)[tableViewCell.contentView viewWithTag:CELL_IMAGE_FIRSTTAG];
        
        imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
        
        UITextField *textField = (UITextField *)[tableViewCell.contentView viewWithTag:CELL_IMAGE_SENCONDTAG];
        
        if (0 == textField.text.length) {
            textField.placeholder = self.placeHolders[indexPath.row];
        }
    }
    
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - APICmdApiCallBackDelegate

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
    if (baseAPICmd == self.loginAPICmd) {
        
        [self.view endEditing:YES];
        
        NSDictionary *tempDict = (NSDictionary *)responseData;
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
            //登录失败
            [Tool ToastNotification:tempDict[@"msg"]];
            
        }else{
            
            [Tool setUserInfoWithDict:@{@"id":tempDict[@"id"],@"username":self.userNameTextFiled.text,@"password":self.passwordTextFiled.text}];
            
            //登录成功
            LoginHomePageViewController *loginHomePageVC = [[LoginHomePageViewController alloc] init];
            UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginHomePageVC];
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:loginNav];
            
        }
        
    }else if (baseAPICmd == self.registerAPICmd) {
        
        [self.view endEditing:YES];
        
        NSDictionary *tempDict = (NSDictionary *)responseData;
        
        
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
            //登录失败
            [Tool ToastNotification:tempDict[@"msg"]];
            
        }else{
            
            if (self.isRegisterSetPassword) {
                [Tool setUserInfoWithDict:@{@"id":tempDict[@"id"],@"username":self.userName,@"password":self.passwordTextFiled.text}];
                //登录成功
                LoginHomePageViewController *loginHomePageVC = [[LoginHomePageViewController alloc] init];
                UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginHomePageVC];
                [[[[UIApplication sharedApplication] delegate] window] setRootViewController:loginNav];
            }else{
                
                LoginViewController *loginViewController = [[LoginViewController alloc] init];
                
                [self.navigationController pushViewController:loginViewController animated:YES];
                
            }
            
        }
        
    }
    
}

- (void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error {
    
    [Tool ToastNotification:@"登录失败"];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    if (textField == self.userNameTextFiled) {
        [self.passwordTextFiled becomeFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.userNameTextFiled) {
        
        if (self.isConfirmPassword) {
            return YES;
        }
        
        //invertedSet方法是去反字符,把所有的除了kNumber里的字符都找出来(包含去空格功能)
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kkNumber] invertedSet];
        //按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];
        
        return canChange;

    }else if (textField == self.passwordTextFiled){

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

- (void)forgetPasswordBtnClick:(UIButton *)sender {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.isRestPassword = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (void)loginBtnClick {
    
    if (self.isConfirmPassword) {
        
        [self.view endEditing:YES];
        
        UIAlertView *alertView = nil;
        
        if (self.userNameTextFiled.text.length == 0 || self.passwordTextFiled.text.length == 0) {
            
            alertView = [[UIAlertView alloc]initWithTitle:nil message:@"密码不能为空" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alertView show];
            
        }else if (self.userNameTextFiled.text.length < 6 || self.userNameTextFiled.text.length > 18) {
            
            alertView = [[UIAlertView alloc]initWithTitle:nil message:@"密码格式不对，长度为6～18位" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (![self.userNameTextFiled.text isEqualToString:self.passwordTextFiled.text]){
            
            alertView = [[UIAlertView alloc]initWithTitle:nil message:@"两次密码不一致" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            
            [self.registerAPICmd loadData];
        }
        
        
    }else {
        if ([self isMobileNumber:self.userNameTextFiled.text]) {
            [self.loginAPICmd loadData];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"手机号码输入错误" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    
}

- (void)tapGesture {
    
    [self.view endEditing:YES];
    [self.contentTableView endEditing:YES];
}

//点击屏幕任何地方，键盘隐藏
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



#pragma mark - private method

- (void)popVC {
    
    if (![Tool getUserInfo] || [[Tool getUserInfo] isKindOfClass:[NSNull class]] || [[Tool getUserInfo] count] == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)registeBtnClick {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.isRestPassword = NO;
    [self.navigationController pushViewController:registerVC animated:YES];
    
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
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 30, kScreenWidth - 40, kScreenHeight - 100) style:UITableViewStyleGrouped];
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.scrollEnabled = NO;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
    }
    return _contentTableView;
}

- (UIImageView *)contentImageView {
    
    UIImage *image = [UIImage imageNamed:self.images[0]];
    _contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (CELL_HEIGHT - image.size.height)/2, image.size.width, image.size.height)];
    _contentImageView.tag = CELL_IMAGE_FIRSTTAG;
    
    return _contentImageView;
}

- (UITextField *)userNameTextFiled {
    
    if (!_userNameTextFiled) {
        
        _userNameTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 8, 0, kScreenWidth - 60 - self.contentImageView.frame.size.width, CELL_HEIGHT)];
        
        if (self.isConfirmPassword) {
            _userNameTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
            _userNameTextFiled.secureTextEntry = YES;
            _userNameTextFiled.returnKeyType = UIReturnKeyNext;
        }else{
            _userNameTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
            _userNameTextFiled.returnKeyType = UIReturnKeyNext;
            _userNameTextFiled.keyboardType  = UIKeyboardTypeNumberPad;
        }
        
        
        _userNameTextFiled.tag = CELL_IMAGE_SENCONDTAG;
        _userNameTextFiled.delegate = self;
        
    }
    return _userNameTextFiled;
}

- (UITextField *)passwordTextFiled {
    
    if (!_passwordTextFiled) {
        
        _passwordTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 8, 0, kScreenWidth - 60 - self.contentImageView.frame.size.width, CELL_HEIGHT)];
        _passwordTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextFiled.secureTextEntry = YES;
        _passwordTextFiled.returnKeyType = UIReturnKeyDone;
        _passwordTextFiled.tag = CELL_IMAGE_SENCONDTAG;
        _passwordTextFiled.delegate = self;
        
    }
    return _passwordTextFiled;
}

- (UIButton *)forgetPasswordBtn {
    
    if (!_forgetPasswordBtn) {
        _forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetPasswordBtn.frame = CGRectMake(kScreenWidth - 140 , 5, 100, 30);
        [_forgetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _forgetPasswordBtn.titleLabel.font = [UIFont fontWithName:FontName size:18];
        _forgetPasswordBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_forgetPasswordBtn addTarget:self action:@selector(forgetPasswordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.isConfirmPassword) {
        _forgetPasswordBtn.hidden = YES;
    }
    
    return _forgetPasswordBtn;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(0, 20, kScreenWidth - 40, 44);
        _loginBtn.backgroundColor = [UIColor orangeColor];
        _loginBtn.layer.cornerRadius = 4;
        _loginBtn.layer.masksToBounds = YES;
        
        if (self.isConfirmPassword) {
            [_loginBtn setTitle:@"确认" forState:UIControlStateNormal];
        }else{
            [_loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        }
        
        
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginBtn;
}

- (LoginAPICmd *)loginAPICmd {
    if (!_loginAPICmd) {
        _loginAPICmd = [[LoginAPICmd alloc] init];
        _loginAPICmd.delegate = self;
        _loginAPICmd.path = API_Login;
        
    }
    _loginAPICmd.reformParams = @{@"username":self.userNameTextFiled.text,
                                  @"password":self.passwordTextFiled.text};
    return _loginAPICmd;
}

- (RegisterAPICmd *)registerAPICmd {
    if (!_registerAPICmd) {
        _registerAPICmd = [[RegisterAPICmd alloc] init];
        _registerAPICmd.delegate = self;
        _registerAPICmd.path = API_Register;
    }
    _registerAPICmd.reformParams = @{@"type":self.isRegisterSetPassword?@"1":@"2",@"username":self.userName,@"password":self.passwordTextFiled.text};
    return _registerAPICmd;
}

@end
