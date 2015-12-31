//
//  RYAPILogger.h
//  FinaCustomer
//
//  Created by xiaerfei on 15/7/23.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYAPILogger : NSObject
/**
 *   @author xiaerfei, 15-10-12 14:10:13
 *
 *   网络请求返回success log
 *
 *   @param url               请求的URL
 *   @param requestHeader     请求的header
 *   @param responseHeader    响应的header
 *   @param requestParams     请求的参数
 *   @param responseParams    响应的数据
 *   @param httpMethod        请求方式
 *   @param requestId         请求的Id
 *   @param apiCmdDescription API描述
 *   @param apiName           API名称
 */
+ (void)logDebugInfoWithURL:(NSString *)url
              requestHeader:(id)requestHeader
             responseHeader:(id)responseHeader
              requestParams:(id)requestParams
             responseParams:(id)responseParams
                 httpMethod:(NSString *)httpMethod
                  requestId:(NSNumber *)requestId
          apiCmdDescription:(NSString *)apiCmdDescription
                    apiName:(NSString *)apiName;
/**
 *   @author xiaerfei, 15-10-12 14:10:15
 *
 *   网络请求返回failed log
 *
 *   @param url               请求的URL
 *   @param requestHeader     请求的header
 *   @param responseHeader    响应的header
 *   @param requestParams     请求的参数
 *   @param httpMethod        请求方式
 *   @param error             error
 *   @param requestId         请求的Id
 *   @param apiCmdDescription API描述
 *   @param apiName           API名称
 */
+ (void)logDebugInfoWithURL:(NSString *)url
              requestHeader:(id)requestHeader
             responseHeader:(id)responseHeader
              requestParams:(id)requestParams
                 httpMethod:(NSString *)httpMethod
                      error:(NSError *)error
                  requestId:(NSNumber *)requestId
          apiCmdDescription:(NSString *)apiCmdDescription
                    apiName:(NSString *)apiName;


@end
