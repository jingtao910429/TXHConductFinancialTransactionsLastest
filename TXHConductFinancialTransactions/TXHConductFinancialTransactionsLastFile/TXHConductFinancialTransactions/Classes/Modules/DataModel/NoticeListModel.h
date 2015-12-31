//
//  NoticeListModel.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/6.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CommonModel.h"

@interface NoticeListModel : CommonModel

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleImg;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;

@end
