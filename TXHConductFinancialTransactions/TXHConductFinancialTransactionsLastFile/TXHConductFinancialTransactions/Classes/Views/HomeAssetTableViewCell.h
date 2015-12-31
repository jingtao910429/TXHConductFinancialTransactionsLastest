//
//  HomeAssetTableViewCell.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/6.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeAssetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpaceConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleSpaceConstraints;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

- (void)updateUI;
@end
