//
//  ConfigModel.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/10.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CommonModel.h"

@interface ConfigModel : CommonModel

@property (nonatomic, copy) NSString *busi_partner;
@property (nonatomic, copy) NSString *md5_key;
@property (nonatomic, copy) NSString *notify_url;
@property (nonatomic, copy) NSString *oid_partner;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *rsa_private;
@property (nonatomic, copy) NSString *sign_type;
@property (nonatomic, copy) NSString *trader_pri_key;
@property (nonatomic, copy) NSString *valid_order;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *yt_pub_key;

@end
