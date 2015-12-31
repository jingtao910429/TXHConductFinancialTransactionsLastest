//
//  NSString+Additions.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

//字符串金钱格式化
-(NSString *)changeYFormatWithMoneyAmount
{
    //不需要四舍五入
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    
    NSString *numStr = nil;
    
    BOOL isNegtive = NO;
    
    if ([self doubleValue] < 0) {
        isNegtive = YES;
        numStr = [formatter stringFromNumber:[NSNumber numberWithDouble:-[self  doubleValue]/100.00]];
    }else {
        numStr = [formatter stringFromNumber:[NSNumber numberWithDouble:[self  doubleValue]/100.00]];
    }
    
    NSArray *tempArr = [numStr componentsSeparatedByString:@"."];
    
    if (tempArr.count == 1) {
        numStr = [NSString stringWithFormat:@"%@.00",numStr];
    }else {
        
        if ([tempArr[1] length] == 1) {
            numStr = [NSString stringWithFormat:@"%@0",numStr];
        }
    }
    
    if (isNegtive) {
        numStr = [NSString stringWithFormat:@"-%@",[self subStringWithStr:numStr]];
    }else{
        numStr = [self subStringWithStr:numStr];
    }
    
    return numStr;
}

//不需要四舍五入的处理
- (NSString *)subStringWithStr:(NSString *)tempStr{
    
    NSArray *tempNumbers = [tempStr componentsSeparatedByString:@"."];
    NSString *pointBack = [tempNumbers[1] substringToIndex:2];
    return [NSString stringWithFormat:@"%@.%@",tempNumbers[0],pointBack];
    
}

//字符串金钱格式化(万元)
-(NSString *)changeWYFormatWithMoneyAmount {
    
    //不需要四舍五入
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    
    NSString *numStr = nil;
    
    BOOL isNegtive = NO;
    
    if ([self doubleValue] < 0) {
        isNegtive = YES;
        numStr = [formatter stringFromNumber:[NSNumber numberWithDouble:-[self  doubleValue]/1000000.00]];
    }else {
        numStr = [formatter stringFromNumber:[NSNumber numberWithDouble:[self  doubleValue]/1000000.00]];
    }
    
    NSArray *tempArr = [numStr componentsSeparatedByString:@"."];
    
    if (tempArr.count == 1) {
        numStr = [NSString stringWithFormat:@"%@.00",numStr];
    }else {
        
        if ([tempArr[1] length] == 1) {
            numStr = [NSString stringWithFormat:@"%@0",numStr];
        }
    }
    
    if (isNegtive) {
        numStr = [NSString stringWithFormat:@"-%@",[self subStringWithStr:numStr]];
    }else{
        numStr = [self subStringWithStr:numStr];
    }
    
    return numStr;
    
}

@end
