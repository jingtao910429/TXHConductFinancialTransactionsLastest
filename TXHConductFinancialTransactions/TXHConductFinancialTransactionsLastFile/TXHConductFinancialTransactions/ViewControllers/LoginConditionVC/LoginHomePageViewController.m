//
//  LoginHomePageViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/3.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "LoginHomePageViewController.h"
#import "BMAdScrollView.h"
#import "NoticeListAPICmd.h"
#import "UserAssetAPICmd.h"
#import "NoticeListModel.h"
#import "UserAssetModel.h"
#import "HomeAssetTableViewCell.h"
#import "HomeAssetMiddleTableViewCell.h"
#import "HomeAssetBottomTableViewCell.h"
#import "KxMenu.h"
#import "ActivityDetailViewController.h"
#import "RecentdynamicsVC.h"
#import "MyaccountnumberVC.h"
#import "NSString+Additions.h"
#import "DealDetailViewController.h"
#import "InvestmentListViewController.h"
#import "RechargeWithDrawDepositViewController.h"
#import "InterestRateCouponViewController.h"
#import "EarningsRecordViewController.h"
#import "FinancialProjectListViewController.h"

#define TimerNumber 10

static NSString *HomeAssetTableViewCellID       = @"HomeAssetTableViewCellID";
static NSString *HomeAssetMiddleTableViewCellID = @"HomeAssetMiddleTableViewCellID";
static NSString *HomeAssetBottomTableViewCellID = @"HomeAssetBottomTableViewCellID";

@interface LoginHomePageViewController () <ValueClickDelegate,UITableViewDataSource,UITableViewDelegate,APICmdApiCallBackDelegate>

@property (nonatomic, strong) UITableView        *contentTableView;

@property (nonatomic, strong) UIView             *topBackGroudView;
@property (nonatomic, strong) BMAdScrollView     *bmadScrollView;
@property (nonatomic, strong) UIImageView        *unloginImgView;
//底部button （立即投资）
@property (nonatomic, strong) UIButton           *bottomButton;
//用户视图

//广告image
@property (nonatomic, strong)   NSMutableArray     *images;
//itemName
@property (nonatomic, copy)     NSArray  *menuItems;
//广告
@property (nonatomic, strong)   NoticeListAPICmd   *noticeListAPICmd;
//用户资产
@property (nonatomic, strong)   UserAssetAPICmd    *userAssetAPICmd;

//用户资产model
@property (nonatomic, strong)   UserAssetModel     *userAssetModel;


//动画timer
@property (nonatomic, strong)   NSMutableArray *timers;
@property (nonatomic, assign)   double step;
@property (nonatomic, assign)   NSInteger totalMoney;
@property (nonatomic, strong)   HomeAssetTableViewCell *totalMondyCell;

@end

@implementation LoginHomePageViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configData {
    
    [self.noticeListAPICmd loadData];
    [self.userAssetAPICmd  loadData];
}

- (void)configUI {
    
    [self navigationBarStyleWithTitle:@"首页" titleColor:[UIColor blackColor]  leftTitle:@"活动" leftImageName:@"ic_activity" leftAction:@selector(activityList) rightTitle:nil rightImageName:@"img_account_head" rightAction:@selector(selectItem:)];
    
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.bottomButton];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.27*(self.view.frame.size.height - 50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        return 0.33*(self.view.frame.size.height - 50);
    }else if (1 == indexPath.row) {
        
        if (iPhone4) {
            return 70;
        }
        
        return 0.15*(self.view.frame.size.height - 50);
    }
    
    if (iPhone4) {
        return 100;
    }
    
    return 0.25*(self.view.frame.size.height - 50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    for (UIView *subView in self.topBackGroudView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (self.images &&  self.images.count != 0) {
        [self.topBackGroudView addSubview:self.bmadScrollView];
    }else{
        [self.topBackGroudView addSubview:self.unloginImgView];
    }
    
    return self.topBackGroudView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        
        HomeAssetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeAssetTableViewCellID];
        
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeAssetTableViewCell" owner:self options:nil] lastObject];
            [cell updateUI];
            
            UIImageView *nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 0.33*(self.view.frame.size.height - 50) / 2.0 - 5.0, 8, 10)];
            nextImageView.image = [UIImage imageNamed:@"IQButtonBarArrowRight"];
            [cell.contentView addSubview:nextImageView];

            
        }
        
        
        
        cell.totalMoney.text = [[NSString stringWithFormat:@"%@",self.userAssetModel.allAsset?self.userAssetModel.allAsset:@"0.00"] changeYFormatWithMoneyAmount];
        
//        if (self.userAssetModel) {
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//            if ([self.userAssetModel.allAsset intValue] == 0) {
//                self.totalMondyCell.totalMoney.text = [[NSString stringWithFormat:@"%@",self.userAssetModel.allAsset?self.userAssetModel.allAsset:@"0.00"] changeYFormatWithMoneyAmount];
//            }else{
//                self.step = sqrt([self.userAssetModel.allAsset doubleValue]);
//                self.totalMoney = 0.00;
//                self.totalMondyCell = cell;
//                
//                self.timers = [[NSMutableArray alloc] init];
//                
//                for (int i = 0; i < TimerNumber; i ++ ) {
//                    
//                    NSTimer *timer = [NSTimer timerWithTimeInterval:0.001  target:self selector:@selector(changeTotalMoney) userInfo:nil repeats:YES];
//                    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//                    [timer fire];
//                    [self.timers addObject:timer];
//                    
//                }
//            }
//            
//        }
        
        cell.rateLabel.text = [NSString stringWithFormat:@"昨日年化收益率    %@%%",self.userAssetModel.rate?self.userAssetModel.rate:@"0.00"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (1 == indexPath.row) {
        
        HomeAssetMiddleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeAssetMiddleTableViewCellID];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeAssetMiddleTableViewCell" owner:self options:nil] lastObject];
            
            [cell updateUIWithType:1];
            
            if (iPhone4) {
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 0.5, 5, 0.5, 60)];
                imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
                
                [cell.contentView addSubview:imageView];
                
            }else{
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 0.5, 5, 0.5, 0.15*(self.view.frame.size.height - 50) - 10)];
                imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
                
                [cell.contentView addSubview:imageView];
            
            }
            
            
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.putMoneyLabel.text = [[NSString stringWithFormat:@"%@",self.userAssetModel.invest?self.userAssetModel.invest:@"0.00"] changeYFormatWithMoneyAmount];
        cell.yestadyIncomeLabel.text = [[NSString stringWithFormat:@"%@",self.userAssetModel.yesterdayIncome?self.userAssetModel.yesterdayIncome:@"0.00"] changeYFormatWithMoneyAmount];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (2 == indexPath.row) {
        
        HomeAssetBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeAssetBottomTableViewCellID];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeAssetBottomTableViewCell" owner:self options:nil] lastObject];
            
            [cell updateUI];
            
            UITapGestureRecognizer *tapGesRecharge = [[UITapGestureRecognizer alloc] init];
            [tapGesRecharge addTarget:self action:@selector(tapGesRecharge)];
            [cell.rechargeImageView addGestureRecognizer:tapGesRecharge];
            
            UITapGestureRecognizer *tapGesDaw = [[UITapGestureRecognizer alloc] init];
            [tapGesDaw addTarget:self action:@selector(tapGesDaw)];
            [cell.withDrawImageView addGestureRecognizer:tapGesDaw];
            
            
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    static NSString *cellID = @"CELL_ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        FinancialProjectListViewController *financialProjectListViewController = [[FinancialProjectListViewController alloc] init];
        [self.navigationController pushViewController:financialProjectListViewController animated:YES];
    }

}

#pragma mark - APICmdApiCallBackDelegate

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
    [Tool hideHUD];
    
    if (baseAPICmd == self.noticeListAPICmd) {
        
        NSDictionary *tempDict = (NSDictionary *)responseData;
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
            [Tool ToastNotification:tempDict[@"msg"]];
            
        }else{
            
            NSArray *data = tempDict[@"data"];
            
            if (data && ![data isKindOfClass:[NSNull class]] && data.count != 0) {
                
                self.images = [[NSMutableArray alloc] initWithCapacity:20];
                
                for (NSDictionary *subDict in data) {
                    
                    NoticeListModel *model = [[NoticeListModel alloc] init];
                    [model setValuesForKeysWithDictionary:subDict];
                    [self.images addObject:model];
                }
                
                [self.contentTableView reloadData];
            }
            
        }
        
    }else if (baseAPICmd == self.userAssetAPICmd) {
        
        NSDictionary *tempDict = (NSDictionary *)responseData;
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
            [Tool ToastNotification:tempDict[@"msg"]];
            
        }else{
            
            self.userAssetModel = [[UserAssetModel alloc] init];
            
            [self.userAssetModel setValuesForKeysWithDictionary:tempDict[@"data"]];
            
            [self.contentTableView reloadData];
            
        }
        
    }
    
}

- (void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error {
    [Tool ToastNotification:@"获取数据失败"];
}

#pragma mark - event response



//活动banner点击事件
-(void)buttonClick:(int)vid {
    
    ActivityDetailViewController *activityDetailVC = [[ActivityDetailViewController alloc] init];
    
    NoticeListModel *model = self.images[vid - 1];
    activityDetailVC.url = model.url;
    
    [self.navigationController pushViewController:activityDetailVC animated:YES];
    
}

// 我要充值
- (void)tapGesRecharge {
    
    RechargeWithDrawDepositViewController *rechargeVC = [[RechargeWithDrawDepositViewController alloc] init];
    rechargeVC.isDeposite = NO;
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
}

//我要提现
- (void)tapGesDaw {
    
    RechargeWithDrawDepositViewController *withdrawdepositVC = [[RechargeWithDrawDepositViewController alloc] init];
    withdrawdepositVC.isDeposite = YES;
    [self.navigationController pushViewController:withdrawdepositVC animated:YES];
    
}

// 活动列表
- (void)activityList {
    
    RecentdynamicsVC *recentdynamicsVC = [[RecentdynamicsVC alloc] init];
    [self.navigationController pushViewController:recentdynamicsVC animated:YES];
}

- (void)selectItem:(UIButton *)sender {
    
    [[KxMenu sharedMenu] setIsShowPopView:YES];
    
    self.menuItems = @[[KxMenuItem menuItem:@"  收益记录"
                                      image:[UIImage imageNamed:@"ic_income_record"]
                                     target:self
                                     action:@selector(pushMenuItem:) tag:1 isSelect:NO],
                       
                       [KxMenuItem menuItem:@"  交易记录"
                                      image:[UIImage imageNamed:@"ic_trading_record"]
                                     target:self
                                     action:@selector(pushMenuItem:) tag:2 isSelect:NO],
                       
                       [KxMenuItem menuItem:@"活动劵" image:[UIImage imageNamed:@"huodongjuan"] target:self action:@selector(pushMenuItem:) tag:3 isSelect:NO],
                       
                       [KxMenuItem menuItem:@"  我的账户"
                                      image:[UIImage imageNamed:@"ic_account"]
                                     target:self
                                     action:@selector(pushMenuItem:) tag:4 isSelect:NO]];
                       
    
    CGRect rect = sender.frame;
    rect.origin.y = 54;
    [KxMenu showMenuInView:self.navigationController.view
                  fromRect:rect
                 menuItems:self.menuItems];
    
}

//右上角类型选择
- (void)pushMenuItem:(id)sender {
    
    [[KxMenu sharedMenu] setIsShowPopView:NO];
    
    KxMenuItem *item = (KxMenuItem *)sender;
    
    switch (item.tag) {
        case 1:{
            
            EarningsRecordViewController *earningsRecordViewController = [[EarningsRecordViewController alloc] init];
            [self.navigationController pushViewController:earningsRecordViewController animated:YES];
        }
            
            break;
        case 2:{
            DealDetailViewController *dealDetailViewController = [[DealDetailViewController alloc] init];
            [self.navigationController pushViewController:dealDetailViewController animated:YES];
        }
            break;
        case 3:{
            InterestRateCouponViewController *interestRateCouponViewController = [[InterestRateCouponViewController alloc] init];
            [self.navigationController pushViewController:interestRateCouponViewController animated:YES];

        }
            
            break;
        case 4:{
            //我的账户
            MyaccountnumberVC *myaccountnumberVC = [[MyaccountnumberVC alloc] init];
            [self.navigationController pushViewController:myaccountnumberVC animated:YES];
                    }
            break;
        default:
            break;
    }

    
}

- (void)invast {
    
    InvestmentListViewController *investmentListViewController = [[InvestmentListViewController alloc] init];
    [self.navigationController pushViewController:investmentListViewController animated:YES];
}

#pragma mark - private method

- (void)changeTotalMoney {
    
    self.totalMoney += self.step;
    
    if (self.totalMoney > [self.userAssetModel.allAsset intValue]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.totalMondyCell.totalMoney.text = [[NSString stringWithFormat:@"%@",self.userAssetModel.allAsset?self.userAssetModel.allAsset:@"0.00"] changeYFormatWithMoneyAmount];
        });
        
        
        for (int i = 0; i < TimerNumber; i ++) {
            NSTimer * timer = self.timers[i];
            [timer invalidate];
            timer = nil;
        }
        
        self.timers = nil;
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.totalMondyCell.totalMoney.text = [[NSString stringWithFormat:@"%d",(int)self.totalMoney] changeYFormatWithMoneyAmount];
        });
    }
    
}

#pragma mark - getters and setters

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50 - 64) style:UITableViewStyleGrouped];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
    }
    return _contentTableView;
}

- (BMAdScrollView *)bmadScrollView {
    
    if (!_bmadScrollView) {
        
        NSMutableArray *tempImages = [[NSMutableArray alloc] init];
        
        for (NoticeListModel *model in self.images) {
            [tempImages addObject:model.titleImg];
        }
        
        _bmadScrollView = [[BMAdScrollView alloc] initWithNameArr:tempImages height:self.topBackGroudView.frame.size.height offsetY:0];
        _bmadScrollView.vDelegate = self;
        _bmadScrollView.pageCenter = CGPointMake(kScreenWidth/2, self.topBackGroudView.frame.size.height - 30);
        
    }
    return _bmadScrollView;
}

- (UIView *)topBackGroudView
{
    if (!_topBackGroudView) {
        _topBackGroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.3*self.view.frame.size.height + 20)];
    }
    return _topBackGroudView;
}

- (UIImageView *)unloginImgView {
    if (!_unloginImgView) {
        UIImage *image = [UIImage imageNamed:@"ic_empty.jpg"];
        _unloginImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.topBackGroudView.frame.size.width, self.topBackGroudView.frame.size.height)];
        _unloginImgView.image = image;
    }
    return _unloginImgView;
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.frame = CGRectMake(0, self.view.frame.size.height - 50 - 64, kScreenWidth, 50);
        [_bottomButton setTitle:@"立即投资" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(invast) forControlEvents:UIControlEventTouchUpInside];
        _bottomButton.backgroundColor = COLOR(239, 71, 26, 1.0);
        
    }
    return _bottomButton;
}

- (NoticeListAPICmd *)noticeListAPICmd {
    if (!_noticeListAPICmd) {
        _noticeListAPICmd = [[NoticeListAPICmd alloc] init];
        _noticeListAPICmd.delegate = self;
        _noticeListAPICmd.path = API_NoticeList;
    }
    _noticeListAPICmd.reformParams = @{@"type":@"1",@"pageNum":@"1"};
    return _noticeListAPICmd;
}

- (UserAssetAPICmd *)userAssetAPICmd {
    if (!_userAssetAPICmd) {
        _userAssetAPICmd = [[UserAssetAPICmd alloc] init];
        _userAssetAPICmd.delegate = self;
        _userAssetAPICmd.path = API_UserAsset;
    }
    _userAssetAPICmd.reformParams = @{@"id":[Tool getUserInfo][@"id"]};
    return _userAssetAPICmd;
}

@end
