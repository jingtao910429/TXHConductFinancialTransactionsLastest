//
//  InvestmentBottomLTableViewCell.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "InvestmentBottomLTableViewCell.h"

@implementation InvestmentBottomLTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.investmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.investmentButton.frame = CGRectMake(15, 5, kScreenWidth - 30, 44);
        self.investmentButton.layer.cornerRadius = 4;
        self.investmentButton.layer.masksToBounds = YES;
        
        [self.investmentButton setTitle:@"开始抢购" forState:UIControlStateNormal];
        [self.investmentButton setBackgroundColor:COLOR(239, 71, 26, 1.0)];
        
        [self.contentView addSubview:self.investmentButton];
    }
    return self;
}

@end
