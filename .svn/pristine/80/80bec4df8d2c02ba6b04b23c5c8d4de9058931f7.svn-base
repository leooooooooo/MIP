//
//  PublicDefine.h
//  MIP
//
//  Created by Sea on 13-9-9.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#ifndef MIP_PublicDefine_h
#define MIP_PublicDefine_h


#ifdef DEBUG
#   define DLog(format, ...) NSLog((@"%s [Line %d]:\n %s = " format), __PRETTY_FUNCTION__, __LINE__, #__VA_ARGS__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//the status bar of the window after removing highly when equipment vertical screen
#define SCREEN_HEIGHT                   [[UIScreen mainScreen] bounds].size.height
//width of window when equipment vertical screen
#define SCREEN_WIDTH                    [[UIScreen mainScreen] bounds].size.width
//heigth of navigation bar
#define NAVIGATION_BAR_HEIGHT           (44)

//判断当前对象是否有效
#define isValid(object)     (object && ![object isEqual:[NSNull null]])

//常用头文件,基本每一个类中都需要使用
#import "Userinfo.h"
#import "Module.h"

#import "MIPNetUniformInterface.h"

#import "DataManager.h"

#import "UIButton+CustomExtensions.h"
#import "UIImage+CustomExtensions.h"
#import "UIView+CustomExtensions.h"

#import "UIColor+CustomExtensions.h"

#import "CustomAlertView.h"
#import "CustomNewAlertView.h"

#import "PublicManager.h"


//以下变量定义为全局变量而非使用宏定义,这样可以在程序中可修改其值,从而可以达到换肤的目的
FOUNDATION_EXPORT      NSString             *const publicResourceBundle;//公共图片资源文件,如常用的背景图,按钮（增加,刷新,删除...）
FOUNDATION_EXPORT      NSString             *const mainBundle;
FOUNDATION_EXPORT      NSString             *const loginBundle;
FOUNDATION_EXPORT      NSString             *const docTransBundle;
FOUNDATION_EXPORT      NSString             *const scheduleBundle;
FOUNDATION_EXPORT      NSString             *const leaderScheduleBundle;
FOUNDATION_EXPORT      NSString             *const leaderInstructionsBundle;
FOUNDATION_EXPORT      NSString             *const settingBundle;
FOUNDATION_EXPORT      NSString             *const messageBundle;
FOUNDATION_EXPORT      NSString             *const documentLibraryBundle;
FOUNDATION_EXPORT      NSString             *const headImageBundle;
FOUNDATION_EXPORT      NSString             *const myPlatformBoudle;
FOUNDATION_EXPORT      NSString             *const newsCenterBundle;
FOUNDATION_EXPORT      NSString             *const contactsBundle;
FOUNDATION_EXPORT      NSString             *const myAppCenterBundle;
FOUNDATION_EXPORT      NSString             *const newsflashBundle;
FOUNDATION_EXPORT      NSString             *const lcHarbourBundle;
FOUNDATION_EXPORT      NSString             *const operDeviceBundle;
FOUNDATION_EXPORT      NSString             *const commonlyUsedToolBundle;
FOUNDATION_EXPORT      NSString             *const officialCheckBundle;
FOUNDATION_EXPORT      NSString             *const businessProcessBundle;

//网络请求固定key
#define     kBizCode                                    @"bizCode"
#define     kBizType                                    @"bizType"
#define     kMethodName                                 @"methodName"
#define     kBizData                                    @"bizdata"


extern      NSString                                    *pageSize;//翻页获取数据时的每页数量




//默认属性文件(NSUserDefaults)的自定义Key
FOUNDATION_EXPORT      NSString             *const kLastVersion;
FOUNDATION_EXPORT      NSString             *const kLastVersionURL;
FOUNDATION_EXPORT      NSString             *const kVersionUpdateLog;


#define HEADIMAGEPATH               @"headImagePath"
#define LASTLOGINUSERNAMEKEY       @"lastLoginUserName"

#define DOCTRANSCOTEGORYUNREADNOTIFICATION  @"docTransCategoryUnreadNotification"
#define MODULEUNREADNOTIFICATION  @"moduleUnreadNotification"
#define DOCUMENTUNREADNOTIFICATION  @"documnetUnreadNotification"
#define MESSAGEUNREADNOTIFICATION  @"messageUnreadNotification"
#define NETMORTTVUNREADNOTIFICATION  @"networkTVUnreadNotification"
#define NEWSCENTERUNREADNOTIFICATION @"newsCenterUnreadNotification"

//在线离线标示
BOOL isOnline;
//苹果推送设备token
NSString *devToken;


#endif
