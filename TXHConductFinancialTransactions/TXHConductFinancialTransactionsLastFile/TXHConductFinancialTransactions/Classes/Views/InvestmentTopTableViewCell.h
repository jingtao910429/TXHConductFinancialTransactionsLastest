//
//  InvestmentTopTableViewCell.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestmentTopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *investNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyHintLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateHintLabel;
@property (weak, nonatomic) IBOutlet UILabel *investNumberHintLabel;

- (void)updateUI;
@end
