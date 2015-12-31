//
//  RYPhoneNumberViewController.m
//  ForgetPasswordDemo
//
//  Created by gqq on 15/8/17.
//  Copyright (c) 2015年 __RongYu100__. All rights reserved.
//

#import "RYSmsManager.h"
@implementation RYSmsManager
+(instancetype)defaultManager
{
    static RYSmsManager *s_RYSmsManager = nil;
    @synchronized(self){
    if (s_RYSmsManager == nil) {
        s_RYSmsManager = [[RYSmsManager alloc]init];
    }
}
 return s_RYSmsManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.infoDictionary = [[NSMutableDictionary alloc]init];
        self.second = 0;
         self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return self;
}
-(void)timerAction
{
    self.second ++ ;
}
@end
