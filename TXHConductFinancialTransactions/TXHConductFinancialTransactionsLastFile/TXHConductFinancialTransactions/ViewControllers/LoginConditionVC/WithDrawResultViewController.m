//
//  WithDrawResultViewController.m
//  TXHConductFinancialTransactions
//
//  Created by rongyu100 on 15/11/26.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "WithDrawResultViewController.h"

@interface WithDrawResultViewController ()

@end

@implementation WithDrawResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self navigationBarStyleWithTitle:@"提现结果" titleColor:[UIColor blackColor]  leftTitle:@"" leftImageName:nil leftAction:nil rightTitle:nil rightImageName:nil rightAction:nil];
    
    [self changeUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeUI {
    
    if (self.isSuccess) {
        //如果是提现成功
        
        self.topImageView.image = [UIImage imageNamed:@"withDrawSuccess"];
        self.descripLabel.text = @"提现申请成功";
        
    }else{
        
        self.topImageView.image = [UIImage imageNamed:@"withDrawFailed"];
        self.descripLabel.text = @"提现申请失败";
        
    }
    
    if (iPhone4) {
        self.topSpaceConstraints.constant -= 50;
    }
    
    self.backBtn.layer.cornerRadius = 5;
    self.backBtn.layer.masksToBounds = YES;
    self.backBtn.backgroundColor = COLOR(239, 71, 26, 1.0);
    [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"提现金额：%.2f元",[self.moneyStr floatValue]];
    self.bankCardLabel.text = [NSString stringWithFormat:@"提现卡号：%@",self.bankCard];
    
}

- (void)backBtnClick {
     
     CATransition* transition = [CATransition animation];
     transition.type          = kCATransitionReveal;//可更改为其他方式
     transition.subtype       = kCATransitionFromBottom;//可更改为其他方式
     [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
     [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
