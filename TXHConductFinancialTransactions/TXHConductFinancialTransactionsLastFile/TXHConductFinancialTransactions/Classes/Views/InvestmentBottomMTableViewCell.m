//
//  InvestmentBottomTableViewCell.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "InvestmentBottomMTableViewCell.h"


@interface InvestmentBottomMTableViewCell ()

@end

@implementation InvestmentBottomMTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.zdProgressView = [[ZDProgressView alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 20)];
        self.zdProgressView.progress = 0;
        self.zdProgressView.text = @"";
        self.zdProgressView.noColor = [UIColor whiteColor];
        self.zdProgressView.prsColor = COLOR(239, 71, 26, 1.0);
        [self.contentView addSubview:self.zdProgressView];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.zdProgressView.frame.origin.y + self.zdProgressView.frame.size.height + 10, kScreenWidth - 30, 30)];
        self.contentLabel.text = @"还可以投资0.00元";
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.contentLabel];
        
        self.investmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.investmentButton.frame = CGRectMake(15, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 10, kScreenWidth - 30, 44);
        self.investmentButton.layer.cornerRadius = 4;
        self.investmentButton.layer.masksToBounds = YES;
        
        [self.investmentButton setTitle:@"开始抢购" forState:UIControlStateNormal];
        [self.investmentButton setBackgroundColor:COLOR(239, 71, 26, 1.0)];
        [self.contentView addSubview:self.investmentButton];
        
    }
    return self;
}

@end
