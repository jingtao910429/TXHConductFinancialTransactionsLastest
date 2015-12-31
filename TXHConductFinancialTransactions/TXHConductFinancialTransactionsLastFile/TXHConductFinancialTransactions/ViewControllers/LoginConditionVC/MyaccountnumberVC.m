//
//  MyaccountnumberVC.m
//  TXHConductFinancialTransactions
//
//  Created by 吴建良 on 15/11/4.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "MyaccountnumberVC.h"
#import "UIViewController+NavigationBarStyle.h"
#import "MyaccountnumberCell.h"
#import "UnLoginHomePageViewController.h"
#import "UserInfoAPICmd.h"
#import "UserInfoModel.h"
#import "NSString+Additions.h"
#import "HelpCenterVC.h"
#import "RegisterViewController.h"
#import "TelPrompt.h"

@interface MyaccountnumberVC () <UITableViewDataSource,UITableViewDelegate,APICmdApiCallBackDelegate>


@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIView*headview;

@property (nonatomic, strong) NSArray *leftDataArr;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UILabel*nameLable;//账号名字

@property (nonatomic, strong) UILabel*priceLable;//余额

//网络请求
@property (nonatomic, strong) UserInfoAPICmd *userInfoAPICmd;
@property (nonatomic, strong) UserInfoModel *userInfoModel;

@property (nonatomic, strong) UILabel*shouyiLable;//收益
@property (nonatomic, strong) UILabel*lastDayiLable;//昨日收益

//退出视图
@property (nonatomic, strong) UIView *exitView;


@end

@implementation MyaccountnumberVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    [self.userInfoAPICmd loadData];
}

-(void)configUI{    
    
    [self navigationBarStyleWithTitle:@"我的账号" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    //添加视图
    [self.view addSubview:self.contentTableView];
    
    //self.leftDataArr = [[NSArray alloc] initWithObjects:@[@"身份证号",@"银行卡号"],@[@"客服电话",@"QQ官方群"],@[@"帮助中心",@"关于我们"],@[@"分享投小猴",@"检测更新"],@[@"修改密码",@"退出账号"], nil];
    self.leftDataArr = [[NSArray alloc] initWithObjects:@[@"身份证号",@"银行卡号"],@[@"客服电话",@"QQ官方群"],@[@"帮助中心",@"关于我们"],@[@"最新版本"],@[@"修改密码",@"退出账号"], nil];
    
    //self.images = [[NSArray alloc] initWithObjects:@[@"ic_identify_card",@"ic_bank_card"],@[@"ic_service_tel",@"ic_qq_group"],@[@"ic_help_center",@"ic_about_us"],@[@"ic_share",@"ic_check_update"],@[@"ic_share",@"ic_exit"], nil];
    self.images = [[NSArray alloc] initWithObjects:@[@"ic_identify_card",@"ic_bank_card"],@[@"ic_service_tel",@"ic_qq_group"],@[@"ic_help_center",@"ic_about_us"],@[@"ic_check_update"],@[@"ic_share",@"ic_exit"], nil];
    
    //self.dataSource = [[NSArray alloc] initWithObjects:@[@"",@""],@[@"",@""],@[@"",@""],@[@"",@""],@[@"",@""], nil];
    self.dataSource = [[NSArray alloc] initWithObjects:@[@"",@""],@[@"",@""],@[@"",@""],@[@""],@[@"",@""], nil];
}

//代理方法
#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.leftDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.leftDataArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 5;
    }
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UIImageView *backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
        backGroundView.image = [UIImage imageNamed:@"colorBackGround"];
        backGroundView.contentMode = UIViewContentModeScaleToFill;
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 30, 25, 60, 60)];
        iconImageView.layer.cornerRadius = 30;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.image = [UIImage imageNamed:@"touxiang"];
        
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImageView.frame.size.height + iconImageView.frame.origin.y + 10, kScreenWidth, 15)];
        phoneLabel.font = [UIFont systemFontOfSize:15];
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        phoneLabel.text = [Tool getUserInfo][@"username"];
        
        [backGroundView addSubview:iconImageView];
        [backGroundView addSubview:phoneLabel];
        
        return backGroundView;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MyaccountnumberCell";
    MyaccountnumberCell *cell = (MyaccountnumberCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[ MyaccountnumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
//        if (self.leftDataArr.count + 1 == indexPath.row) {
//            
//            [cell.contentView addSubview:self.exitView];
//            
//        }
        
    }
    
    cell.leftimageview.image=[UIImage imageNamed:self.images[indexPath.section][indexPath.row]];
    
    cell.leftlable.text=self.leftDataArr[indexPath.section][indexPath.row];
    
    cell.rightlable.text = self.dataSource[indexPath.section][indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    if (self.leftDataArr.count + 1 != indexPath.row) {
//        
//        if (0 == indexPath.row) {
//            
//            [self.headview removeFromSuperview];
//            
//            [cell.contentView addSubview:self.headview];
//        }
//        
//        if (4 != indexPath.row) {
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        
//        if (0 != indexPath.row) {
//            
//            cell.leftimageview.image=[UIImage imageNamed:self.images[indexPath.row - 1]];
//            
//            cell.leftlable.text=self.leftDataArr[indexPath.row - 1];
//            
//            cell.rightlable.text = self.dataSource[indexPath.row - 1];
//            
//        }
//
//    }else{
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (1 == indexPath.section && indexPath.row == 0) {
        
        [TelPrompt callPhoneNumber:self.userInfoModel.kfPhone call:^(NSTimeInterval duration) {
            
        } cancel:^{
            
        }];
    }else if (1 == indexPath.section && indexPath.row == 1) {
        [self joinGroup];
    }else if (2 == indexPath.section && indexPath.row == 0) {
        
        
        [self onxiangxiBtn];
        
    }else if (2 == indexPath.section && indexPath.row == 1) {
        
        HelpCenterVC*vc=[[HelpCenterVC alloc] init];
        vc.isGTturl=NO;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (4 == indexPath.section && indexPath.row == 0) {
        
        //修改密码
        [self onchangeBtn];
    }else if (4 == indexPath.section && indexPath.row == 1) {
        //退出账号
        [self onbaocunBTN];
    }
    
}

#pragma mark - APICmdApiCallBackDelegate

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
    if (baseAPICmd ==self.userInfoAPICmd) {
        
        NSDictionary *tempDict = (NSDictionary *)responseData;
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
            [Tool ToastNotification:tempDict[@"msg"]];
            
        }else{
            
            self.userInfoModel = [[UserInfoModel alloc] init];
            
            [self.userInfoModel setValuesForKeysWithDictionary:tempDict[@"data"]];
            
            self.dataSource = [[NSArray alloc] initWithObjects:@[self.userInfoModel.idCard?self.userInfoModel.idCard:@"",self.userInfoModel.bankCardNum?self.userInfoModel.bankCardNum:@""],@[self.userInfoModel.kfPhone?self.userInfoModel.kfPhone:@"",@"286379514"],@[@"",@""],@[self.userInfoModel.appVersion?self.userInfoModel.appVersion:@""],@[@"",@""], nil];
            
            [self.contentTableView reloadData];
            
            
        }
    }
    
}

- (void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error {
    [Tool ToastNotification:@"加载失败"];
}

#pragma mark - event response

#pragma mark - private method

//退出账号
- (void)onbaocunBTN {
    
    UnLoginHomePageViewController *unLoginHomePageVC = [[UnLoginHomePageViewController alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:[[UINavigationController alloc] initWithRootViewController:unLoginHomePageVC]];
    
    [Tool clearUserInfo];
    
}

//修改密码
-(void)onchangeBtn{
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.isRestPassword = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

-(void)onxiangxiBtn{
    
    HelpCenterVC*vc=[[HelpCenterVC alloc] init];
    vc.isGTturl=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)joinGroup{
    
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", @"286379541",@"7178d9308a6898539eadae70580f635533a7ee45e98891350f73721cbae102f5"];
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    else
        return NO;
}


#pragma mark - getters and setters

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight - 64) style:UITableViewStylePlain];
        
        UIView*footview=[[UIView alloc] init];
        _contentTableView.tableFooterView=footview;
        footview.backgroundColor=[UIColor whiteColor];
        
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
    }
    return _contentTableView;
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

- (UIView *)headview {
    
    _headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _headview.backgroundColor = [UIColor whiteColor];
    
    UIImage *tempImage = [UIImage imageNamed:@"img_account_head"];
    
    UIView*topview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    
    UIImageView*topimageview=[[UIImageView alloc] initWithFrame:CGRectMake(6, 20, 35, 35)];
    topimageview.image = tempImage;
    
    
    [topview addSubview:topimageview];
    
    _nameLable=[[UILabel alloc] initWithFrame:CGRectMake(topimageview.frame.size.width+15, 15, 140, 20)];
    _nameLable.text = self.userInfoModel.phoneNumber?self.userInfoModel.phoneNumber:@"";
    
    [topview addSubview:_nameLable];
    
    
    _priceLable=[[UILabel alloc] initWithFrame:CGRectMake(topimageview.frame.size.width+15, 35, 140, 30)];
    
    NSString *priceStr = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",[self.userInfoModel.remainAsset?self.userInfoModel.remainAsset:@" " floatValue]]] changeYFormatWithMoneyAmount];
    _priceLable.text = [NSString stringWithFormat:@"金额：%@",priceStr];
    _priceLable.textColor=[UIColor redColor];
    _priceLable.font = [UIFont systemFontOfSize:16];
    
    
    [topview addSubview:_priceLable];
    
    //修改密码
    UIButton*changeBtn=[[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 25, 80, 25)];
    
    [changeBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    changeBtn.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,changeBtn.titleLabel.bounds.size.width);
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    changeBtn.imageView.frame =changeBtn.bounds;
    changeBtn.hidden = NO;
    
    [changeBtn addTarget:self action:@selector(onchangeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    changeBtn.imageView.backgroundColor=[UIColor redColor];
    [topview addSubview:changeBtn];
    changeBtn.backgroundColor=[UIColor grayColor];
    
    
    [_headview addSubview:topview];
    
    
    
    
    UIImageView*downview=[[UIImageView alloc] initWithFrame:CGRectMake(0, topview.frame.size.height, kScreenWidth, 120)];
    
    downview.image=[UIImage imageNamed:@"bg_account_asset_info"];
    downview.userInteractionEnabled=YES;
    
    //详细介绍
    UIButton* xiangxiBtn=[[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth * 4.5 / 5.0, 80, 23, 23)];
    [xiangxiBtn setImage:[UIImage imageNamed:@"ic_help"] forState:UIControlStateNormal];
    
    xiangxiBtn.userInteractionEnabled = YES;
    [xiangxiBtn addTarget:self action:@selector(onxiangxiBtn) forControlEvents:UIControlEventTouchUpInside];
    [downview addSubview:xiangxiBtn];
    
    changeBtn.backgroundColor=[UIColor grayColor];
    
    
    
    
    UILabel*leijiLable=[[UILabel alloc] initWithFrame:CGRectMake(6, 5, 160, 30)];
    leijiLable.text=@"累计收益（元）";
    [downview addSubview:leijiLable];
    leijiLable.textColor=[UIColor whiteColor];
    
    _shouyiLable=[[UILabel alloc] initWithFrame:CGRectMake(6, leijiLable.frame.size.height, 160, 30)];
    
    
    
    NSString *shouyiLabletext = [NSString stringWithFormat :@"%@",[[NSString stringWithFormat:@"%.2f",[self.userInfoModel.income?self.userInfoModel.income:@" " floatValue]] changeYFormatWithMoneyAmount]];
    
    
    _shouyiLable.text=shouyiLabletext;
    
    _shouyiLable.textColor=[UIColor whiteColor];
    [downview addSubview:_shouyiLable];
    
    
    _lastDayiLable=[[UILabel alloc] initWithFrame:CGRectMake(6, _shouyiLable.frame.size.height+35, 160, 30)];
    
    NSString *lastDayiLableStr = [NSString stringWithFormat:@"昨日收益：%@",[[NSString stringWithFormat:@"%.2f",[self.userInfoModel.yesterdayIncome?self.userInfoModel.yesterdayIncome:@" " floatValue]] changeYFormatWithMoneyAmount]];
    
    
    _lastDayiLable.text=lastDayiLableStr;
    
    
    
    _lastDayiLable.textColor=[UIColor whiteColor];
    
    [downview addSubview:_lastDayiLable];
    
    [_headview addSubview:downview];
    
    return _headview;
}

- (UIView *)exitView {
    if (!_exitView) {
        
        _exitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        _exitView.userInteractionEnabled = YES;
        
        UIButton*baocunBTN=[[UIButton alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth-30,44)];
        baocunBTN.backgroundColor=[UIColor orangeColor];
        baocunBTN.layer.cornerRadius = 4;
        baocunBTN.layer.masksToBounds = YES;
        
        [baocunBTN setTitle:@"退出账号" forState:UIControlStateNormal];
        [baocunBTN addTarget:self action:@selector(onbaocunBTN) forControlEvents:UIControlEventTouchUpInside];
        
        [baocunBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [baocunBTN setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        [_exitView addSubview:baocunBTN];
        
    }
    return _exitView;
}


@end
