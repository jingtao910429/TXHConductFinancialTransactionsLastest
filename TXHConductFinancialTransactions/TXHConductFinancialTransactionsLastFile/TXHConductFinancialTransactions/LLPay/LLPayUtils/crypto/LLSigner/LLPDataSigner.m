//
//  DataSigner.m
//  AlixPayDemo
//
//  Created by Jing Wen on 8/2/11.
//  Copyright 2011 alipay.com. All rights reserved.
//

#import "LLPDataSigner.h"
#import "LLPRSADataSigner.h"

id<LLPDataSigner> LLPCreateRSADataSigner(NSString *privateKey) {
	
	id signer = nil;
	signer = [[LLPRSADataSigner alloc] initWithPrivateKey:privateKey];
	return signer;
	
}