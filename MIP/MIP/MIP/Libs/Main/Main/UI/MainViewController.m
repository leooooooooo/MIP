//
//  MainViewController.m
//  GACloud
//
//  Created by kangqijun on 14-3-6.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize mainDelegate;

@synthesize curTag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
//    [functionNavController release];
//    [myAppNavController release];
//    [signInNavController release];
//    [newMsgNavController release];
    [tabBarController release];
    
    [super dealloc];
}

- (void)loadView
{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.view = tempView;
    [tempView release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    FunctionListViewController *functionController = [[FunctionListViewController alloc] init];
    functionController.tabBaseDelegate = self;
//    functionController.title = @"功能列表";
    functionController.title = [Userinfo shareUserinfo].name_zhCN;
//    functionNavController = [[KNavigationController alloc] initWithRootViewController:functionController];
//    functionNavController.delegate = self;
    
    SignInViewController *signInController = [[SignInViewController alloc] init];
    signInController.tabBaseDelegate = self;
//    signInController.title = @"签到";
    signInController.title = [Userinfo shareUserinfo].name_zhCN;
//    signInNavController = [[KNavigationController alloc] initWithRootViewController:signInController];
//    signInNavController.delegate = self;
    
    MyAppViewController *myAppController = [[MyAppViewController alloc] init];
    myAppController.tabBaseDelegate = self;
//    myAppController.title = @"我的应用";
    myAppController.title = [Userinfo shareUserinfo].name_zhCN;
//    myAppNavController = [[KNavigationController alloc] initWithRootViewController:myAppController];
//    myAppNavController.delegate = self;
    
    MsgCenterViewController *newMsgController = [[MsgCenterViewController alloc] init];
    newMsgController.tabBaseDelegate = self;
//    newMsgController.title = @"消息中心";
    newMsgController.title = [Userinfo shareUserinfo].name_zhCN;
//    newMsgNavController = [[KNavigationController alloc] initWithRootViewController:newMsgController];
//    newMsgNavController.delegate = self;
    
    tabBarController = [[KTabBarController alloc] init];
    tabBarController.tabDelegate = self;
    tabBarController.viewControllers = [NSArray arrayWithObjects:functionController,signInController,myAppController,newMsgController, nil];
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];
    
    [functionController release];
    [signInController release];
    [myAppController release];
    [newMsgController release];
    
    curTag = -1;
    
    [tabBarController chooseItemWith:0];
    
}

#pragma mark KTabBarControllerDelegate
//选择tabbar点击事件
- (void)selectTabBarAtIndex:(int)index
{
    NSLog(@"%d",curTag);
    if (curTag >= 0)
    {
        BaseViewController *lastController = [tabBarController.viewControllers objectAtIndex:curTag];
        [lastController tabViewDidDisappear];
    }
    
    BaseViewController *curController = [tabBarController.viewControllers objectAtIndex:index];
    [curController tabViewDidAppear];
    
    curTag = index;
}


#pragma mark TabBaseViewControllerDelegate

- (void)logOut
{
//    if (mainDelegate)
//    {
//        [mainDelegate logOutSuccess];
//    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    switch (curTag)
    {
        case 0:
        {
            BaseViewController *rootViewController = [functionNavController.viewControllers objectAtIndex:0];
            
            if (rootViewController == viewController)
            {
                tabBarController.tabBarView.hidden = NO;
            }
            else
            {
                tabBarController.tabBarView.hidden = YES;
            }
            
            break;
        }
        case 1:
        {
            BaseViewController *rootViewController = [signInNavController.viewControllers objectAtIndex:0];
            
            if (rootViewController == viewController)
            {
                tabBarController.tabBarView.hidden = NO;
            }
            else
            {
                tabBarController.tabBarView.hidden = YES;
            }
            
            break;
        }
        case 2:
        {
            BaseViewController *rootViewController = [myAppNavController.viewControllers objectAtIndex:0];
            
            if (rootViewController == viewController)
            {
                tabBarController.tabBarView.hidden = NO;
            }
            else
            {
                tabBarController.tabBarView.hidden = YES;
            }
            
            break;
        }
        case 3:
        {
            BaseViewController *rootViewController = [newMsgNavController.viewControllers objectAtIndex:0];
            
            if (rootViewController == viewController)
            {
                tabBarController.tabBarView.hidden = NO;
            }
            else
            {
                tabBarController.tabBarView.hidden = YES;
            }
            
            break;
        }
            
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
