//
//  DealDetailModel.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CommonModel.h"

@interface DealDetailModel : CommonModel

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *type;

@end
