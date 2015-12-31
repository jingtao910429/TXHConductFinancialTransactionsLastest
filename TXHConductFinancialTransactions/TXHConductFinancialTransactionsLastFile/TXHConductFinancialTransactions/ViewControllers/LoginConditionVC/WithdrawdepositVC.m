//
//  WithdrawdepositVC.m
//  TXHConductFinancialTransactions
//
//  Created by 吴建良 on 15/11/4.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "WithdrawdepositVC.h"
#import "UIViewController+NavigationBarStyle.h"

@interface WithdrawdepositVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITextField *textfield;



@end

@implementation WithdrawdepositVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

-(void)configUI{
    
    [self navigationBarStyleWithTitle:@"提取" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    
    self.view.backgroundColor = BackColor;
    _bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    _bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_bgView];
    UIButton*querenBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 200, kScreenWidth-20, 50)];
    [querenBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    querenBtn.backgroundColor=[UIColor orangeColor];
    [querenBtn addTarget:self action:@selector(onquerenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [querenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:querenBtn];
    
    [self createBgview];
    
    
    
    //温馨提示
    
    UIButton*appcionBtn=[[UIButton alloc] initWithFrame:CGRectMake(12, 300, 18, 18)];
    appcionBtn.backgroundColor=[UIColor orangeColor];
    [appcionBtn setTitle:@"i" forState:UIControlStateNormal];
    appcionBtn.layer.cornerRadius = 9.0;
    appcionBtn.layer.borderWidth = 0.1;
    [appcionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:appcionBtn];
    
    
    UILabel*appcionLable=[[UILabel alloc] initWithFrame:CGRectMake(appcionBtn.frame.size.width+18, 300, 100, 30)];
    appcionLable.text=@"温馨提示";
    appcionLable.font=[UIFont systemFontOfSize:12];
    appcionLable.textColor=[UIColor grayColor];
    
    [self.view addSubview:appcionLable];
    [self cretedowntext];
    
    
    
}

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createBgview{
    NSArray*labletextArr=@[@"可提金额（元）：",@"移行卡：",@"提现金额（元）："];
    for (int i=0; i<3; i++) {
        
        int col = i%3;
        
        int rightcol= i%2;
        
        CGRect rect = CGRectMake(10, 10+col*60,130, 50);
        
        CGRect rightrect = CGRectMake(145, 10+rightcol*60,kScreenWidth-150, 50);
        
        UILabel*onelable=[[UILabel alloc]init];
        
        onelable.frame=rect;
        
        onelable.textAlignment=NSTextAlignmentLeft;
        onelable.text=labletextArr[i];
        
        
        
        onelable.font=[UIFont systemFontOfSize:14];
        
        [_bgView addSubview:onelable];
        
        
        UIView*lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 65+rightcol*60, kScreenWidth, 0.5)];
        lineview.backgroundColor=[UIColor blackColor];
        [_bgView addSubview:lineview];
        
        
        
        
        UILabel*rightlable=[[UILabel alloc]init];
        
        rightlable.frame=rightrect;
        rightlable.textAlignment=NSTextAlignmentLeft;
        
        rightlable.text=@"123545454545";
        rightlable.font=[UIFont systemFontOfSize:14];
        
        [_bgView addSubview:rightlable];
        
        
        
        
    }
    
    _textfield=[[UITextField alloc] initWithFrame:CGRectMake(145, 130,kScreenWidth-150, 50)];
    _textfield.placeholder=@"请输入体现金额";
    
    _textfield.delegate=self;
    _textfield.font=[UIFont systemFontOfSize:14];
    [_bgView addSubview:_textfield];
    
    
    
}



-(void)cretedowntext{
    
    
    NSArray*lableTextArr=@[@"单笔提现限额5万元",@"当日限额5万元，当日提现次数限3次",@"仅支持本人名下银行卡，且与充值同卡",@"提现不收取任何手续费"];
    
    
    for (int i=0; i<4; i++) {
        
        int col = i%4;
        CGRect rect = CGRectMake(12, 350+col*40,10, 10);
        CGRect rect2 = CGRectMake(30, 340+col*40,kScreenWidth-40, 30);
        
        
        UIButton*oneBtn=[[UIButton alloc] init];
        oneBtn.backgroundColor=[UIColor orangeColor];
        oneBtn.layer.cornerRadius = 5.0;
        oneBtn.layer.borderWidth = 0.1;
        oneBtn.frame = rect;
        [self.view addSubview:oneBtn];
        
        
        
        UILabel*onelable=[[UILabel alloc]init];
        
        onelable.frame=rect2;
        onelable.text=lableTextArr[i];
        onelable.font=[UIFont systemFontOfSize:14];
        
        [self.view addSubview:onelable];
    }
    
}


-(void)onquerenBtn{
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_textfield resignFirstResponder];
    
    
    return YES;
    
}


@end
