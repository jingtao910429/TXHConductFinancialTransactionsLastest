//
//  PayBankCardAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/10.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "PayBankCardAPICmd.h"

@implementation PayBankCardAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"用户第一次支付并且成功发送银行卡信息";
}

@end
