//
//  DataSigner.h
//  AlixPayDemo
//
//  Created by Jing Wen on 8/2/11.
//  Copyright 2011 alipay.com. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum LLPDataSignAlgorithm {
	LLPDataSignAlgorithmRSA,
	LLPDataSignAlgorithmMD5,
} LLPDataSignAlgorithm;

@protocol LLPDataSigner

- (NSString *)algorithmName;
- (NSString *)signString:(NSString *)string;

@end

id<LLPDataSigner> LLPCreateRSADataSigner(NSString *privateKey);
