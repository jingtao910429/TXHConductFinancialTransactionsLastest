//
//  EncryptionManager.m
//  EncodeDeCode
//
//  Created by wwt on 15/11/5.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "EncryptionManager.h"
#import "JSONKit.h"

static NSString * const KEY1    = @"1790365259";
static NSString * const KEY2    = @"1690782278";

@interface EncryptionManager ()

@property (nonatomic, copy) NSArray *KEYS;

@end

@implementation EncryptionManager

static EncryptionManager *shareManager = nil;

+ (instancetype)shareManager {
    
    static dispatch_once_t onceInstance;
    dispatch_once(&onceInstance, ^{
        shareManager = [[EncryptionManager alloc] init];
    });
    return shareManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.KEYS = @[@"",KEY1,KEY2];
    }
    return self;
}

- (NSString *)encodeWithData:(id)data version:(int)version{
    
    NSString *jsonStr = [self encodeString:[data JSONString]];

    return [self encodeString:jsonStr key:self.KEYS[version]];
}

- (id)decodeWithStr:(NSString *)dataStr version:(int)version {
    
    return [self decodeString:dataStr key:self.KEYS[version]];
}

- (NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

//URLDEcode
-(NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

/**
 * 加密
 *
 * @param str
 * @return
 */

- (NSString*)encodeString:(NSString*)data key:(NSString*)key{
    
    return [self analysisMethodData:data key:key];
}

/**
 * 解密
 *
 * @param str
 * @return
 */

- (id)decodeString:(NSString *)data key:(NSString *)key {
    
    return [[self decodeString:[self analysisMethodData:data key:key]] objectFromJSONString];
    
}

/**
 * 加解密方法
 *
 * @param str
 * @return
 */

- (NSString *)analysisMethodData:(NSString *)data key:(NSString *)key{
    
    NSString *result=[NSString string];
    
    for(int i=0; i < [data length]; i++){
        
        int chData=[data characterAtIndex:i];
        for(int j = 0;j < [key length];j++){
            int chKey = [key characterAtIndex:j];
            chData = chData^chKey;
        }
        result = [NSString stringWithFormat:@"%@%@",result,[NSString stringWithFormat:@"%c",chData]];
    }
    
    return result;
}


@end
