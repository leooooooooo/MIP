//
//  TabBaseViewController.m
//  Main
//
//  Created by kangqijun on 14-4-14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "TabBaseViewController.h"
#import "KTabBarController.h"
#import "SettingViewController.h"


@interface TabBaseViewController ()

@end

@implementation TabBaseViewController

@synthesize tabBaseDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 54)];
    navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
    [self.view addSubview:navBarImg];
    [navBarImg release];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 150, 40)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = UITextAlignmentCenter;
    titleLable.text = self.title;
    [self.view addSubview:titleLable];
    [titleLable release];
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"set_bg.png" imageBundle:mainBundle] forState:UIControlStateNormal];
    setBtn.frame = CGRectMake(10, 7, 55, 35);
    [setBtn addTarget:self action:@selector(goToSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setBtn];
    
    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOutBtn setBackgroundImage:[UIImage imageNamed:@"logout_bg.png" imageBundle:mainBundle] forState:UIControlStateNormal];
    logOutBtn.frame = CGRectMake(255, 7, 55, 35);
    [logOutBtn addTarget:self action:@selector(quite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutBtn];
}

- (void)goToSetting
{
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
    [settingViewController release];
}

- (void)tabViewAppear
{
    
}

- (void)quite
{
    if (tabBaseDelegate)
    {
        [tabBaseDelegate logOut];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
