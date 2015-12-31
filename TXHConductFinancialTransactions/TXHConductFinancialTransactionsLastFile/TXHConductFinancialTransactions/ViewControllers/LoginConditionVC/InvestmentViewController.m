//
//  InvestmentViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/8.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "InvestmentViewController.h"
#import "HomeAssetMiddleTableViewCell.h"
#import "InvestmentBottomLTableViewCell.h"
#import "UserInfoAPICmd.h"
#import "UserInfoModel.h"
#import "NSString+Additions.h"
#import "InvestmentListAPICmd.h"

#define CELL_NUMBER 6

@interface InvestmentViewController () <UITableViewDataSource,UITableViewDelegate,APICmdApiCallBackDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView     *contentTableView;

@property (nonatomic, strong) UIView          *tipView;

//投资金额
@property (nonatomic, strong) UITextField     *investMoneyTF;

//网络请求
@property (nonatomic, strong) UserInfoAPICmd *userInfoAPICmd;
@property (nonatomic, strong) UserInfoModel *userInfoModel;

//投资
@property (nonatomic, strong) InvestmentListAPICmd *investmentListAPICmd;

@property (nonatomic, copy)   NSString *lastVlue;

@end

@implementation InvestmentViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self configData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configData {
    [self.userInfoAPICmd loadData];
}

- (void)configUI {
    
    [self navigationBarStyleWithTitle:@"投资" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    
    [self.view addSubview:self.contentTableView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tapGes];
    [self.contentTableView addGestureRecognizer:tapGes];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (5 == indexPath.row) {
        return 100;
    }else if (4 == indexPath.row) {
        
        return 90;
        
    }else if (2 == indexPath.row) {
        
        return 65;
        
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CELL_NUMBER;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (0 == indexPath.row || 1 == indexPath.row || 3 == indexPath.row || 5 == indexPath.row) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            
            if (0 == indexPath.row || 1 == indexPath.row) {
                
                
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                
                UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, kScreenWidth - 140, 40)];
                contentLabel.textAlignment = NSTextAlignmentRight;
                contentLabel.font = [UIFont systemFontOfSize:16];
                contentLabel.tag = 1;
                
                if (0 == indexPath.row) {
                    
                    if (2 == [self.investmentListModel.status intValue]) {
                        cell.imageView.image = [UIImage imageNamed:@"ic_project"];
                    }else{
                        cell.imageView.image = [UIImage imageNamed:@"ic_project_gray"];
                    }
                    
                    cell.textLabel.text = @"项目名称";
                    contentLabel.text = self.investmentListModel.name;
                    
                }else{
                    
                    cell.textLabel.text = @"账户余额（元）";
                    NSString *priceStr = [[NSString stringWithFormat:@"%@",self.userInfoModel.income?self.userInfoModel.income:@""] changeYFormatWithMoneyAmount];
                    contentLabel.text = priceStr;
                    
                }
                
                
                contentLabel.tag = indexPath.row * 11;
                [cell.contentView addSubview:contentLabel];
                
                if (2 == indexPath.row) {
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69.5, kScreenWidth, 0.5)];
                    imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
                    
                    [cell.contentView addSubview:imageView];
                    
                }else{
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49.5, kScreenWidth, 0.5)];
                    imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
                    
                    [cell.contentView addSubview:imageView];
                }

            }else if (3 == indexPath.row) {
                
                cell.textLabel.text = @"投资余额（元）";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                
                [cell.contentView addSubview:self.investMoneyTF];
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49.5, kScreenWidth, 0.5)];
                imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
                
                [cell.contentView addSubview:imageView];

                
            }else if (5 == indexPath.row) {
                [cell.contentView addSubview:self.tipView];
                
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (1 == indexPath.row) {
            
            UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:indexPath.row * 11];
            NSString *priceStr = [[NSString stringWithFormat:@"%@",self.userInfoModel.income?self.userInfoModel.income:@""] changeYFormatWithMoneyAmount];
            contentLabel.text = priceStr;
        }
        
        return cell;
    }else if (2 == indexPath.row) {
        
        HomeAssetMiddleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeAssetMiddleTableViewCellID"];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeAssetMiddleTableViewCell" owner:self options:nil] lastObject];
            [cell updateUIWithType:2];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64.5, kScreenWidth, 0.5)];
            imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
            
            [cell.contentView addSubview:imageView];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titlePutMoneyLabels.text = @"项目可投金额（元）";
        cell.titleGetMoneyLabels.text = @"预计收益（元）";
        cell.putMoneyLabel.text = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",[self.investmentListModel.money?self.investmentListModel.money:@"0.00" floatValue] - [self.investmentListModel.realMoney?self.investmentListModel.realMoney:@"0.00" floatValue]]] changeYFormatWithMoneyAmount];
        
        CGFloat moneyInput = 0.0;
        
        NSString *finalValue = [NSString stringWithFormat:@"%@%@",self.investMoneyTF.text,self.lastVlue];
        
        if (finalValue && finalValue.length != 0) {
            moneyInput = [finalValue doubleValue];
        }
        
        NSLog(@"%@",finalValue);
        
        cell.yestadyIncomeLabel.text = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",moneyInput * [[self.investmentListModel rate] floatValue] / (365.0f)]] changeYFormatWithMoneyAmount];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"InvestmentBottomLTableViewCellID";
        
        InvestmentBottomLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InvestmentBottomLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.investmentButton.frame = CGRectMake(cell.investmentButton.frame.origin.x, 20, cell.investmentButton.frame.size.width, cell.investmentButton.frame.size.height);
        
        [cell.investmentButton setTitle:@"确认投资" forState:UIControlStateNormal];
        [cell.investmentButton addTarget:self action:@selector(confirmInvest) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    

    return nil;
}

#pragma mark - APICmdApiCallBackDelegate

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
    NSDictionary *tempDict = (NSDictionary *)responseData;
    
    if (baseAPICmd ==self.userInfoAPICmd) {
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
            [Tool ToastNotification:tempDict[@"msg"]];
            
        }else{
            
            self.userInfoModel = [[UserInfoModel alloc] init];
            [self.userInfoModel setValuesForKeysWithDictionary:tempDict[@"data"]];
            
            [self.contentTableView reloadData];
        }
    }else{
        
        [Tool ToastNotification:tempDict[@"msg"]];
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
}

- (void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error {
    [Tool ToastNotification:@"加载失败"];
}

#pragma mark  UITextFieldDelegate

//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    [self.contentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [self.contentTableView scrollRectToVisible:self.contentTableView.frame animated:YES];
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //invertedSet方法是去反字符,把所有的除了kNumber里的字符都找出来(包含去空格功能)
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kkNumber] invertedSet];
    //按cs分离出数组,数组按@""分离出字符串
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    
    self.lastVlue = [NSString stringWithString:string];
    
    [self.contentTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    return canChange;
}


#pragma mark - event response

//确认投资
- (void)confirmInvest {
    
    if ([self.investMoneyTF.text intValue] < 50){
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"单笔投资最低50.0元" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
        
    }else{
        
        [self.view endEditing:YES];
        
        [self.investmentListAPICmd loadData];
    }
    
}

- (void)tap {
    [self.view endEditing:YES];
}

#pragma mark - private method

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isRightNumber:(NSString *)numStr
{
    NSString * regex = @"[0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:numStr];
    return isMatch;
}

-(void)cretedowntextWithView:(UIView *)contentView{
    
    
    NSArray*lableTextArr=@[@"单笔投资最低50.0元，最高5.0万元"];
    
    
    for (int i = 0; i<lableTextArr.count; i++) {
        
        int col = i%4;
        CGRect rect = CGRectMake(12, 55+col*40,10, 10);
        CGRect rect2 = CGRectMake(30, 45+col*40,kScreenWidth-40, 30);
        
        
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


#pragma mark - getters and setters

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
    }
    return _contentTableView;
}

- (UIView *)tipView {
    if (!_tipView) {
        
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, kScreenWidth, 100)];
        
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
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29.5, kScreenWidth, 0.5)];
        imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
        
        [_tipView addSubview:imageView];
        
        [_tipView addSubview:appcionLable];
        [self cretedowntextWithView:_tipView];
        
    }
    return _tipView;
}

- (UITextField *)investMoneyTF {
    if (!_investMoneyTF) {
        _investMoneyTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 5, kScreenWidth - 120, 40)];
        _investMoneyTF.placeholder = @"请输入投资金额";
        _investMoneyTF.delegate = self;
        _investMoneyTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _investMoneyTF;
}


- (UserInfoAPICmd *)userInfoAPICmd {
    if (!_userInfoAPICmd) {
        _userInfoAPICmd = [[UserInfoAPICmd alloc] init];
        _userInfoAPICmd.delegate = self;
        _userInfoAPICmd.path = API_UserInfo;
    }
    _userInfoAPICmd.reformParams = @{@"id":[Tool getUserInfo][@"id"]};
    return _userInfoAPICmd;
}

- (InvestmentListAPICmd *)investmentListAPICmd {
    if (!_investmentListAPICmd) {
        
        _investmentListAPICmd = [[InvestmentListAPICmd alloc] init];
        _investmentListAPICmd.delegate = self;
        _investmentListAPICmd.path = API_Investment;
        
    }
    
    _investmentListAPICmd.reformParams = @{@"id":[Tool getUserInfo][@"id"],@"pid":self.investmentListModel.ID,@"money":[NSNumber numberWithDouble:[self.investMoneyTF.text doubleValue]]};
    return _investmentListAPICmd;
}


@end
