//
//  CuponTableViewCell.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/12.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CuponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *takeLabel;
@property (weak, nonatomic) IBOutlet UILabel *restDayLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aspectConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContraints;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daysContraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTrailingConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *createTimeTrailingContraints;
@property (weak, nonatomic) IBOutlet UIView *foreView;
- (void)updateUI;

@end
