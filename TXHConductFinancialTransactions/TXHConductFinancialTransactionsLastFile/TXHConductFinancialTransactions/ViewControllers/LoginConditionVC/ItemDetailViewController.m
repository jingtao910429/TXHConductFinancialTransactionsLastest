//
//  ItemDetailViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/7.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "InvestmentTopTableViewCell.h"
#import "InvestmentBottomMTableViewCell.h"
#import "InvestmentBottomLTableViewCell.h"
#import "NSString+Additions.h"
#import "ItemTypeViewController.h"
#import "InvestmentViewController.h"

@interface ItemDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView     *contentTableView;

@property (nonatomic, copy) NSArray *names;
@property (nonatomic, copy) NSArray *texts;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)configData {
    self.names = @[@"计息时间",@"项目期限",@"保障措施",@"项目类型"];
    self.texts = @[@"投资后立即计息",@"活期",@"100%本息保障",@"查看项目类型"];
}

- (void)configUI {
    
    [self navigationBarStyleWithTitle:@"投资" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    
    [self.view addSubview:self.contentTableView];
    
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
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            return 50;
        }else if (1 == indexPath.row) {
            return 65;
        }else{
            
            if (2 == [self.investmentListModel.status intValue]) {
                return 140;
            }
            
            return 60;
        }
    }
    
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (1 == section % 2) {
        return 0;
    }else if (0 == section) {
        return 3;
    }
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (1 == indexPath.section % 2 || 2 == indexPath.section) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            
            if (1 != indexPath.section % 2) {
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49.5, kScreenWidth, 0.5)];
                imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
                
                [cell.contentView addSubview:imageView];
                
                UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, kScreenWidth - 150, 40)];
                contentLabel.textAlignment = NSTextAlignmentRight;
                contentLabel.font = [UIFont systemFontOfSize:16];
                contentLabel.tag = 1;
                [cell.contentView addSubview:contentLabel];
            }
            
        }
        
        if (1 == indexPath.section % 2) {
            cell.contentView.backgroundColor = COLOR(232, 232, 232, 1.0);
        }else{
            
            cell.textLabel.text = self.names[indexPath.row];
            
            UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:1];
            contentLabel.text = self.texts[indexPath.row];
            
            if (3 == indexPath.row) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
        }
        return cell;
    }
    
    if (0 == indexPath.row) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49.5, kScreenWidth, 0.5)];
            imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
            
            [cell.contentView addSubview:imageView];
            
        }
        
        if (2 == [self.investmentListModel.status intValue]) {
            cell.imageView.image = [UIImage imageNamed:@"ic_project"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"ic_project_gray"];
        }
        
        cell.textLabel.text = self.investmentListModel.name;
        return cell;
        
    }else if (1 == indexPath.row) {
        
        static NSString *cellID = @"InvestmentTopTableViewCellID";
        
        InvestmentTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InvestmentTopTableViewCell" owner:self options:nil] lastObject];
            [cell updateUI];
        }
        
        cell.totalMoneyLabel.text = [NSString stringWithFormat:@"%@万",[[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",[self.investmentListModel.money?self.investmentListModel.money:@"0.00" floatValue]]] changeWYFormatWithMoneyAmount]];
        cell.rateLabel.text = [NSString stringWithFormat:@"%@%%",self.investmentListModel.rate?self.investmentListModel.rate:@"0.00%%"];
        cell.investNumberLabel.text = [NSString stringWithFormat:@"%@",self.investmentListModel.version?self.investmentListModel.version:@"0"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else {
        
        
        
        if (2 == [self.investmentListModel.status intValue]) {
            //开始状态
            
            static NSString *CellIdentifier = @"InvestmentBottomMTableViewCellID";
            
            InvestmentBottomMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InvestmentBottomMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.zdProgressView.progress = [self.investmentListModel.realMoney floatValue] / [self.investmentListModel.money floatValue];
            cell.zdProgressView.text = [NSString stringWithFormat:@"%.2f%%",[self.investmentListModel.realMoney floatValue] / [self.investmentListModel.money floatValue] * 100.00];
            
//            cell.zdProgressView.progress = [self.investmentListModel.rate floatValue] / 100.00;
//            cell.zdProgressView.text = [NSString stringWithFormat:@"%.2f%%",[self.investmentListModel.rate floatValue]];
            cell.contentLabel.text =  [NSString stringWithFormat:@"还可以投资%@元",[[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",[self.investmentListModel.money?self.investmentListModel.money:@"0.00" floatValue] - [self.investmentListModel.realMoney?self.investmentListModel.realMoney:@"0.00" floatValue]]] changeYFormatWithMoneyAmount]];
            
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
    
    if (2 == indexPath.section) {
        
        if (3 == indexPath.row) {
            ItemTypeViewController *itemTypeViewController = [[ItemTypeViewController alloc] init];
            [self.navigationController pushViewController:itemTypeViewController animated:YES];
        }
        
    }
}

#pragma mark - private method

- (void)investmentButtonClick:(UIButton *)sender {
    
    InvestmentViewController *investmentViewController = [[InvestmentViewController alloc] init];
    investmentViewController.investmentListModel = self.investmentListModel;
    [self.navigationController pushViewController:investmentViewController animated:YES];
    
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

@end
