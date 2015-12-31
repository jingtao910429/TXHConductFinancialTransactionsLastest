//
//  InterestRateCouponAPICmd.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/11.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "InterestRateCouponAPICmd.h"

@implementation InterestRateCouponAPICmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"加息体验卷";
}

@end
