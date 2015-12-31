//
//  EarnDetailModel.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CommonModel.h"

@interface EarnDetailModel : CommonModel

/*
 date = "2015-11-30+17:20:15";
 id = 70099;
 income = 88940;
 rate = 10;
 
 */

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *income;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *rate;



@end
