//
//  FactoryManager.h
//  TXHConductFinancialTransactions
//
//  Created by wwt on 15/11/3.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

typedef NS_ENUM(NSInteger, Fontsize)
{
    TH1Font = 0, //一号字体
    TH2Font = 1, //二号字体
    TH3Font = 2, //三号字体
    TH4Font = 4, //四号字体
    TH5Font = 5, //五号字体
};

#import <Foundation/Foundation.h>

//工厂类
@interface FactoryManager : NSObject


+ (instancetype)shareManager;

/**
 * 获取统一字体
 */
- (UIFont *)appFont:(Fontsize)size;

//需要其他属性对应扩展
- (UIButton *)createBtnWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor;

- (UIView *)createCellViewWithFrame:(CGRect)frame imageName:(NSString *)imageName placeHolder:(NSString *)placeHoder imageTag:(NSInteger)imageTag textFiledTag:(NSInteger)textFiledTag cellHeight:(NSInteger)cellHeight target:(id)target isNeedImage:(BOOL)isNeedImage;

@end
