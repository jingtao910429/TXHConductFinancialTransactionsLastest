//
//  UserInfoModel.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CommonModel.h"

@interface UserInfoModel : CommonModel

/*
 作者:
 {
 "realName":"xxx", // 真实姓名
 "phoneNumber":"xxxxx", // 电话
 "idCard":"xxxx", // 身份证
 "bankCardNum":"xxxx", // 银行卡信息
 "remainAsset":0, // 剩余资产,单位分
 "income":0,  // 总收益,单位分
 "yesterdayIncome":0, // 昨日收益,单位分
 "appVersion":"1.0", //app版本号
 "kfPhone":"xxxx" //客服电话
 }
 */

@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *bankCardNum;
@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, copy) NSString *income;
@property (nonatomic, copy) NSString *kfPhone;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *remainAsset;
@property (nonatomic, copy) NSString *yesterdayIncome;

@end
