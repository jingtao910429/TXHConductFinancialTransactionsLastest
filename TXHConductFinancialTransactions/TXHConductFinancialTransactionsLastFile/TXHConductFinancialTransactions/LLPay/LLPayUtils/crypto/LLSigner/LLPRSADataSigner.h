//
//  RSADataSigner.h
//  SafepayService
//
//  Created by wenbi on 11-4-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLPDataSigner.h"

@interface LLPRSADataSigner : NSObject <LLPDataSigner> {
	NSString * _privateKey;
}

- (id)initWithPrivateKey:(NSString *)privateKey;

@end
