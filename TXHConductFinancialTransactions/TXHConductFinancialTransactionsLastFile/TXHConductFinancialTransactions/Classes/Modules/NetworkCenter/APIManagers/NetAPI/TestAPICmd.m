//
//  TestAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/4.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "TestAPICmd.h"

@implementation TestAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypeGet;
}

- (NSString *)apiCmdDescription
{
    return @"活动列表";
}

@end
