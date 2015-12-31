//
//  RYAPILogger.m
//  FinaCustomer
//
//  Created by xiaerfei on 15/7/23.
//  Copyright (c) 2015年 rongyu. All rights reserved.
//

#import "RYAPILogger.h"

@implementation RYAPILogger
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
                    apiName:(NSString *)apiName
{
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    
    [logString appendFormat:@"URL:\t\t\t%@\n",[url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [logString appendFormat:@"Method:\t\t%@\n", httpMethod];
    [logString appendFormat:@"requestId:\t\t%@\n",requestId];
    [logString appendFormat:@"apiName:\t\t%@\n",apiName];
    [logString appendFormat:@"description:\t%@\n",apiCmdDescription];
    [logString appendFormat:@"\n---------------------------Request---------------------------\n"];
    [logString appendFormat:@"Header:\n%@\n\n",requestHeader];
    [logString appendFormat:@"request  Params:\n%@\n",requestParams];
    [logString appendFormat:@"\n---------------------------Response---------------------------\n"];
    [logString appendFormat:@"Header:\n%@\n\n",responseHeader];
    [logString appendFormat:@"response Params:\n%@", responseParams];
    
    [logString appendFormat:@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n"];
    NSLog(@"%@", logString);

}
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
                    apiName:(NSString *)apiName
{
    if (!error.userInfo[@"com.alamofire.serialization.response.error.data"]) {
        return;
    }
    id errorData = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    
    [logString appendFormat:@"URL:\t\t\t%@\n",url];
    [logString appendFormat:@"Method:\t\t%@\n", httpMethod];
    [logString appendFormat:@"requestId:\t\t%@\n",requestId];
    [logString appendFormat:@"apiName:\t\t%@\n",apiName];
    [logString appendFormat:@"description:\t%@\n",apiCmdDescription];
    [logString appendFormat:@"\n---------------------------Request---------------------------\n"];
    [logString appendFormat:@"Header:\n%@\n\n",requestHeader];
    [logString appendFormat:@"requestParams:\t%@\n",requestParams];
    [logString appendFormat:@"\n---------------------------Response---------------------------\n"];
    [logString appendFormat:@"Header:\n%@\n\n",responseHeader];
    [logString appendFormat:@"Error Domain:\t\t\t\t\t%@\n", error.domain];
    [logString appendFormat:@"Error Domain Code:\t\t\t\t%ld\n", (long)error.code];
    [logString appendFormat:@"Error Localized Description:\t\t%@\n", error.localizedDescription];
    [logString appendFormat:@"Error Localized Failure Reason:\t\t%@\n", error.localizedFailureReason];
    [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n", error.localizedRecoverySuggestion];
    [logString appendFormat:@"NSErrorFailingURLKey:\t%@\n", error.userInfo[@"NSErrorFailingURLKey"]];
    [logString appendFormat:@"Error Data:\n%@", errorData];
    [logString appendFormat:@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n"];
    NSLog(@"%@", logString);
}


@end
