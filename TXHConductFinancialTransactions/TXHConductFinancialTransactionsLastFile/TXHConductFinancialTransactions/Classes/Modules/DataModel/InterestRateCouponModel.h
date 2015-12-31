//
//  InterestRateCouponModel.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/11.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CommonModel.h"

@interface InterestRateCouponModel : CommonModel

/*
 {
 "id":3,// id
 "activeId":6,// 活动ID
 "type":1,// 类型（1=体验金，2=加息券）
 "value":150// 值（体验金倍数/加成年利率）
 "day":0,// 有效天数
 "limit":1000,// 最少投资金额
 "createDate":"2015-11-05 14:29:24",// 领取日期
 }
 */

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *activeId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *limit;
@property (nonatomic, copy) NSString *createDate;

@end
