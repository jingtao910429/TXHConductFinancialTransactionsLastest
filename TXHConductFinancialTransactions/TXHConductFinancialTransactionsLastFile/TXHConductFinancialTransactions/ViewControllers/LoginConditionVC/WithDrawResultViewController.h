//
//  WithDrawResultViewController.h
//  TXHConductFinancialTransactions
//
//  Created by rongyu100 on 15/11/26.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithDrawResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceConstraints;
@property (nonatomic, strong) NSString *moneyStr;
@property (nonatomic, strong) NSString *bankCard;
@property (nonatomic, assign) BOOL isSuccess;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankCardLabel;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@end
