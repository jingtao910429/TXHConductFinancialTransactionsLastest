//
//  NSString+Additions.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

//字符串金钱格式化(元)
-(NSString *)changeYFormatWithMoneyAmount;
//字符串金钱格式化(万元)
-(NSString *)changeWYFormatWithMoneyAmount;

@end
