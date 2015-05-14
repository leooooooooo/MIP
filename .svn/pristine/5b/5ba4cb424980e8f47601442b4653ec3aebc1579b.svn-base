//
//  MyAppViewController.m
//  MIP_iPhone_LYG
//
//  Created by kangqijun on 14-4-10.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "MyAppViewController.h"

@interface MyAppViewController ()

@end

@implementation MyAppViewController

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
    
    _categoryTableViewController = [[MyAppTableViewController alloc] initWithStyle:UITableViewStylePlain];
    _categoryTableViewController._categoryDelegate = self;
    [self addChildViewController:_categoryTableViewController];
    [self.view addSubview:_categoryTableViewController.view];
}

-(void)didSelectedApp:(ApplicationInfor *)info
{
    if ([info isKindOfClass:[ApplicationInfor class]]) {

        NSString *urlStr = info.attachUrl;
        NSURL *url = [NSURL URLWithString:urlStr];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"打开应用失败"     message:@"无法找到该应用" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    } else {
        myAppCenterViewController = [[MyAppCenterViewController alloc] init];
        [self.navigationController pushViewController:myAppCenterViewController animated:YES];
        [myAppCenterViewController release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
