//
//  NoticeListAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/6.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "NoticeListAPICmd.h"

@implementation NoticeListAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"活动列表";
}

@end
