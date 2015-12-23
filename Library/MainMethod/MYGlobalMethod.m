//
//  MYGlobalMethod.m
//  MyFramework
//
//  Created by 满孝意 on 15/12/21.
//  Copyright © 2015年 满孝意. All rights reserved.
//

#import "MYGlobalMethod.h"
#import <MBProgressHUD.h>
#import "MYMacroDefinition.h"
#import "MYAppInformation.h"
#import "MYAlertAction.h"

@implementation MYGlobalMethod

/**
 *  色值处理
 */
+ (UIColor *)colorWithHexString:(NSString *)colorStr alpha:(CGFloat)alpha {
    // 删除字符串中的空格
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    // 如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    // 如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.length = 2;
    // r
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    // g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    // b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

/**
 *  本地路径拼接
 */
+ (NSString *)filePath:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentLibraryFolderPath = [documentsDirectory stringByAppendingPathComponent:filename];
    return documentLibraryFolderPath;
}

+ (void)storeArray:(NSArray *)fileData filename:(NSString *)filename {
    if ([fileData writeToFile:[self filePath:filename] atomically:YES]) {
        NSLog(@"write sucess");
    } else {
        NSLog(@"write fail");
    }
}

+ (NSArray *)getUseArray:(NSString *)filename {
    if ([self filePath:filename]) {
        return [NSArray arrayWithContentsOfFile:[self filePath:filename]];
    }
    return nil;
}

+ (BOOL)arrayExistWith:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:fileName];
}

+ (BOOL)fileExitWith:(NSString *)filename {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:[self filePath:filename]];
}

/**
 *  传入color、frame、radius返回一个UIImage对象
 */
+ (UIImage *)createImageWithColor:(UIColor *)color andRect:(CGRect)rect andCornerRadius:(float)radius {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

/**
 *  显示提示信息后添加动作
 */
+ (void)showText:(NSString *)text view:(UIView *)view completionBlock:(void (^)())completion {
    [MBProgressHUD hideHUDForView:view animated:YES];
    MBProgressHUD *showHud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:showHud];
    showHud.labelText = text;
    showHud.mode = MBProgressHUDModeText;
    [showHud showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [showHud removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}

/**
 *  将时间戳转换成日期 格式：1990-03-10
 */
+ (NSString *)convertTimestampToDate:(NSString *)timeStr {
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[timeStr floatValue]  / 1000];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *regStr = [df stringFromDate:dt];
    return regStr;
}

/**
 *  时间转换时间戳
 */
+ (NSString *)convertDateToTimestamp:(NSString *)timestamp {
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-mm-DD"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:timestamp];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSinceNow]];
    return timeSp;
}

/**
 *  NSNumber转换NSString
 */
+ (NSString *)numberWithString:(NSNumber *)number {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *str = [numberFormatter stringFromNumber:number];
    return str;
}

/**
 *  判断输入内容是否为空
 */
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/**
 *  UIAlertView简单方法
 */
+ (void)alertView:(NSString *)message {
    [MYAlertAction showAlertWithTitle:@"温馨提示" msg:message chooseBlock:^(NSInteger buttonIdx) {
        
    } buttonsStatement:@"确定", nil];
}

/**
 *  登录存储所有数据
 */
+ (void)userLogOnWithDict:(NSDictionary *)dict {
    SaveValueBoolTUD(user_login_bool, YES);
    SaveValueTUD(user_login_userid, dict[@"corpid"]);
    SaveValueTUD(user_login_token, dict[@"token"]);
}

/**
 *  退出登录清空数据
 */
+ (void)userLogOff {
    SaveValueBoolTUD(user_login_bool, NO);
    SaveValueTUD(user_login_userid, @"");
    SaveValueTUD(user_login_token, @"");
}

@end
