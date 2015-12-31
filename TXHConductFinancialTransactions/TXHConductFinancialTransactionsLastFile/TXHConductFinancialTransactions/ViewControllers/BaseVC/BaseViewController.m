//
//  BaseViewController.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/3.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //将navigationBar上的Image置回
    UINavigationController *nav = [[UINavigationController alloc] init];
    self.navigationController.navigationBar.shadowImage = nav.navigationBar.shadowImage;
    
    //设置NavigationBar title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background_tall1"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    
    self.view.backgroundColor = COLOR(232, 232, 232, 1.0);
    
    //适配iOS7uinavigationbar遮挡tableView的问题
    if(IOS_IS_AT_LEAST_7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
