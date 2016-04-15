//
//  MYAppInformation.h
//  MyFramework
//
//  Created by 满孝意 on 15/12/21.
//  Copyright © 2015年 满孝意. All rights reserved.
//

#ifndef MYAppInformation_h
#define MYAppInformation_h

/** ---- MianParameter ---- */
#define launch_not_first           @"Launch_Not_First" // 首次登陆
#define user_login_bool           @"User_Login_Bool"  // 是否登陆
#define user_login_userid         @"User_Login_ID"    // 登录ID
#define user_login_token          @"User_Login_Token" // 登录token

#define Image_Default [UIImage imageNamed:@"corpDefault.png"]


/** ---- color ---- */
#define Color_ViewBG_F4F4F4 @"f4f4f4"


//  XcodeColor
#define XCODE_COLORS_ESCAPE  @"\033["
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"
#define LogRed(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogBlue(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)


/** ---- UmengParameter ---- */
#define Share_Umeng_Key   @"556ea8a867e58e51ae002cb2"
#define Share_QQ_AppId    @"1104645119"
#define Share_QQ_Secret   @"2Iuj5H0M9fpYBNjK"
#define Share_WX_AppId    @"wx9dda0842a89dcbb8"
#define Share_WX_Secret   @"0417ea8312d25f76249cbfbf7e75e8a2"
#define Share_Sina_AppId  @"2798189764"
#define Share_Sina_Secret @"7598e2c92d522d4b1654c7d500ed5f4a"


/** ---- Developer OR Distribution ---- */
#define APP_Developer_Define  // 测试环境 -- 注释切换到正式环境
#ifndef APP_Developer_Define
// 正式环境
#define SERVERSIP  @"http://bapp.tanlu.cc"
#define ALBB_OSS_Bucket @"tanlu"
#define ALBB_OSS_Route @"images"
#define Push_alisa_Head @"prod_appuser_alias_"

#else
// 测试环境
#define SERVERSIP  @"http://testbapp.tanlu.cc"
#define ALBB_OSS_Bucket @"tanlutest"
#define ALBB_OSS_Route @"image"
#define Push_alisa_Head @"dev_appuser_alias_"
#endif

#endif /* MYAppInformation_h */
