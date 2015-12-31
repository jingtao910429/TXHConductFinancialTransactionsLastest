//
//  ConstantString.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/5.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "ConstantString.h"

@implementation ConstantString

+ (NSString *)loginResultWithType:(LoginType)type {
    
    NSString *str = @"";
    
    switch (type) {
        case LoginTypeSuccess:
            str = @"登录成功！";
            break;
        case LoginTypeNoAuthenticationStatus:
            str = @"未验证身份";
            break;
        case LoginTypeWrongInfo:
            str = @"账号或密码错误";
            break;
        default:
            break;
    }
    return str;
}

@end
