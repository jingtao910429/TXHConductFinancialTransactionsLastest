//
//  CashApplayAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/9.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CashApplayAPICmd.h"

@implementation CashApplayAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"提现申请";
}

@end
