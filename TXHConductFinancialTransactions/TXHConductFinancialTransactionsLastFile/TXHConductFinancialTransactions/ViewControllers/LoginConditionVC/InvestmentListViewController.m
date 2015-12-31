//
//  InvestmentListViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "InvestmentListViewController.h"
#import "MJRefresh.h"
#import "InvestmentListAPICmd.h"
#import "InvestmentListModel.h"
#import "InvestmentTopTableViewCell.h"
#import "InvestmentBottomMTableViewCell.h"
#import "InvestmentBottomLTableViewCell.h"
#import "ItemDetailViewController.h"
#import "NSString+Additions.h"
#import "InvestmentViewController.h"

#define Header_Height 40

@interface InvestmentListViewController () <UITableViewDataSource,UITableViewDelegate,APICmdApiCallBackDelegate>

@property (nonatomic, strong) UITableView     *contentTableView;
@property (nonatomic,retain) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSMutableArray *dataSource;

//分页
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) InvestmentListAPICmd *investmentListAPICmd;

@end

@implementation InvestmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configData {
    
    self.index = 1;
    self.dataSource = [[NSMutableArray alloc] init];
    [self.investmentListAPICmd loadData];
}

- (void)configUI {
    
    [self navigationBarStyleWithTitle:@"投资列表" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    
    [self.view addSubview:self.contentTableView];
    
    [self.contentTableView addSubview:self.refreshControl];
    
    //上拉加载
    self.contentTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pollUpReloadData)];
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (1 == section % 2) {
        return 10;
    }
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        return 50;
    }else if (1 == indexPath.row) {
        return 65;
    }
    
    InvestmentListModel *investmentListModel = self.dataSource[indexPath.section / 2];
    
    if (2 == [investmentListModel.status intValue]) {
        return 140;
    }
    
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count * 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (1 == section % 2) {
        return 0;
    }
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (1 == indexPath.section % 2) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            
        }
        
        cell.contentView.backgroundColor = COLOR(232, 232, 232, 1.0);
        
        return cell;
    }
    
    InvestmentListModel *investmentListModel = self.dataSource[indexPath.section / 2];
    
    if (0 == indexPath.row) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49.5, kScreenWidth, 0.5)];
            imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
            
            [cell.contentView addSubview:imageView];
            
        }
        
        if (2 == [investmentListModel.status intValue]) {
            cell.imageView.image = [UIImage imageNamed:@"ic_project"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"ic_project_gray"];
        }
        
        
        cell.textLabel.text = investmentListModel.name;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }else if (1 == indexPath.row) {
        
        static NSString *cellID = @"InvestmentTopTableViewCellID";
        
        InvestmentTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InvestmentTopTableViewCell" owner:self options:nil] lastObject];
            [cell updateUI];
        }
        cell.totalMoneyLabel.text = [NSString stringWithFormat:@"%@万",[[NSString stringWithFormat:@"%@",investmentListModel.money?investmentListModel.money:@"0.00"] changeWYFormatWithMoneyAmount]];
        cell.rateLabel.text = [NSString stringWithFormat:@"%@%%",investmentListModel.rate?investmentListModel.rate:@"0.00%"];
        cell.investNumberLabel.text = [NSString stringWithFormat:@"%@",investmentListModel.version?investmentListModel.version:@"0"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else {
        
        
        
        if (2 == [investmentListModel.status intValue]) {
            //开始状态(2)关闭状态(3)
            
            static NSString *CellIdentifier = @"InvestmentBottomMTableViewCellID";
            
            InvestmentBottomMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InvestmentBottomMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.zdProgressView.progress = [investmentListModel.realMoney floatValue] / [investmentListModel.money floatValue];
            
//            cell.zdProgressView.progress = [investmentListModel.rate floatValue] / 100.00;
            cell.zdProgressView.text = [NSString stringWithFormat:@"%.2f%%",[investmentListModel.realMoney floatValue] / [investmentListModel.money floatValue] * 100.00];
            

            cell.contentLabel.text =  [NSString stringWithFormat:@"还可以投资%@元",[[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",[investmentListModel.money?investmentListModel.money:@"0.00" floatValue] - [investmentListModel.realMoney?investmentListModel.realMoney:@"0.00" floatValue]]] changeYFormatWithMoneyAmount]];
            
            cell.investmentButton.tag = indexPath.section;
            
            [cell.investmentButton addTarget:self action:@selector(investmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }else{
            
            static NSString *CellIdentifier = @"InvestmentBottomLTableViewCellID";
            
            InvestmentBottomLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InvestmentBottomLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.investmentButton.enabled = NO;
            [cell.investmentButton setTitle:@"该项目已抢购完" forState:UIControlStateNormal];
            cell.investmentButton.backgroundColor = [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (0 == indexPath.section % 2 && 0 == indexPath.row) {
        
        ItemDetailViewController *itemDetailViewController = [[ItemDetailViewController alloc] init];
        itemDetailViewController.investmentListModel = self.dataSource[indexPath.section/2];
        [self.navigationController pushViewController:itemDetailViewController animated:YES];
    }
    
}

#pragma mark - APICmdApiCallBackDelegate

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {

    
    if (baseAPICmd == self.investmentListAPICmd) {
        
        NSDictionary *tempDict = (NSDictionary *)responseData;
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
            [Tool ToastNotification:tempDict[@"msg"]];
            
        }else{
            
            NSArray *data = tempDict[@"data"];
            
            if (data && ![data isKindOfClass:[NSNull class]] && data.count != 0) {
                
                if (1 == self.index) {
                    self.dataSource = [[NSMutableArray alloc] initWithCapacity:20];
                }
                
                for (NSDictionary *subDict in data) {
                    
                    InvestmentListModel *model = [[InvestmentListModel alloc] init];
                    [model setValuesForKeysWithDictionary:subDict];
                    model.ID = subDict[@"id"];
                    [self.dataSource addObject:model];
                }
                
                [self.contentTableView reloadData];
            }else{
                
                [Tool ToastNotification:@"没有更多内容"];
                
            }
            
        }
        
        [self.refreshControl endRefreshing];
        [self.contentTableView.footer endRefreshing];
    }
    
}

- (void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error {
    
    [Tool ToastNotification:@"加载失败"];
    
}

#pragma mark - event response

- (void)investmentButtonClick:(UIButton *)sender {
    
    InvestmentViewController *investmentViewController = [[InvestmentViewController alloc] init];
    investmentViewController.investmentListModel = self.dataSource[sender.tag/2];
    [self.navigationController pushViewController:investmentViewController animated:YES];
    
}

#pragma mark - private method

//下拉刷新
- (void)reload:(__unused id)sender {
    
    self.index = 1;
    [self.investmentListAPICmd loadData];
}

- (void)pollUpReloadData {
    
    self.index ++;
    [self.investmentListAPICmd loadData];
    
}


- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getters and setters

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - 64) style:UITableViewStyleGrouped];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.showsVerticalScrollIndicator = NO;
    }
    return _contentTableView;
}

- (UIRefreshControl *)refreshControl {
    
    if (!_refreshControl) {
        
        _refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.contentTableView.frame.size.width, Header_Height)];
        [_refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (InvestmentListAPICmd *)investmentListAPICmd {
    if (!_investmentListAPICmd) {
        _investmentListAPICmd = [[InvestmentListAPICmd alloc] init];
        _investmentListAPICmd.delegate = self;
        _investmentListAPICmd.path = API_product;
    }
    
    _investmentListAPICmd.reformParams = @{@"pageNum":[NSString stringWithFormat:@"%d",(int)self.index]};
    return _investmentListAPICmd;
}

@end
