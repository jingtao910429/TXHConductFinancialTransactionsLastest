//
//  FactoryManager.m
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/3.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "FactoryManager.h"

static FactoryManager *shareManager = nil;

@implementation FactoryManager

+ (instancetype)shareManager {
    
    static dispatch_once_t onceInstance;
    dispatch_once(&onceInstance, ^{
        shareManager = [[FactoryManager alloc] init];
    });
    return shareManager;
}

- (UIFont *)appFont:(Fontsize)size;
{
    CGFloat fontsize;
    switch (size) {
        case TH1Font:
            fontsize = 16;
            break;
        case TH2Font:
            fontsize = 14;
            break;
        case TH3Font:
            fontsize = 13;
            break;
        case TH4Font:
            fontsize = 12;
            break;
        case TH5Font:
            fontsize = 10;
            break;
        default:
            fontsize = 9;
            break;
    }
    return [UIFont systemFontOfSize:fontsize];
}

- (UIButton *)createBtnWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor {
    
    UIButton *button                = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame                    = frame;
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    return button;
}

- (UIView *)createCellViewWithFrame:(CGRect)frame  imageName:(NSString *)imageName placeHolder:(NSString *)placeHoder imageTag:(NSInteger)imageTag textFiledTag:(NSInteger)textFiledTag cellHeight:(NSInteger)cellHeight target:(id)target isNeedImage:(BOOL)isNeedImage {
    
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *contentImageView = nil;
    UITextField *contentTextFiled = nil;
    
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    if (isNeedImage) {
        contentImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(10, (cellHeight - image.size.height)/2, image.size.width, image.size.height)];
        contentImageView.image = image;
        contentImageView.tag = imageTag;
        
        contentTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(contentImageView.frame.origin.x + contentImageView.frame.size.width + 8, 0, kScreenWidth - 50 - contentImageView.frame.size.width, cellHeight)];
    }else {
        contentTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth - 50 - contentImageView.frame.size.width, cellHeight)];
    }
    
    
    contentTextFiled.delegate = target;
    contentTextFiled.placeholder = placeHoder;
    contentTextFiled.tag = textFiledTag;
    
    if (isNeedImage) {
        [contentView addSubview:contentImageView];
    }
    
    [contentView addSubview:contentTextFiled];
    
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    
    return contentView;
    
}

@end
