//
//  PayPreModel.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/10.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CommonModel.h"
#import "ConfigModel.h"

@interface PayPreModel : CommonModel

/*
 bankCardNum = "6212***********2960";
 "config_ll" =     {
 "busi_partner" = 101001;
 "md5_key" = ihzb1l7xgv20151020;
 "notify_url" = "http://s.aiben123.com/api/pay/ll/payResult";
 "oid_partner" = 201510201000546503;
 "pay_type" = D;
 "rsa_private" = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOilN4tR7HpNYvSBra/DzebemoAiGtGeaxa+qebx/O2YAdUFPI+xTKTX2ETyqSzGfbxXpmSax7tXOdoa3uyaFnhKRGRvLdq1kTSTu7q5s6gTryxVH2m62Py8Pw0sKcuuV0CxtxkrxUzGQN+QSxf+TyNAv5rYi/ayvsDgWdB3cRqbAgMBAAECgYEAj02d/jqTcO6UQspSY484GLsL7luTq4Vqr5L4cyKiSvQ0RLQ6DsUG0g+Gz0muPb9ymf5fp17UIyjioN+ma5WquncHGm6ElIuRv2jYbGOnl9q2cMyNsAZCiSWfR++op+6UZbzpoNDiYzeKbNUz6L1fJjzCt52w/RbkDncJd2mVDRkCQQD/Uz3QnrWfCeWmBbsAZVoM57n01k7hyLWmDMYoKh8vnzKjrWScDkaQ6qGTbPVL3x0EBoxgb/smnT6/A5XyB9bvAkEA6UKhP1KLi/ImaLFUgLvEvmbUrpzY2I1+jgdsoj9Bm4a8K+KROsnNAIvRsKNgJPWd64uuQntUFPKkcyfBV1MXFQJBAJGs3Mf6xYVIEE75VgiTyx0x2VdoLvmDmqBzCVxBLCnvmuToOU8QlhJ4zFdhA1OWqOdzFQSw34rYjMRPN24wKuECQEqpYhVzpWkA9BxUjli6QUo0feT6HUqLV7O8WqBAIQ7X/IkLdzLa/vwqxM6GLLMHzylixz9OXGZsGAkn83GxDdUCQA9+pQOitY0WranUHeZFKWAHZszSjtbe6wDAdiKdXCfig0/rOdxAODCbQrQs7PYy1ed8DuVQlHPwRGtokVGHATU=";
 "sign_type" = MD5;
 "trader_pri_key" = "";
 "valid_order" = 100;
 version = "1.0";
 "yt_pub_key" = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSS/DiwdCf/aZsxxcacDnooGph3d2JOj5GXWi+q3gznZauZjkNP8SKl3J2liP0O6rU/Y/29+IUe+GTMhMOFJuZm1htAtKiu5ekW0GlBMWxf4FPkYlQkPE0FtaoMP3gYfh+OwI+fIRrpW3ySn3mScnc6Z700nU/VYrRkfcSCbSnRwIDAQAB";
 };
 idCard = 410324199010240011;
 isFirstPay = 0;
 orderNum = 20151110130900T1;
 phoneNumber = 17090872779;
 realName = "\U59dc\U4e7e\U5143";
 regDate = 20151012171329;
 remainAsset = 0;
 signNum = 2015101265100300;

 */

@property (nonatomic, copy) NSString *bankCardNum;
@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, copy) NSString *isFirstPay;
@property (nonatomic, copy) NSString *orderNum;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *regDate;
@property (nonatomic, copy) NSString *remainAsset;
@property (nonatomic, copy) NSString *signNum;

@end
