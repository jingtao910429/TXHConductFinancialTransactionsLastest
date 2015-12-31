//
//  HomeAssetBottomTableViewCell.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/6.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "HomeAssetBottomTableViewCell.h"

@implementation HomeAssetBottomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUI {
    
    CGFloat height = 0.0;
    
    if (iPhone4) {
        height = 100;
    }else{
        height = 0.25*(kScreenHeight - 50);
    }
    
    self.rechargeImageView.frame = CGRectMake(0, height * 0.2, kScreenWidth/2, height * 0.4);
    self.withDrawImageView.frame = CGRectMake(kScreenWidth/2, height * 0.2, kScreenWidth/2, height * 0.4);
    self.rechargeImageView.image = [UIImage imageNamed:@"rechargeIcon@3x"];
    self.withDrawImageView.image = [UIImage imageNamed:@"withDrawIcon@3x"];
    
    self.rechargeImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.withDrawImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *rechargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.rechargeImageView.frame.origin.y + self.rechargeImageView.frame.size.height, kScreenWidth/2, height * 0.2)];
    rechargeLabel.textAlignment = NSTextAlignmentCenter;
    rechargeLabel.font = [UIFont systemFontOfSize:15.5];
    rechargeLabel.textColor = COLOR(109, 109, 109, 1.0);
    rechargeLabel.text = @"我要充值";
    
    UILabel *withDrawLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, self.withDrawImageView.frame.origin.y + self.withDrawImageView.frame.size.height, kScreenWidth/2, height * 0.2)];
    withDrawLabel.textAlignment = NSTextAlignmentCenter;
    withDrawLabel.font = [UIFont systemFontOfSize:15.5];
    withDrawLabel.textColor = COLOR(109, 109, 109, 1.0);
    withDrawLabel.text = @"我要提现";
    
    
    [self.contentView addSubview:rechargeLabel];
    [self.contentView addSubview:withDrawLabel];
    
}

@end
