//
//  CuponTableViewCell.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/12.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "CuponTableViewCell.h"

@implementation CuponTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUI {
    
    if (iPhone4 || iPhone5) {
        
        self.contentTrailingConstraints.constant += 10;
        self.createTimeTrailingContraints.constant += 10;
        self.leftContraints.constant -= 10;
        self.daysContraints.constant -= 10;
    }else if (iPhone6P) {
        self.contentTrailingConstraints.constant -= 20;
        self.createTimeTrailingContraints.constant -= 20;
        self.leftContraints.constant += 55;
        self.daysContraints.constant += 55;
    }else{
        self.leftContraints.constant += 28;
        self.daysContraints.constant += 28;
    }
}

@end
