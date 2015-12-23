//
//  MYHttpRequest.h
//  MyFramework
//
//  Created by 满孝意 on 15/10/21.
//  Copyright © 2015年 满孝意. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求成功后的回调
 *
 *  @param json 服务器返回的JSON数据
 */
typedef void (^RequestSuccess)(id json);

/**
 *  请求失败后的回调
 *
 *  @param error 错误信息
 */
typedef void (^RequestFailure)(NSError *error);

@interface MYHttpRequest : NSObject

/**
 *  发送一GET请求
 *
 *  @param firstParam     请求函数名
 *  @param secondParam    请求函数
 *  @param infoDict       请求参数
 *  @param requestSuccess 请求成功后的回调
 *  @param requestFailure 请求失败后的回调
 */
+ (void)requestGETWith:(NSString *)firstParam and:(NSString *)secondParam dict:(NSDictionary *)infoDict requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure;

/**
 *  发送一POST请求
 *
 *  @param firstParam     请求函数名
 *  @param secondParam    请求函数
 *  @param infoDict       请求参数
 *  @param requestSuccess 请求成功后的回调
 *  @param requestFailure 请求失败后的回调
 */
+ (void)requestPOSTWith:(NSString *)firstParam and:(NSString *)secondParam dict:(NSDictionary *)infoDict requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure;

/**
 *  下载文件
 *
 *  @param firstParam     请求函数名
 *  @param secondParam    请求函数
 *  @param jobid          工作id
 *  @param requestSuccess 请求成功后的回调
 *  @param requestFailure 请求失败后的回调
 */
+ (void)downloadFileWithWithFuncName:(NSString *)firstParam function:(NSString *)secondParam jobid:(NSString *)jobid success:(RequestSuccess)success failure:(RequestFailure)failure;

@end
