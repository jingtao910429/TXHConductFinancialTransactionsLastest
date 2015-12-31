//
//  InvestmentBottomTableViewCell.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDProgressView.h"

@interface InvestmentBottomMTableViewCell : UITableViewCell

@property (nonatomic, strong) ZDProgressView *zdProgressView;
@property (nonatomic, strong) UILabel  *contentLabel;
@property (nonatomic, strong) UIButton *investmentButton;

@end
