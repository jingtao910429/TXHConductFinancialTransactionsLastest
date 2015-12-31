//
//  DealDetailViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "DealDetailViewController.h"
#import "DealDetailTableViewCell.h"
#import "DealDetailModel.h"
#import "DealDetailAPICmd.h"
#import "MJRefresh.h"
#import "NSString+Additions.h"

#define Header_Height 40

@interface DealDetailViewController () <UITableViewDataSource,UITableViewDelegate,APICmdApiCallBackDelegate>

@property (nonatomic, strong) UITableView     *contentTableView;
@property (nonatomic,retain) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) DealDetailAPICmd *dealDetailAPICmd;

//分页
@property (nonatomic, assign) NSInteger index;

@end

@implementation DealDetailViewController

#pragma mark - life cycle

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
    [self.dealDetailAPICmd loadData];
}

- (void)configUI {
    
    [self navigationBarStyleWithTitle:@"交易记录" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];

    [self.view addSubview:self.contentTableView];
    
    [self.contentTableView addSubview:self.refreshControl];
    
    //上拉加载
    self.contentTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pollUpReloadData)];
    
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (1 == indexPath.row % 2) {
        return 60;
    }
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (1 == indexPath.row % 2) {
        
        static NSString *cellID = @"DealDetailTableViewCellID";
        
        DealDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DealDetailTableViewCell" owner:self options:nil] lastObject];
            
            cell.layer.cornerRadius = 4;
            cell.layer.masksToBounds = YES;
        }
        
        [cell updateUI];
        
        DealDetailModel *model = self.dataSource[indexPath.row / 2];
        
        if (1 == [model.type intValue]) {
            cell.titleLabel.text = @"充值";
        }else if (2 == [model.type intValue]) {
            cell.titleLabel.text = @"投资";
        }else if (3 == [model.type intValue]) {
            cell.titleLabel.text = @"提现申请";
        }else if (4 == [model.type intValue]) {
            cell.titleLabel.text = @"提现成功";
        }else if (5 == [model.type intValue]) {
            cell.titleLabel.text = @"提现失败";
        }
        
        
        cell.moneyLabel.text = [[NSString stringWithFormat:@"%@",model.money?model.money:@"0.00"] changeYFormatWithMoneyAmount];
        cell.contentLabel.text = [NSString stringWithFormat:@"%@",model.productName?model.productName:@""];
        
        NSString *timeStr = [NSString stringWithFormat:@"%@",model.date?model.date:@""];
        NSArray *times = [timeStr componentsSeparatedByString:@"+"];
        
        cell.timeLabel.text = [times componentsJoinedByString:@" "];
        
        return cell;
        
        
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            
        }
        
        cell.contentView.backgroundColor = COLOR(232, 232, 232, 1.0);
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - APICmdApiCallBackDelegate

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
    if (baseAPICmd ==self.dealDetailAPICmd) {
        
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
                    
                    DealDetailModel *model = [[DealDetailModel alloc] init];
                    [model setValuesForKeysWithDictionary:subDict];
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
#pragma mark - private method

//下拉刷新
- (void)reload:(__unused id)sender {
    
    self.index = 1;
    [self.dealDetailAPICmd loadData];
    
}

- (void)pollUpReloadData {
    
    self.index ++;
    [self.dealDetailAPICmd loadData];
    
}

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getters and setters

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
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
        
        _refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.contentTableView.frame.size.width, -Header_Height)];
        [_refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (DealDetailAPICmd *)dealDetailAPICmd {
    if (!_dealDetailAPICmd) {
        _dealDetailAPICmd = [[DealDetailAPICmd alloc] init];
        _dealDetailAPICmd.delegate = self;
        _dealDetailAPICmd.path = API_DealDetail;
    }
    
    _dealDetailAPICmd.reformParams = @{@"id":[Tool getUserInfo][@"id"],@"pageNum":[NSString stringWithFormat:@"%d",(int)self.index]};
    return _dealDetailAPICmd;
}

@end
