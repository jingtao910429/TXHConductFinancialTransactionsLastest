//
//  HomeAssetMiddleTableViewCell.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/6.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeAssetMiddleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *yestadyIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *putMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *titlePutMoneyLabels;
@property (weak, nonatomic) IBOutlet UILabel *titleGetMoneyLabels;

- (void)updateUIWithType:(NSInteger)type;

@end
