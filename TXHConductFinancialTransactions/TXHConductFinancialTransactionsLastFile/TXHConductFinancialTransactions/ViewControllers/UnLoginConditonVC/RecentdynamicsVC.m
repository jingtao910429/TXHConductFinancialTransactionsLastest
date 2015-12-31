//
//  RecentdynamicsVC.m
//  TXHConductFinancialTransactions
//
//  Created by 吴建良 on 15/11/5.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "RecentdynamicsVC.h"

#import "RecentdynamicsCell.h"
#import "Recentdynamicsmd.h"
#import "MJRefresh.h"
#import "NoticeListModel.h"
#import "UIImageView+WebCache.h"
#import "ActivityDetailViewController.h"

#define Header_Height 40

@interface RecentdynamicsVC ()<UITableViewDelegate,UITableViewDataSource,APICmdApiCallBackDelegate>{
    
    UITableView         *_lefttableView;
    int                 index;
}

@property (nonatomic, strong) Recentdynamicsmd *recentdynamicsmd;
@property (nonatomic,retain) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation RecentdynamicsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationBarStyleWithTitle:@"最近动态" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    
    [self configData];
    [self configUI];
    
    [self.recentdynamicsmd loadData];
    
}
#pragma mark - 配置视图
- (void)configUI{
    
    _lefttableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _lefttableView.delegate = self;
    _lefttableView.dataSource = self;
    _lefttableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _lefttableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_lefttableView];
    
    [_lefttableView addSubview:self.refreshControl];
    
    //上拉加载
    _lefttableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pollUpReloadData)];
    
}

- (void)configData {
    index = 1;
    self.dataSource = [[NSMutableArray alloc] init];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count * 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (1 == indexPath.row % 2) {
        return 5;
    }
    return 185;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row % 2) {
        
        static NSString *CellIdentifier = @"RecentdynamicsCell";
        RecentdynamicsCell *cell = (RecentdynamicsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            
            cell = [[ RecentdynamicsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.layer.cornerRadius = 4;
            cell.layer.masksToBounds = YES;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        if (self.dataSource.count !=0 ) {
            
            NoticeListModel *model = self.dataSource[indexPath.row / 2];
            
            UIActivityIndicatorView *activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            [cell.bgimageview addSubview:activityIndicator];
            
            __block UIActivityIndicatorView *weakActivityIndicator = activityIndicator;
            
            [cell.bgimageview sd_setImageWithURL:[NSURL URLWithString:model.titleImg] placeholderImage:[UIImage imageNamed:@"ic_empty"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
                if (!weakActivityIndicator) {
                    weakActivityIndicator.center = cell.bgimageview.center;
                    [weakActivityIndicator startAnimating];
                }
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [weakActivityIndicator removeFromSuperview];
            }];
            
            cell.textlable.text = [NSString stringWithFormat:@"%@",model.title?model.title:@""];
            
        }else{
            cell.bgimageview.image = [UIImage imageNamed:@"ic_empty.jpg"];
            
            cell.textlable.text=@"小武，不要每天太晚休息啊，身体也是重要的";
        }
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (0 == indexPath.row % 2) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NoticeListModel *model = self.dataSource[indexPath.row / 2];
        
        ActivityDetailViewController *activityDetailVC = [[ActivityDetailViewController alloc] init];
    
        activityDetailVC.url = model.url;
        
        [self.navigationController pushViewController:activityDetailVC animated:YES];
        
    }
    
    
    
}

#pragma mark - APICmdApiCallBackDelegate

-(void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData
{
    if (baseAPICmd ==self.recentdynamicsmd) {
        
        NSDictionary *tempDict = (NSDictionary *)responseData;
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
            [Tool ToastNotification:tempDict[@"msg"]];
            
        }else{
            
            NSArray *data = tempDict[@"data"];
            
            if (data && ![data isKindOfClass:[NSNull class]] && data.count != 0) {
                
                if (1 == index) {
                    self.dataSource = [[NSMutableArray alloc] initWithCapacity:20];
                }
                
                for (NSDictionary *subDict in data) {
                    
                    NoticeListModel *model = [[NoticeListModel alloc] init];
                    [model setValuesForKeysWithDictionary:subDict];
                    [self.dataSource addObject:model];
                }
                
                [_lefttableView reloadData];
            }else{
                [Tool ToastNotification:@"没有更多内容"];
            }
            
        }
        
        [self.refreshControl endRefreshing];
        [_lefttableView.footer endRefreshing];
    }
}

-(void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error{
    [Tool ToastNotification:@"加载失败"];
}

#pragma mark - life cycle

#pragma mark - event response
#pragma mark - private method

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

//下拉刷新
- (void)reload:(__unused id)sender {
    
    index = 1;
    
    [self.recentdynamicsmd loadData];
    
}

- (void)pollUpReloadData {
    
    index ++;
    [self.recentdynamicsmd loadData];
    
}

#pragma mark - getters and setters

- (Recentdynamicsmd *)recentdynamicsmd {
    if (!_recentdynamicsmd) {
        _recentdynamicsmd = [[Recentdynamicsmd alloc] init];
        _recentdynamicsmd.delegate = self;
        _recentdynamicsmd.path = API_List;
    }
    _recentdynamicsmd.reformParams = @{@"type":@"2",@"pageNum":[NSString stringWithFormat:@"%d",index]};
    return _recentdynamicsmd;
}

- (UIRefreshControl *)refreshControl {
    
    if (!_refreshControl) {
        
        _refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _lefttableView.frame.size.width, -Header_Height)];
        [_refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}


@end
