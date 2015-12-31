//
//  CheckSmsVerifyCodeAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/5.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CheckSmsVerifyCodeAPICmd.h"

@implementation CheckSmsVerifyCodeAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"校对验证码";
}

@end
