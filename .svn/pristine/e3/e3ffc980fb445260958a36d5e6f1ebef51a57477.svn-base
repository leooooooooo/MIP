//
//  MainViewController.h
//  GACloud
//
//  Created by kangqijun on 14-3-6.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "KNavigationController.h"
#import "KTabBarController.h"
#import "TabBaseViewController.h"
#import "FunctionListViewController.h"
#import "SignInViewController.h"
#import "MyAppViewController.h"
#import "MsgCenterViewController.h"

@protocol MainViewDelegate <NSObject>

- (void)logOutSuccess;

@end

@interface MainViewController : BaseViewController <KTabBarControllerDelegate,UINavigationControllerDelegate,TabBaseViewControllerDelegate>
{
    KTabBarController *tabBarController;
    
    //功能列表控制器
    KNavigationController *functionNavController;
    //签到控制器
    KNavigationController *signInNavController;
    //我的应用控制器
    KNavigationController *myAppNavController;
    //消息中心控制器
    KNavigationController *newMsgNavController;
    
    id<MainViewDelegate> mainDelegate;
    
    int                   curTag;
}

@property (assign, nonatomic) id<MainViewDelegate> mainDelegate;
@property (assign, nonatomic) int                   curTag;

@end
