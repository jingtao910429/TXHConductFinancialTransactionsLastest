//
//  Recentdynamicsmd.m
//  TXHConductFinancialTransactions
//
//  Created by 吴建良 on 15/11/6.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "Recentdynamicsmd.h"

@implementation Recentdynamicsmd

- (RYBaseAPICmdRequestType)requestType
{
    return RYBaseAPICmdRequestTypePost;
}

- (NSString *)apiCmdDescription
{
    return @"最近动态";
}
@end
