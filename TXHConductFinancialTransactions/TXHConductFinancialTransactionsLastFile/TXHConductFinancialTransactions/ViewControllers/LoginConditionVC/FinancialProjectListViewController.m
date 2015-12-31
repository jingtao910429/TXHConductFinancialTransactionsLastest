//
//  FinancialProjectListViewController.m
//  TXHConductFinancialTransactions
//
//  Created by rongyu100 on 15/11/24.
//  Copyright © 2015年 rongyu. All rights reserved.
//

#import "FinancialProjectListViewController.h"
#import "TXHConductFinancialTransactions-Swift.h"
#import "FinancialProjectListAPICmd.h"

@interface FinancialProjectListViewController () <ChartViewDelegate,UITableViewDataSource,UITableViewDelegate,APICmdApiCallBackDelegate>

@property (nonatomic, strong) PieChartView *chartView;
@property (nonatomic, strong) UITableView     *contentTableView;
@property (nonatomic, strong) NSMutableArray  *dataSource;

@property (nonatomic, strong) NSMutableArray *parties;

@property (nonatomic, strong) FinancialProjectListAPICmd *financialProjectListAPICmd;

@property (nonatomic, strong) NSMutableArray *values;

@property (nonatomic, strong) UIView          *tipView;

@property (nonatomic, copy) NSString *allAsset;

@end

@implementation FinancialProjectListViewController

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
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    self.title = @"资产详情（元）";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.parties = [[NSMutableArray alloc] initWithArray:@[
                                                           @"利息收益  ", @"体验金  ", @"剩余资产  ", @"实际投资  "
                                                           ]];
    
    self.values = [[NSMutableArray alloc] initWithObjects:@"0.0",@"0.0",@"0.0",@"0.0", nil];
    
}

- (void)configUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigationBarStyleWithTitle:@"资产详情" titleColor:[UIColor blackColor]  leftTitle:nil leftImageName:@"back" leftAction:@selector(popVC) rightTitle:nil rightImageName:nil rightAction:nil];
    
    [self.view addSubview:self.contentTableView];
    
    [self.financialProjectListAPICmd loadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.chartView.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.chartView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
        
        cell.contentView.backgroundColor = COLOR(232, 232, 232, 1.0);
        
    }
    
    [self.tipView removeFromSuperview];
    [cell.contentView addSubview:self.tipView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - APICmdApiCallBackDelegate 

- (void)apiCmdDidSuccess:(RYBaseAPICmd *)baseAPICmd responseData:(id)responseData {
    
    
    if (baseAPICmd == self.financialProjectListAPICmd) {
        
        NSDictionary *tempDict = (NSDictionary *)responseData;
        
        if ([tempDict[@"result"] intValue] != LoginTypeSuccess) {
            
            [Tool ToastNotification:tempDict[@"msg"]];
            
        }else{
            
            //NSLog(@"-- %@",responseData);
            
            self.allAsset = tempDict[@"data"][@"allAsset"];
            self.values = [[NSMutableArray alloc] initWithCapacity:5];
            
            [self.values addObject:tempDict[@"data"][@"income"]];
            [self.values addObject:tempDict[@"data"][@"tiYanJin"]];
            [self.values addObject:tempDict[@"data"][@"remainAsset"]];
            [self.values addObject:tempDict[@"data"][@"invest"]];
            
            [self setDataCount:4 range:4];
        }
        
    }
    
}

- (void)apiCmdDidFailed:(RYBaseAPICmd *)baseAPICmd error:(NSError *)error {
    
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}


#pragma mark - private method

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setDataCount:(int)count range:(double)range
{
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    for (int i = 0; i < count; i++)
    {
        
        BarChartDataEntry *dataEntry = [[BarChartDataEntry alloc] initWithValue:0.25 xIndex:i];
        
        if (i == count - 1) {
            ((ChartDataEntry *)dataEntry).realValue = ([self.values[i] floatValue] - [self.values[0] floatValue]) / 100.00;
        }else{
            ((ChartDataEntry *)dataEntry).realValue = [self.values[i] floatValue] / 100.00;
        }
        
        
        [yVals1 addObject:dataEntry];
    }
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:self.parties[i % self.parties.count]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithYVals:yVals1 label:@"   "];
    dataSet.sliceSpace = 0.5;
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObject:[UIColor colorWithRed:243.0/255.f green:80.0/255.f blue:80.0/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:198.0/255.f green:198.0/255.f blue:198.0/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:222.0/255.f green:117/255.f blue:47/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:80/255.f green:153/255.f blue:243/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" ";
    [data setValueFormatter:pFormatter];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;

    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总资产\n%@",[NSString stringWithFormat:@"%.2f",(self.allAsset ? [self.allAsset floatValue] :0.00)/100.00]]];
    [centerText setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, centerText.length)];
    _chartView.centerAttributedText = centerText;
    
    _chartView.data = data;
    [_chartView highlightValues:nil];
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleValues"])
    {
        for (ChartDataSet *set in _chartView.data.dataSets)
        {
            set.drawValuesEnabled = !set.isDrawValuesEnabled;
        }
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleXValues"])
    {
        _chartView.drawSliceTextEnabled = !_chartView.isDrawSliceTextEnabled;
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"togglePercent"])
    {
        _chartView.usePercentValuesEnabled = !_chartView.isUsePercentValuesEnabled;
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleHole"])
    {
        _chartView.drawHoleEnabled = !_chartView.isDrawHoleEnabled;
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"drawCenter"])
    {
        _chartView.drawCenterTextEnabled = !_chartView.isDrawCenterTextEnabled;
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"animateX"])
    {
        [_chartView animateWithXAxisDuration:1.4];
    }
    
    if ([key isEqualToString:@"animateY"])
    {
        [_chartView animateWithYAxisDuration:1.4];
    }
    
    if ([key isEqualToString:@"animateXY"])
    {
        [_chartView animateWithXAxisDuration:1.4 yAxisDuration:1.4];
    }
    
    if ([key isEqualToString:@"spin"])
    {
        [_chartView spinWithDuration:2.0 fromAngle:_chartView.rotationAngle toAngle:_chartView.rotationAngle + 360.f];
    }
    
    if ([key isEqualToString:@"saveToGallery"])
    {
        [_chartView saveToCameraRoll];
    }
}

-(void)cretedowntextWithView:(UIView *)contentView{
    
    
    NSArray*lableTextArr=@[@"利息收益：用户投资获取的利息", @"体验金：用户参与活动，赠送的体验金", @"剩余资产：用户充值后，暂未投资的金额", @"实际投资：用户实际投资的金额"];
    
    
    for (int i=0; i<4; i++) {
        
        int col = i%4;
        CGRect rect = CGRectMake(12, 40+col*40,10, 10);
        CGRect rect2 = CGRectMake(30, 30+col*40,kScreenWidth-40, 30);
        
        
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

- (PieChartView *)chartView {
    if (!_chartView) {
        
        _chartView = [[PieChartView alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, kScreenHeight * 2.2 / 5.0)];
        _chartView.delegate = self;
        _chartView.backgroundColor = COLOR(232, 232, 232, 1.0);
        
        _chartView.usePercentValuesEnabled = YES;
        _chartView.holeTransparent = YES;
        _chartView.holeRadiusPercent = 0.30;
        _chartView.transparentCircleRadiusPercent = 0.42;
        _chartView.descriptionText = @"";
        [_chartView setExtraOffsetsWithLeft:5.f top:10.f right:5.f bottom:10.f];
        
        _chartView.drawCenterTextEnabled = YES;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总资产\n%@",[NSString stringWithFormat:@"%.2f",(self.allAsset ? [self.allAsset floatValue] :0.00)/100.00]]];
        [centerText setAttributes:@{
                                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f],
                                    NSParagraphStyleAttributeName: paragraphStyle
                                    } range:NSMakeRange(0, centerText.length)];
        _chartView.centerAttributedText = centerText;
        
        _chartView.drawHoleEnabled = YES;
        _chartView.rotationAngle = 0.0;
        _chartView.rotationEnabled = YES;
        _chartView.highlightPerTapEnabled = YES;
        
        ChartLegend *l = _chartView.legend;
        l.position = ChartLegendPositionRightOfChart;
        l.xEntrySpace = 7.0;
        l.yEntrySpace = 0.0;
        l.yOffset = 0.0;
        
        [_chartView animateWithXAxisDuration:1.4 yAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
        
    }
    return _chartView;
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = COLOR(232, 232, 232, 1.0);
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.scrollEnabled = NO;
    }
    return _contentTableView;
}

- (FinancialProjectListAPICmd *)financialProjectListAPICmd {
    if (!_financialProjectListAPICmd) {
        _financialProjectListAPICmd = [[FinancialProjectListAPICmd alloc] init];
        _financialProjectListAPICmd.delegate = self;
        _financialProjectListAPICmd.path = API_AssetDetail;
    }
    _financialProjectListAPICmd.reformParams = @{@"id":[Tool getUserInfo][@"id"]};
    return _financialProjectListAPICmd;
}


- (UIView *)tipView {
    
    _tipView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, kScreenWidth, kScreenHeight - self.chartView.frame.size.height)];
    
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
    appcionLable.textColor=[UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, appcionLable.frame.origin.y + appcionLable.frame.size.height - 0.5, kScreenWidth, 0.5)];
    imageView.backgroundColor = COLOR(221, 221, 221, 1.0f);
    [_tipView addSubview:imageView];
    
    [_tipView addSubview:appcionLable];
    [self cretedowntextWithView:_tipView];
    return _tipView;
}


@end
