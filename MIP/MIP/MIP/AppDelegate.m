//
//  AppDelegate.m
//  MIP
//
//  Created by Sea on 13-9-3.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "AppDelegate.h"

#import "RootViewController.h"

#import "NdUncaughtExceptionHandle.h"
#import "SystemInfo.h"

#import "DataManager.h"
#import "Userinfo.h"

#import "DeviceAuthNetRequest.h"

#import "KNavigationController.h"


NSString *const publicResourceBundle = @"PublicResource";
NSString *const mainBundle = @"Main";
NSString *const loginBundle = @"Login";
NSString *const settingBundle = @"Setting";
NSString *const myPlatformBoudle = @"MyPlatform";
NSString *const newsCenterBundle = @"NewsCenter";
NSString *const businessProcessBundle = @"BusinessProcess";
NSString *const myAppCenterBundle = @"MyAppCenter";
NSString *const contactsBundle = @"Contacts";
NSString *const newsflashBundle = @"Newsflash";
NSString *const lcHarbourBundle = @"lcHarbour";
NSString *const operDeviceBundle = @"OperDevice";
NSString *const commonlyUsedToolBundle = @"CommonlyUsedTool";
NSString *const officialCheckBundle = @"officalCheck";


NSString *const headImageBundle = @"DefaultHeadImage";
NSString *pageSize = @"20";

NSString *const kLastVersion = @"kLastVersion";
NSString *const kLastVersionURL = @"kLastVersionURL";
NSString *const kVersionUpdateLog = @"kVersionUpdateLog";


@implementation AppDelegate

- (void)dealloc
{
    [_window release];

    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NdUncaughtExceptionHandle setDefaultHandler];
    [SystemInfo shareSystemInfo];//初始化系统信息单例
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    
    LoginViewController *loginViewController = [[[LoginViewController alloc] init]autorelease];
    
    KNavigationController *nav = [[KNavigationController alloc] initWithRootViewController:loginViewController];
    
//    RootViewController *rootViewController = [[RootViewController alloc] init];
    
    [self.window setRootViewController:nav];
    
    [nav release];
    
#ifdef __IPHONE_7_0
    [application setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
#endif
    
    [self.window makeKeyAndVisible];
    
    /** 注册推送通知功能, */
    //[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //这里还是原来的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    //判断程序是不是由推送服务完成的
    /*
    if (launchOptions)
    {
        NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"推送通知"
                                                           message:@"这是通过推送窗口启动的程序，你可以在这里处理推送内容"
                                                          delegate:nil
                                                 cancelButtonTitle:@"知道了"
                                                 otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
     */
    
    return YES;
}

//获取DeviceToken成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"DeviceToken: {%@}",deviceToken);
    NSMutableString *device = [NSMutableString stringWithFormat:@"%@",deviceToken];
    NSString *postDeviceToken = [[[device stringByReplacingOccurrencesOfString:@"<"withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" "withString:@""];
    NSLog(@"DeviceToken: %@",postDeviceToken);
    
    devToken = postDeviceToken;
}

//注册消息推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"获取Token失败");
}

//处理收到的消息推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    application.applicationIconBadgeNumber = 0;
    
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"**推送消息**"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"关闭"
                                              otherButtonTitles:@"处理推送内容",nil];
        [alert show];
    }
    
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        
    }
    else
    {
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    DataManager *dataManager = [DataManager shareDataManager];
    
    [dataManager saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //发送请求，检测设备是否丢失
    [DeviceAuthNetRequest executeAsynchronous:@selector(checkDeviceLostState) callback:@selector(callBackcheckDeviceLostState:error:) backTarget:self args:nil];
}

- (void)callBackcheckDeviceLostState:(NSData *)data error:(NSError *)error
{
//    [(RootViewController *)self.window.rootViewController checkDeviceLostState:data];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    
    DataManager *dataManager = [DataManager shareDataManager];
    
    [dataManager saveContext];
}

@end
