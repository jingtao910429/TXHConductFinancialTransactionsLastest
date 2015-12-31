//
//  Tool.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/5.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "Tool.h"
#import "MMProgressHUD.h"

@implementation Tool

+ (void)ToastNotification:(NSString *)text{
    
    [WToast showWithText:text duration:1.5];
    
}

+ (void)setUserInfoWithDict:(NSDictionary *)userInfos {
    NSString *userInfoStr = [[EncryptionManager shareManager] encodeWithData:userInfos version:VERSION];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:userInfoStr forKey:@"userInfo"];
    [defaults synchronize];
}

+ (NSDictionary *)getUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[EncryptionManager shareManager] decodeWithStr:[defaults objectForKey:@"userInfo"] version:VERSION];
}

+ (void)clearUserInfo {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userInfoStr = [[EncryptionManager shareManager] encodeWithData:[NSDictionary dictionary] version:VERSION];
    [defaults setValue:userInfoStr forKey:@"userInfo"];
    [defaults synchronize];
}

#pragma mark - MMProgressHUD
+ (void)showLoadingHUD:(NSString *)title andStatus:(NSString *)status type:(NSInteger)type
{
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
    [MMProgressHUD setPresentationStyle:type];
    [MMProgressHUD showWithTitle:title status:status];
}

+ (void)showSuccessHUD:(NSString *)title andDelay:(float)delay type:(NSInteger)type
{
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
    [MMProgressHUD setPresentationStyle:type];
    [MMProgressHUD showWithTitle:nil];
    [MMProgressHUD dismissWithSuccess:title title:nil afterDelay:delay];
}

+ (void)showErrorHUD:(NSString *)title andDelay:(float)delay
{
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:nil];
    [MMProgressHUD dismissWithError:title afterDelay:delay];
}

+ (void)hideHUD
{
    [MMProgressHUD dismiss];
}

@end
