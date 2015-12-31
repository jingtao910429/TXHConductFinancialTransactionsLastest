//
//  FinancialProjectListAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by rongyu100 on 15/11/24.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "FinancialProjectListAPICmd.h"

@implementation FinancialProjectListAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"理财项目列表";
}

@end
