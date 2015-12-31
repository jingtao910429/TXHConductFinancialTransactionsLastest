//
//  FailedLogAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/10.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "FailedLogAPICmd.h"

@implementation FailedLogAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"充值失败日志记录";
}

@end
