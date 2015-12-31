//
//  CashPreAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/9.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CashPreAPICmd.h"

@implementation CashPreAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"提现前";
}

@end
