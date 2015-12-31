//
//  EnumDefine.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/5.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LoginType){
    /// 成功
    LoginTypeSuccess = 1,
    /// 未验证身份
    LoginTypeNoAuthenticationStatus = 401,
    /// 账号或密码错误
    LoginTypeWrongInfo = 500
};

@interface EnumDefine : NSObject

@end
