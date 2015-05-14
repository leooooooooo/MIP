//
//  MyAppCenterViewController.m
//  MyAppCenter
//
//  Created by mengxianglei on 2014/04/15.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import "MyAppCenterViewController.h"

@interface MyAppCenterViewController ()

@end

@implementation MyAppCenterViewController

- (void)loadView
{
    m_appCenterView = [[MyAppCenterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    m_appCenterView.titleLable.text = @"应用仓库";
    [m_appCenterView.backBtn addTarget:self action:@selector(closeAppCenter:) forControlEvents:UIControlEventTouchUpInside];
    self.view = m_appCenterView;
    
    MyAppCenterTableViewController *m_appCenterTableViewController = [[MyAppCenterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    m_appCenterTableViewController.m_delegate = self;
    
    [self addChildViewController: m_appCenterTableViewController];

    [m_appCenterView addSubview:m_appCenterTableViewController.view];
    
    [m_appCenterView release];
    
    [m_appCenterTableViewController release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) didSelectedAppType:(ApplicationType *)appType
{
    MyAppListViewController *appListViewController = [[MyAppListViewController alloc] init];
    appListViewController.appType = appType;
    [self.navigationController pushViewController:appListViewController animated:YES];
    [appListViewController release];
}

//返回
- (void)closeAppCenter:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
