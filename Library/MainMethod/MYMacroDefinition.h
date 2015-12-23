//
//  MYMacroDefinition.h
//  MyFramework
//
//  Created by 满孝意 on 15/12/21.
//  Copyright © 2015年 满孝意. All rights reserved.
//

#ifndef MYMacroDefinition_h
#define MYMacroDefinition_h

/** ---- app版本 ---- */
#define App_Version [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]
/** ---- build版本 ---- */
#define App_BuildVersion [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleVersion"]


/** ---- 屏幕高度 ---- */
#define SCREEN_HEIGHT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.height-20)
/** ---- 屏幕宽度 ---- */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width


/** ---- 否是IOS8及以上 ---- */
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
/** ---- 否是IOS7 ---- */
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] intValue] == 7 ? YES : NO)

/** ---- 是IPHONE4 ---- */
#define IS_IPHONE4 ([UIScreen mainScreen].bounds.size.height == 480 ? YES : NO)
/** ---- 是IPHONE5 ---- */
#define IS_IPHONE5 ([UIScreen mainScreen].bounds.size.height == 568 ? YES : NO)
/** ---- 是IPHONE6 ---- */
#define IS_IPHONE6 ([UIScreen mainScreen].bounds.size.height == 667 ? YES : NO)
/** ---- 是IPHONE6P ---- */
#define IS_IPHONE6P ([UIScreen mainScreen].bounds.size.height == 736 ? YES : NO)


/** ---- 存值 ---- */
#define SaveValueTUD(key, value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]
/** ---- 取值 ---- */
#define ValueFUD(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
/** ---- 存Bool值 ---- */
#define SaveValueBoolTUD(key, value) [[NSUserDefaults standardUserDefaults] setBool:value forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]
/** ---- 取Bool值 ---- */
#define ValueBoolFUD(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]


/** ---- 色值处理(透明度) ---- */
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


#endif /* MYMacroDefinition_h */
