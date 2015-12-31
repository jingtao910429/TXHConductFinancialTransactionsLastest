//
//  PayPreAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/9.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "PayPreAPICmd.h"

@implementation PayPreAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"充值前";
}


@end
