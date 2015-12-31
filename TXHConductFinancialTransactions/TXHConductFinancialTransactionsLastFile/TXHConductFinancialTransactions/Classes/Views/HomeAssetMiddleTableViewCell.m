//
//  HomeAssetMiddleTableViewCell.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/6.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "HomeAssetMiddleTableViewCell.h"

@implementation HomeAssetMiddleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIWithType:(NSInteger)type {
    
    CGFloat height = 0.0;
    
    if (1 == type) {
        if (iPhone4) {
            height = 70;
        }else if(iPhone6P){
            height = 0.1*(kScreenHeight - 50);
            self.titlePutMoneyLabels.frame = CGRectMake(0, height * 0.2, kScreenWidth/2, height * 0.55);
            self.titlePutMoneyLabels.font = [UIFont systemFontOfSize:16];
            self.titlePutMoneyLabels.textAlignment = NSTextAlignmentCenter;
            
            self.titleGetMoneyLabels.frame = CGRectMake(kScreenWidth/2, height * 0.2, kScreenWidth/2, height * 0.55);
            self.titleGetMoneyLabels.font = [UIFont systemFontOfSize:16];
            self.titleGetMoneyLabels.textAlignment = NSTextAlignmentCenter;
        }else{
            height = 0.15*(kScreenHeight - 50);
            self.titlePutMoneyLabels.frame = CGRectMake(0, height * 0.1, kScreenWidth/2, height* 0.3);
            self.titlePutMoneyLabels.font = [UIFont systemFontOfSize:16];
            self.titlePutMoneyLabels.textAlignment = NSTextAlignmentCenter;
            
            self.titleGetMoneyLabels.frame = CGRectMake(kScreenWidth/2, height * 0.1, kScreenWidth/2, height * 0.3);
            self.titleGetMoneyLabels.font = [UIFont systemFontOfSize:16];
            self.titleGetMoneyLabels.textAlignment = NSTextAlignmentCenter;
        }
    }else{
        if (iPhone4) {
            height = 35;
        }else{
            height = 60;
        }
        
        self.titlePutMoneyLabels.frame = CGRectMake(0, height * 0.1, kScreenWidth/2, height* 0.3);
        self.titlePutMoneyLabels.font = [UIFont systemFontOfSize:16];
        self.titlePutMoneyLabels.textAlignment = NSTextAlignmentCenter;
        
        self.titleGetMoneyLabels.frame = CGRectMake(kScreenWidth/2, height * 0.1, kScreenWidth/2, height * 0.3);
        self.titleGetMoneyLabels.font = [UIFont systemFontOfSize:16];
        self.titleGetMoneyLabels.textAlignment = NSTextAlignmentCenter;
    }
    
    
    self.putMoneyLabel.frame = CGRectMake(0, self.titlePutMoneyLabels.frame.origin.y + self.titlePutMoneyLabels.frame.size.height + 2, kScreenWidth/2, height * 0.55);
    self.putMoneyLabel.font = [UIFont systemFontOfSize:24];
    
    self.putMoneyLabel.textAlignment = NSTextAlignmentCenter;
    
    self.yestadyIncomeLabel.frame = CGRectMake(kScreenWidth/2, self.titleGetMoneyLabels.frame.origin.y + self.titleGetMoneyLabels.frame.size.height + 2, kScreenWidth/2, height * 0.55);
    self.yestadyIncomeLabel.font = [UIFont systemFontOfSize:24];
    self.yestadyIncomeLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
}

@end
