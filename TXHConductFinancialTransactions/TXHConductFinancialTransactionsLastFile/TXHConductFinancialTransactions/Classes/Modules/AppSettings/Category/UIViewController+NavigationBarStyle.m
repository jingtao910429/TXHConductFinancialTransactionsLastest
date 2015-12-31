//
//  UIViewController+NavigationBarStyle.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/3.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "UIViewController+NavigationBarStyle.h"
#import "FactoryManager.h"

@implementation UIViewController (NavigationBarStyle)

- (void)navigationBarStyleWithTitle:(NSString *)titleStr titleColor:(UIColor *)titleColor leftTitle:(NSString *)leftTitle leftImageName:(NSString *)leftImageName leftAction:(SEL)leftAction rightTitle:(NSString *)rightTitle rightImageName:(NSString *)rightImageName rightAction:(SEL)rightAction{
    
    //设置标题
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100 ,100)];
    titleLabel.text = titleStr;
    titleLabel.textColor = titleColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:FontName size:18];
    self.navigationItem.titleView = titleLabel;
    
    //设置左右button
    
    if (leftTitle && !leftImageName) {
        
        UIButton *leftBtn = [[FactoryManager shareManager] createBtnWithFrame:CGRectMake(0, 0, 50, 30) text:leftTitle textColor:[UIColor orangeColor]];
        [leftBtn addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
        
        //如果左是纯文本
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
    }else if (!leftTitle && leftImageName){
        
        UIButton *leftBtn = [[FactoryManager shareManager] createBtnWithFrame:CGRectMake(-8, 0, 30, 25) text:nil textColor:nil];
        [leftBtn setImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
        leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [leftBtn addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
        
        //如果左是纯图片
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
    }else if (leftTitle && leftImageName){
        
        UIButton *leftBtn = [[FactoryManager shareManager] createBtnWithFrame:CGRectMake(-8, 0, 60, 20) text:nil textColor:nil];
        [leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [leftBtn setTitleColor:COLOR(239, 71, 26, 1.0f) forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
        leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
        [leftBtn addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
    }
    
    if (rightTitle && !rightImageName) {
        
        UIButton *rightBtn = [[FactoryManager shareManager] createBtnWithFrame:CGRectMake(0, 0, 40, 30) text:rightTitle textColor:[UIColor orangeColor]];
        [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        
    }else if (!rightTitle && rightImageName) {
        
        UIButton *rightBtn = [[FactoryManager shareManager] createBtnWithFrame:CGRectMake(-8, 0, 30, 25) text:nil textColor:nil];
        [rightBtn setImage:[UIImage imageNamed:rightImageName] forState:UIControlStateNormal];
        rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        
    }
    
}

- (void)clearNavigationBar {
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    //navigationController与navigationBar之间的横线置空
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

@end
