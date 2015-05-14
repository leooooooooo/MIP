//
//  BusinessProcessLevelOneViewController.m
//  BusinessProcess
//
//  Created by wanghao on 14-3-12.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessProcessLevelOneViewController.h"
#import "BerthingProcessViewController.h"
#import "BusinessProcessLevelTwoViewController.h"

@interface BusinessProcessLevelOneViewController ()

@end

@implementation BusinessProcessLevelOneViewController

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
}

- (void)loadView
{
    _levelOneView = [[BusinessProcessLevelOneView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 70, SCREEN_HEIGHT)];//减去的15个像素为左边的阴影
    self.view = _levelOneView;
    
    _menuTableViewController = [[BusinessProcessLevelOneTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    _menuTableViewController.delegate = self;
    
    [_menuTableViewController setUnionId:self.unionId];
    
    [self addChildViewController:_menuTableViewController];
    [self.view addSubview:_menuTableViewController.view];
    
    [_levelOneView release];
}

- (void) selectBusinessType : (BusinessType *) type
{    
    BusinessProcessLevelTwoViewController *businessProcessLevelTwoViewController = [[BusinessProcessLevelTwoViewController alloc] init];
    businessProcessLevelTwoViewController.businessType = type;
    
    [self.navigationController pushViewController:businessProcessLevelTwoViewController animated:YES];
    
    [businessProcessLevelTwoViewController release];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
