//
//  HomeAssetBottomTableViewCell.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/6.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeAssetBottomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *rechargeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *withDrawImageView;

- (void)updateUI;
@end
