//
//  InterestRateCouponViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/11.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "InterestRateCouponViewController.h"
#import "InterestRateCouponAPICmd.h"
#import "MJRefresh.h"
#import "NSString+Additions.h"
#import "InterestRateCouponModel.h"
#import "CuponTableViewCell.h"

@interface InterestRateCouponViewController () <UITableViewDataSource,UITableViewDelegate,APICmdApiCallBackDelegate>


@property (nonatomic, strong) UITableView     *contentTableView;
@property (nonatomic,retain) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) InterestRateCouponAPICmd *interestRateCouponAPICmd;

@property (nonatomic, strong) InterestRateCouponModel *interestRateCouponModel;

//分页
@property (nonatomic, assign) NSInteger index;

@end

@implementation InterestRateCouponViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configData];
    [self configUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configData {
    
    self.index = 1;
    self.dataSource = [[NSMutableArray alloc] init];
    [self.interestRateCouponAPICmd loadData];
}

- (void)configUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigationBarStyleWithTitle:@"我的活动卷" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    
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
        return 130;
    }
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (1 == indexPath.row % 2) {
        
        static NSString *cellID = @"CuponTableViewCellID";
        
        CuponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CuponTableViewCell" owner:self options:nil] lastObject];
            [cell updateUI];
            cell.layer.cornerRadius = 4;
            cell.layer.masksToBounds = YES;
        }
        
        /*
         {
         "id":3,// id
         "activeId":6,// 活动ID
         "type":1,// 类型（1=体验金，2=加息券）
         "value":150// 值（体验金倍数/加成年利率）
         "day":0,// 有效天数
         "limit":1000,// 最少投资金额
         "createDate":"2015-11-05 14:29:24",// 领取日期
         }
         
         */
        
        InterestRateCouponModel *model = self.dataSource[indexPath.row/2];
        
        cell.backGroundImageView.image = [UIImage imageNamed:@"list_white"];
        cell.takeLabel.text = @"已经领取";
        
        if ([model.value floatValue] > 0) {
            cell.contentLabel.text = [NSString stringWithFormat:@"加息劵+%.1f%%",[model.value floatValue]/100.00];
        }else{
            cell.contentLabel.text = [NSString stringWithFormat:@"加息劵-%.1f%%",[model.value floatValue]/100.00];
        }
        
        BOOL isTake = YES;
        
        if (1 == [model.type intValue]) {
            
            if ([model.day intValue] > 0) {
                cell.takeLabel.text = @"立即领取";
                cell.backGroundImageView.image = [UIImage imageNamed:@"list_red"];
                isTake = NO;
            }
            
        }else if (2 == [model.type intValue]) {
            
            if ([model.day intValue] > 0) {
                cell.takeLabel.text = @"立即领取";
                cell.backGroundImageView.image = [UIImage imageNamed:@"list_green"];
                isTake = NO;
            }
            
        }
        
        
        
        cell.createTimeLabel.text = [NSString stringWithFormat:@"领取日期：%@",[[NSString stringWithFormat:@"%@",model.createDate] componentsSeparatedByString:@"+"][0]];
        
        if (!isTake) {
            NSArray *times = [model.createDate componentsSeparatedByString:@"+"];
            NSString *time = [NSString stringWithFormat:@"%@ %@",times[0],times[1]];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSTimeInterval now = [[formatter dateFromString:time] timeIntervalSinceNow];
            
            cell.restDayLabel.text = [NSString stringWithFormat:@"剩余天数：%d天",(int)(now / (24 * 60 * 60))];
        }else{
            cell.restDayLabel.text = @"剩余天数：0天";
        }
        
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    InterestRateCouponModel *model = self.dataSource[indexPath.row/2];
    
}

#pragma mark - APICmdApiCallBackDelegate

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
    if (baseAPICmd ==self.interestRateCouponAPICmd) {
        
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
                    
                    InterestRateCouponModel  *model = [[InterestRateCouponModel alloc] init];
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
    [self.interestRateCouponAPICmd loadData];
    
}

- (void)pollUpReloadData {
    
    self.index ++;
    [self.interestRateCouponAPICmd loadData];
    
}

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - getters and setters

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width - 10, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
        
        _refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.contentTableView.frame.size.width, -40)];
        [_refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (InterestRateCouponAPICmd *)interestRateCouponAPICmd {
    if (!_interestRateCouponAPICmd) {
        _interestRateCouponAPICmd = [[InterestRateCouponAPICmd alloc] init];
        _interestRateCouponAPICmd.delegate = self;
        _interestRateCouponAPICmd.path = API_ActiveLog;
    }
    _interestRateCouponAPICmd.reformParams = @{@"id":[Tool getUserInfo][@"id"],@"pageNum":[NSString stringWithFormat:@"%d",(int)self.index]};
    return _interestRateCouponAPICmd;
}


@end
