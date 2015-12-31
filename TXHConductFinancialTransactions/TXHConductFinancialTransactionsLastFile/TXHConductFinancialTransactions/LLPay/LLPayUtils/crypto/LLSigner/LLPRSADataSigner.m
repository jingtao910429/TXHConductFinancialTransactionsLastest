//
//  RSADataSigner.m
//  SafepayService
//
//  Created by wenbi on 11-4-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LLPRSADataSigner.h"
//#import "openssl_wrapper.h"
//#import "NSDataEx.h"

#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/md5.h>
#include <openssl/bio.h>
#include <openssl/sha.h>
#include <string.h>

NSString *LLPBase64StringFromData(NSData *signature);
int md5rsa_sign_with_private_key_pem(char *message, int message_length
                                     , unsigned char *signature, unsigned int *signature_length
                                     , char *private_key_file_path);

@implementation LLPRSADataSigner

- (id)initWithPrivateKey:(NSString *)privateKey {
	if (self = [super init]) {
		_privateKey = [privateKey copy];
	}
	return self;
}

//- (void)dealloc {
//	[_privateKey release];
//	[super dealloc];
//}

//- (NSString *)urlEncodedString:(NSData *)src
//{
//	char *hex = "0123456789ABCDEF";
//	unsigned char * data = (unsigned char*)[src bytes];
//	int len = [src length];
//	NSMutableString* s = [NSMutableString string];
//	for(int i = 0;i<len;i++){
//		unsigned char c = data[i];
//		if( ('a' <= c && c <= 'z')
//		   || ('A' <= c && c <= 'Z')
//		   || ('0' <= c && c <= '9') ){
//			NSString* ts = [[NSString alloc] initWithCString:(char *)&c length:1];
//			
//			[s appendString:ts];
//			[ts release];
//		} else {
//			[s appendString:@"%"];
//			char ts1 = hex[c >> 4];
//			NSString* ts = [[NSString alloc] initWithCString:&ts1 length:1];
//			[s appendString:ts];
//			[ts release];
//			char ts2 = hex[c & 15];
//			ts = [[NSString alloc] initWithCString:&ts2 length:1];
//			[s appendString:ts];
//			[ts release];
//			
//		}
//	}
//	return s;
//}

- (NSString *)formatPrivateKey:(NSString *)privateKey {
    const char *pstr = [privateKey UTF8String];
    int len = [privateKey length];
    NSMutableString *result = [NSMutableString string];
    [result appendString:@"-----BEGIN PRIVATE KEY-----\n"];
    int index = 0;
	int count = 0;
    while (index < len) {
        char ch = pstr[index];
		if (ch == '\r' || ch == '\n') {
			++index;
			continue;
		}
        [result appendFormat:@"%c", ch];
        if (++count == 76)
        {
            [result appendString:@"\n"];
			count = 0;
        }
        index++;
    }
    [result appendString:@"\n-----END PRIVATE KEY-----"];
    return result;
}

- (NSString *)algorithmName {
	return @"RSA";
}

//该签名方法仅供参考,外部商户可用自己方法替换
- (NSString *)signString:(NSString *)string {
	
	//在Document文件夹下创建私钥文件
	NSString * signedString = nil;
	NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [documentPath stringByAppendingPathComponent:@"LLPay-RSAPrivateKey"];
	
	//
	// 把密钥写入文件
	//
	NSString *formatKey = [self formatPrivateKey:_privateKey];
	[formatKey writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
	
	const char *message = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int messageLength = strlen(message);
    unsigned char *sig = (unsigned char *)malloc(256);
	unsigned int sig_len;
    int ret = md5rsa_sign_with_private_key_pem((char *)message, messageLength, sig, &sig_len, (char *)[path UTF8String]);
	//签名成功,需要给签名字符串base64编码和UrlEncode,该两个方法也可以根据情况替换为自己函数
    if (ret == 1) {
        NSString * base64String = LLPBase64StringFromData([NSData dataWithBytes:sig length:sig_len]);
        signedString = base64String;
    }
	
	free(sig);
    return signedString;
}

@end


NSString *LLPBase64StringFromData(NSData *signature)
{
    int signatureLength = [signature length];
    unsigned char *outputBuffer = (unsigned char *)malloc(2 * 4 * (signatureLength / 3 + 1));
    int outputLength = EVP_EncodeBlock(outputBuffer, [signature bytes], signatureLength);
    outputBuffer[outputLength] = '\0';
    NSString *base64String = [NSString stringWithCString:(char *)outputBuffer encoding:NSASCIIStringEncoding];
    free(outputBuffer);
    return base64String;
}

int md5rsa_sign_with_private_key_pem(char *message, int message_length
                                     , unsigned char *signature, unsigned int *signature_length
                                     , char *private_key_file_path)
{
    
    unsigned char md5[16];
    
    MD5((unsigned char *)message, message_length, md5);
    
    int success = 0;
    BIO *bio_private = NULL;
    RSA *rsa_private = NULL;
    bio_private = BIO_new(BIO_s_file());
    BIO_read_filename(bio_private, private_key_file_path);
    rsa_private = PEM_read_bio_RSAPrivateKey(bio_private, NULL, NULL, "");    
    if (rsa_private != nil) {
        if (1 == RSA_check_key(rsa_private))
        {
            int rsa_sign_valid = RSA_sign(NID_md5
                                          , md5, 16
                                          , signature, signature_length
                                          , rsa_private);
            if (1 == rsa_sign_valid)
            {
                success = 1;
            }
        }
        BIO_free_all(bio_private);
    }
    else {
        NSLog(@"rsa_private read error : private key is NULL");
    }
    
    return success;
}
