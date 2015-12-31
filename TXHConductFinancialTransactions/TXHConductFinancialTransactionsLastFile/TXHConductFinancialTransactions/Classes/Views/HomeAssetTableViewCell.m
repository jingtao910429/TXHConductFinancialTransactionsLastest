//
//  HomeAssetTableViewCell.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/6.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "HomeAssetTableViewCell.h"

@implementation HomeAssetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUI {
    
    if (iPhone5 || iPhone4) {
        
    }else{
        
        if (iPhone6P) {
            self.topSpaceConstraints.constant *= (self.frame.size.height*1.0/120.0 + 1.0) ;
            self.leftSpaceConstraints.constant *= (kScreenWidth*1.0/320.0 + 0.1);
            self.middleSpaceConstraints.constant *= (self.frame.size.height*1.0/120.0 + 0.1);
        }else{
            self.topSpaceConstraints.constant *= (self.frame.size.height*1.0/120.0 + 0.1) ;
            self.leftSpaceConstraints.constant *= (kScreenWidth*1.0/320.0 + 0.1);
            self.middleSpaceConstraints.constant *= (self.frame.size.height*1.0/120.0 + 0.1);
        }
        
    }
    
    
}

@end
