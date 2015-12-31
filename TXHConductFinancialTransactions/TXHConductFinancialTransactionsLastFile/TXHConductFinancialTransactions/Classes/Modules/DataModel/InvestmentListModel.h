//
//  InvestmentListModel.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CommonModel.h"

@interface InvestmentListModel : CommonModel

@property (nonatomic, copy) NSString *createDate;// 日期
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *max;// 最大可投金额，元
@property (nonatomic, copy) NSString *min;// 最小可投金额，元
@property (nonatomic, copy) NSString *money;// 总金额，分
@property (nonatomic, copy) NSString *name;// 理财项目名称
@property (nonatomic, copy) NSString *rate;// 利率
@property (nonatomic, copy) NSString *realMoney;// 真实金额，分
@property (nonatomic, copy) NSString *status;// 2=开始状态，3=关闭状态
@property (nonatomic, copy) NSString *version;// 投资人数
@property (nonatomic, copy) NSString *virtualCount;
@property (nonatomic, copy) NSString *virtualMoney;


@end
