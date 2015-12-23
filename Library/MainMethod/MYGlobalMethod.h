//
//  MYGlobalMethod.h
//  MyFramework
//
//  Created by 满孝意 on 15/12/21.
//  Copyright © 2015年 满孝意. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MYGlobalMethod : NSObject

/** ---- 色值处理 ---- */
+ (UIColor *)colorWithHexString:(NSString *)colorStr alpha:(CGFloat)alpha;


/** ---- 文件读写 ---- */
+ (NSString *)filePath:(NSString *)filename;
+ (void)storeArray:(NSArray *)fileData filename:(NSString *)filename;
+ (NSArray *)getUseArray:(NSString *)filename;
+ (BOOL)arrayExistWith:(NSString *)fileName;
+ (BOOL)fileExitWith:(NSString *)filename;


/** ---- 传入color、frame、radius返回一个UIImage对象 ---- */
+ (UIImage *)createImageWithColor:(UIColor *)color andRect:(CGRect)rect andCornerRadius:(float)radius;


/** ---- 显示提示信息后添加动作 ---- */
+ (void)showText:(NSString *)text view:(UIView *)view completionBlock:(void (^)())completion;


/** ---- 将时间戳转换成日期 格式：1990-03-10 ---- */
+ (NSString *)convertTimestampToDate:(NSString *)timeStr;
/** ---- 时间转换时间戳 ---- */
+ (NSString *)convertDateToTimestamp:(NSString *)timestamp;


/** ---- NSNumber转换NSString ---- */
+ (NSString *)numberWithString:(NSNumber *)number;


/** ---- 判断输入内容是否为空 ---- */
+ (BOOL)isBlankString:(NSString *)string;


/** ---- UIAlertView简单方法 ---- */
+ (void)alertView:(NSString *)message;


/** ---- 登录存储所有数据 ---- */
+ (void)userLogOnWithDict:(NSDictionary *)dict;
/** ---- 退出登录清空数据 ---- */
+ (void)userLogOff;


@end
