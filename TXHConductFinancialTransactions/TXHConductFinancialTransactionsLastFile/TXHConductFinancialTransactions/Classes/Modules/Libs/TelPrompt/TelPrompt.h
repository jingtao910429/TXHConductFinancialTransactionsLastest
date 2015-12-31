//
//  TelPrompt.h
//  RongYu100
//
//  Created by zzj on 14/12/19.
//  Copyright (c) 2014年 ___RongYu100___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TelPrompt : NSObject

typedef void (^TelCallBlock)(NSTimeInterval duration);
typedef void (^TelCancelBlock)(void);

+ (BOOL)callPhoneNumber:(NSString*)phoneNumber call:(TelCallBlock)callBlock cancel:(TelCancelBlock)cancelBlock;

@end
