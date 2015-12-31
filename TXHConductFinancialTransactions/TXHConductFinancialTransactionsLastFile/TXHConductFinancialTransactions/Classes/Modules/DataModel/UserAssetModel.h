//
//  UserAssetModel.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/6.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CommonModel.h"

@interface UserAssetModel : CommonModel

/*
 
 作者:
 {
 "allAsset":0, // 全部资金,单位分
 "remainAsset":10 // 剩余资金,单位分
 "invest":0, // 在投资金,单位分
 "yesterdayIncome":0, // 昨日收益,单位分
 "rate":8, // 年利率
 }
 */

@property (nonatomic, copy) NSString *allAsset;
@property (nonatomic, copy) NSString *bankCardNum;
@property (nonatomic, copy) NSString *freeze;
@property (nonatomic, copy) NSString *income;
@property (nonatomic, copy) NSString *invest;
@property (nonatomic, copy) NSString *rate;
@property (nonatomic, copy) NSString *remainAsset;
@property (nonatomic, copy) NSString *yesterdayIncome;

@end
