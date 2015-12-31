//
//  RYPhoneNumberViewController.m
//  ForgetPasswordDemo
//
//  Created by gqq on 15/8/17.
//  Copyright (c) 2015年 __RongYu100__. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface RYSmsManager : NSObject
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,assign)NSInteger second;
@property(nonatomic,strong)NSMutableDictionary *infoDictionary;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSString *robotStateId;

+ (instancetype)defaultManager;
@end
