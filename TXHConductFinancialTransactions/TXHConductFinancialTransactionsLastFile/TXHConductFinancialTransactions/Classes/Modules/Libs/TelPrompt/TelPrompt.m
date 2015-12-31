//
//  TelPrompt.m
//  RongYu100
//
//  Created by zzj on 14/12/19.
//  Copyright (c) 2014年 ___RongYu100___. All rights reserved.
//

#import "TelPrompt.h"

#define kCallSetupTime  3.0

@interface TelPrompt ()
@property (nonatomic, strong) NSDate *callStartTime;

@property (nonatomic,copy) TelCallBlock callBlock;
@property (nonatomic,copy) TelCancelBlock cancelBlock;
@end

@implementation TelPrompt

+ (instancetype)sharedInstance
{
    static TelPrompt *_instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (BOOL)callPhoneNumber:(NSString *)phoneNumber call:(TelCallBlock)callBlock cancel:(TelCancelBlock)cancelBlock
{
    if ([self validPhone:phoneNumber]) {
        
        TelPrompt *telPrompt = [TelPrompt sharedInstance];
        
        // observe the app notifications
        [telPrompt setNotifications];
        
        // set the blocks
        telPrompt.callBlock = callBlock;
        telPrompt.cancelBlock = cancelBlock;
        
        // clean the phone number
        NSString *simplePhoneNumber =
        [[phoneNumber componentsSeparatedByCharactersInSet:
          [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        
        // call the phone number using the telprompt scheme
        NSString *stringURL = [@"telprompt://" stringByAppendingString:simplePhoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringURL]];
        
        return YES;
    }
    return NO;
}

+ (BOOL)validPhone:(NSString*) phoneString
{
    NSTextCheckingType type = [[NSTextCheckingResult phoneNumberCheckingResultWithRange:NSMakeRange(0, phoneString.length)
                                                                            phoneNumber:phoneString] resultType];
    return type == NSTextCheckingTypePhoneNumber;
}

#pragma mark - Notifications

- (void)setNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
}

#pragma mark - Events

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    // save the time of the call
    self.callStartTime = [NSDate date];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    // now it's time to remove the observers
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.callStartTime != nil) {
        
        // I'm coming back after a call
        if (self.callBlock != nil) {
            self.callBlock(-([self.callStartTime timeIntervalSinceNow]) - kCallSetupTime);
        }
        
        // reset the start timer
        self.callStartTime = nil;
        
    } else if (self.cancelBlock != nil) {
        
        // user didn't start the call
        self.cancelBlock();
    }
}


@end
