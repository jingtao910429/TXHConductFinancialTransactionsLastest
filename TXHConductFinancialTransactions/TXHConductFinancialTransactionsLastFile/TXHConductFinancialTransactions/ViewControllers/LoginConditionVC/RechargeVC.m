//
//  RechargeVC.m
//  TXHConductFinancialTransactions
//
//  Created by 吴建良 on 15/11/4.
//  Copyright © 2015年 rongyu. All rights reserved.
//    

#import "RechargeVC.h"
#import "UIViewController+NavigationBarStyle.h"
#import "RechargeCell.h"

@interface RechargeVC ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITextField *textfield;

@property (nonatomic, strong) UITableView *RechargeView;

@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSArray *textArr;
@property (nonatomic, strong) UILabel*firstLable;

@property (nonatomic, strong) UIView          *tipView;

@end

@implementation RechargeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configUI];
    [self createTableview];
    
}


-(void)createTableview{
    
    
    [self.view addSubview:self.RechargeView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (5 == indexPath.row) {
        return 55;
    }else if (6 == indexPath.row) {
        return 250;
    }
    
    return 50;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (5 == indexPath.row || 6 == indexPath.row) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            
            if (5 == indexPath.row) {
                
                UIButton*querenBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 44)];
                [querenBtn setTitle:@"确认充值" forState:UIControlStateNormal];
                querenBtn.backgroundColor=[UIColor orangeColor];
                [querenBtn addTarget:self action:@selector(onquerenBtn) forControlEvents:UIControlEventTouchUpInside];
                
                [querenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [cell.contentView addSubview:querenBtn];
                
            }
            
        }
        
        if (6 == indexPath.row) {
            
            [self.tipView removeFromSuperview];
            [cell.contentView addSubview:self.tipView];
            
            self.tipView.backgroundColor = [UIColor redColor];
        }
        
        return cell;
        
    }
    
    static NSString *CellIdentifier = @"RechargeCell";
    RechargeCell *cell = (RechargeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ RechargeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49.5, kScreenWidth, 0.5)];
        imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
        
        [cell.contentView addSubview:imageView];
    }
    
    if (indexPath.row!=0) {
        cell.textField.placeholder=self.textArr[indexPath.row];
    }else{
        cell.textField.hidden=YES;
        self.firstLable=[[UILabel alloc] initWithFrame:CGRectMake(cell.leftLable.frame.size.width+10, 10, kScreenWidth-cell.leftLable.frame.size.width+10, 40)];
        [cell.contentView addSubview:self.firstLable];
        
        self.firstLable.text=@"0.00";
        self.firstLable.textColor=[UIColor redColor];
        
    }
    
    cell.leftLable.text=self.nameArr[indexPath.row];
    cell.textField.tag=indexPath.row;
    cell.textField.delegate=self;
    
    
    
    return cell;
    
}
-(void)configUI{
    
    [self navigationBarStyleWithTitle:@"充值" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    
    self.nameArr=@[@"账户余额(元):",@"银行卡:",@"身份证:",@"真实姓名:",@"充值金额(元):",];
    
    self.textArr=@[@"",@"输入银行卡号",@"输入您的身份证",@"输入您的真实姓名",@"输入充值金额",];

    
    
}

- (void)popVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)cretedowntextWithView:(UIView *)contentView{
    
    
    NSArray*lableTextArr=@[@"单笔充值金额不低于一元，不高于5万元",@"单日限额5万元,当月限额50万元",@"仅支持本人名下银行卡充值",@"充值不收取任何手续费"];
    
    
    for (int i=0; i<4; i++) {
        
        int col = i%4;
        CGRect rect = CGRectMake(12, 30+col*40,10, 10);
        CGRect rect2 = CGRectMake(30, 20+col*40,kScreenWidth-40, 30);
        
        
        UIButton*oneBtn=[[UIButton alloc] init];
        oneBtn.backgroundColor=[UIColor orangeColor];
        oneBtn.layer.cornerRadius = 5.0;
        oneBtn.layer.borderWidth = 0.2;
        oneBtn.layer.borderColor = [UIColor clearColor].CGColor;
        oneBtn.layer.masksToBounds = YES;
        oneBtn.frame = rect;
        [contentView addSubview:oneBtn];
        
        
        
        UILabel*onelable=[[UILabel alloc]init];
        
        onelable.frame=rect2;
        onelable.text=lableTextArr[i];
        onelable.font=[UIFont systemFontOfSize:14];
        
        [contentView addSubview:onelable];
    }

}


-(void)onquerenBtn{
 
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag==1||textField.tag==2||textField.tag==3||textField.tag==4) {
        [textField resignFirstResponder];
    }
    return YES;
    
}

- (UITableView *)RechargeView {
    if (!_RechargeView) {
        
        _RechargeView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        _RechargeView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _RechargeView.dataSource=self;
        _RechargeView.delegate=self;
        _RechargeView.scrollEnabled =YES;
        
        _RechargeView.backgroundColor=[UIColor whiteColor];
        
    }
    return _RechargeView;
}

- (UIView *)tipView {
    
    _tipView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, kScreenWidth, 250)];
    
    //温馨提示
    
    UIButton*appcionBtn=[[UIButton alloc] initWithFrame:CGRectMake(12, 6, 18, 18)];
    appcionBtn.backgroundColor=[UIColor orangeColor];
    [appcionBtn setTitle:@"i" forState:UIControlStateNormal];
    appcionBtn.layer.cornerRadius = 9.0;
    appcionBtn.layer.borderWidth = 0.1;
    appcionBtn.layer.borderColor = [UIColor clearColor].CGColor;
    appcionBtn.layer.masksToBounds = YES;
    [appcionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tipView addSubview:appcionBtn];
    
    
    UILabel*appcionLable=[[UILabel alloc] initWithFrame:CGRectMake(appcionBtn.frame.size.width+18, 0, 100, 30)];
    appcionLable.text=@"温馨提示";
    appcionLable.font=[UIFont systemFontOfSize:12];
    appcionLable.textColor=[UIColor grayColor];
    
    [_tipView addSubview:appcionLable];
    [self cretedowntextWithView:_tipView];
    return _tipView;
}

@end
