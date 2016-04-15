//
//  MYHttpRequest.m
//  MyFramework
//
//  Created by 满孝意 on 15/10/21.
//  Copyright © 2015年 满孝意. All rights reserved.
//

#import "MYHttpRequest.h"
#import "AFNetworking.h"
#import "MYMacroDefinition.h"
#import "MYAppInformation.h"
#import "MYGlobalMethod.h"

#define KTimeoutInterval 5

@implementation MYHttpRequest

#pragma mark -
#pragma mark - 发送一GET请求
+ (void)requestGETWith:(NSString *)firstParam and:(NSString *)secondParam dict:(NSDictionary *)infoDict requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure {
    // 判断网络连接状态
    [MYHttpRequest checkNetworkConnectionState];
    
    NSString *urlStr = [MYHttpRequest requestGETPath:firstParam andSection:secondParam andParams:infoDict];
    LogRed(@"urlStr.............\n%@\n%@\n\n", urlStr, [self dictionaryToJson:infoDict]);
    
    AFHTTPSessionManager *httpManager  = [AFHTTPSessionManager manager];
    httpManager.requestSerializer.timeoutInterval = KTimeoutInterval;
    [httpManager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestSuccess) {
            
            LogBlue(@"responseObject.............\n%@\n\n",  [self dictionaryToJson:responseObject]);
            requestSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFailure) {
            requestFailure(error);
        }
    }];
}

+ (NSString *)requestGETPath:(NSString *)path andSection:(NSString *)section andParams:(NSDictionary*)dictionary {
    NSString *infoString;
    if (dictionary) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        infoString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        infoString = [infoString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    } else {
        infoString = @"";
    }
    
    NSString *userId = ValueFUD(user_login_userid);
    NSString *tokenStr = ValueFUD(user_login_token);
    if (!ValueBoolFUD(user_login_bool)) {
        userId = @"";
        tokenStr = @"";
    }
    NSString *passStr = [NSString stringWithFormat:@"?v=1&userid=%@&token=%@", userId, tokenStr];
    // http://ip:port/corp/corpinfo?v=1&corpid=1&token=1
    NSMutableString *urlStr = [[NSMutableString alloc] initWithFormat:@"%@/%@/%@%@&data=%@", SERVERSIP, path, section, passStr, infoString];
    return urlStr;
}

#pragma mark -
#pragma mark - 发送一POST请求
+ (void)requestPOSTWith:(NSString *)firstParam and:(NSString *)secondParam dict:(NSDictionary *)infoDict requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure {
    // 判断网络连接状态
    [MYHttpRequest checkNetworkConnectionState];
    
    NSString *urlStr = [MYHttpRequest requestPOSTPath:firstParam andSection:secondParam];
    LogRed(@"urlStr.............\n%@\n%@\n\n", urlStr, [self dictionaryToJson:infoDict]);
    
    NSString *jsonStr = nil;
    NSError *error;
    NSData *jsonData = [NSData data];
    if (infoDict) {
        jsonData = [NSJSONSerialization dataWithJSONObject:infoDict options:NSJSONWritingPrettyPrinted error:&error];
    }
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setValue:jsonStr forKey:@"data"];
    
    AFHTTPSessionManager *httpManager  = [AFHTTPSessionManager manager];
    httpManager.requestSerializer.timeoutInterval = KTimeoutInterval;
    [httpManager POST:urlStr parameters:jsonDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestSuccess) {
            
            LogBlue(@"responseObject.............\n%@\n\n",  [self dictionaryToJson:responseObject]);
            requestSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFailure) {
            requestFailure(error);
        }
    }];
}

+ (NSString *)requestPOSTPath:(NSString *)path andSection:(NSString *)section {
    NSString *userId = ValueFUD(user_login_userid);
    NSString *tokenStr = ValueFUD(user_login_token);
    if (!ValueBoolFUD(user_login_bool)) {
        userId = @"";
        tokenStr = @"";
    }
    NSString *passStr = [NSString stringWithFormat:@"?v=1&sourcetype=1&corpid=%@&token=%@&source=%@", ValueFUD(user_login_userid), ValueFUD(user_login_token), @"ios"];
    // http://ip:port/corp/corpinfo?v=1&corpid=1&token=1
    NSMutableString *urlStr = [[NSMutableString alloc] initWithFormat:@"%@/v204/%@/%@%@", SERVERSIP, path, section, passStr];
    return urlStr;
}

#pragma mark -
#pragma mark - 下载文件
+ (void)downloadFileWithWithFuncName:(NSString *)firstParam function:(NSString *)secondParam jobid:(NSString *)jobid success:(RequestSuccess)success failure:(RequestFailure)failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@/%@?v=1&sourcetype=1&corpid=%@&token=%@&jobid=%@&source=%@", SERVERSIP, @"v204", firstParam, secondParam, ValueFUD(user_login_userid), ValueFUD(user_login_token), jobid, @"ios"];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    NSLog(@"-------------------------------------------------------------------------->\n\nurlStr ---------------------------------------------- %@\n\n<--------------------------------------------------------------------------", urlStr);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    NSURLSession *backgroundSession = [[NSURLSession alloc] init];
    NSURLSessionDownloadTask *backgroundTask = [backgroundSession downloadTaskWithRequest:request];
    [backgroundTask resume];
    //    AFHTTPRequestOperation *afOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //    afOperation.inputStream = [NSInputStream inputStreamWithURL:[NSURL URLWithString:urlStr]];
    //
    //    // 已完成下载
    //    [afOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        success(responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        failure(error);
    //    }];
    //    [afOperation start];
}

#pragma mark -
#pragma mark - 网络连接状态
static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";
+ (void)checkNetworkConnectionState {
    AFHTTPSessionManager *sharedClient = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
    sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    [sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //NSLog(@"----------------------\nAFNetworkReachabilityStatusReachableViaWWAN\n----------------------");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //NSLog(@"----------------------\nAFNetworkReachabilityStatusReachableViaWiFi\n----------------------");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //NSLog(@"----------------------\nAFNetworkReachabilityStatusNotReachable\n----------------------");
                [MYGlobalMethod alertView:@"连接网络失败，请检查网络信息"];
                break;
            default:
                break;
        }
    }];
    [sharedClient.reachabilityManager startMonitoring];
}

#pragma mark -
#pragma mark - 字典转成JSon
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    if (dic) {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return @"";
}

@end
