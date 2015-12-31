//
//  InvestmentTopTableViewCell.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "InvestmentTopTableViewCell.h"

@implementation InvestmentTopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUI {
    
    float width = self.contentView.frame.size.width;
    
    self.totalMoneyLabel.frame = CGRectMake(0, self.totalMoneyLabel.frame.origin.y, width/3, self.totalMoneyLabel.frame.size.height);
    self.rateLabel.frame       = CGRectMake(self.totalMoneyLabel.frame.size.width, self.rateLabel.frame.origin.y, width/3, self.rateLabel.frame.size.height);
    self.investNumberLabel.frame = CGRectMake(self.rateLabel.frame.origin.x + self.rateLabel.frame.size.width, self.investNumberLabel.frame.origin.y, width/3, self.investNumberLabel.frame.size.height);

    self.totalMoneyHintLabel.frame = CGRectMake(0, self.totalMoneyHintLabel.frame.origin.y, width/3, self.totalMoneyHintLabel.frame.size.height);
    self.rateHintLabel.frame       = CGRectMake(self.totalMoneyHintLabel.frame.size.width, self.rateHintLabel.frame.origin.y, width/3, self.rateHintLabel.frame.size.height);
    self.investNumberHintLabel.frame       = CGRectMake(self.rateHintLabel.frame.origin.x + self.rateHintLabel.frame.size.width, self.investNumberHintLabel.frame.origin.y, width/3, self.investNumberHintLabel.frame.size.height);
}

@end
