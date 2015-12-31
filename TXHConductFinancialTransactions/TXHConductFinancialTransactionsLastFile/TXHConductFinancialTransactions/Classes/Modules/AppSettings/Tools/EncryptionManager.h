//
//  EncryptionManager.h
//  EncodeDeCode
//
//  Created by wwt on 15/11/5.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionManager : NSObject

+ (instancetype)shareManager;

//加密
- (NSString *)encodeWithData:(id)data version:(int)version;
//解密
- (id)decodeWithStr:(NSString *)dataStr version:(int)version;

@end
