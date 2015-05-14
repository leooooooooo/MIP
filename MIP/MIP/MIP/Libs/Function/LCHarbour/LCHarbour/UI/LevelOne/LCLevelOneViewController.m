//
//  LCLevelOneViewController.m
//  LCHarbour
//
//  Created by kangqijun on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "LCLevelOneViewController.h"
#import "LCLevelOneTableViewController.h"
#import "LowCPortContentViewController.h"

@interface LCLevelOneViewController () <LowCLevelOneTableDelegate>
{
    LowCPortContentViewController           *_contentViewController;
}

@end

@implementation LCLevelOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    levelOneView = [[LCLevelOneView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 70, SCREEN_HEIGHT)];//减去的15个像素为左边的阴影
    
//    [levelOneView.backBtn addTarget:self action:@selector(closeDocTwoLevelData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = levelOneView;
    
    LCLevelOneTableViewController *levelOne = [[LCLevelOneTableViewController alloc] init];
    levelOne.m_delegate = self;
    
    [self addChildViewController:levelOne];
    [levelOneView setContentView:levelOne.view];
    
    [levelOneView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)selectedLowCPortUrl:(NSString *)url withTitle : (NSString *)title
{
    [self openContent:url withTitle:title];
}

- (void)openContent:(NSString *)content withTitle:(NSString *)name
{
    if (!isValid(content)||[content isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"当前条目地址为空！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    _contentViewController = [[LowCPortContentViewController alloc] init];
    [self presentViewController:_contentViewController animated:YES completion:NULL];
    
    NSURL *url = [NSURL URLWithString:[content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_contentViewController.contentWebView loadRequest:[NSURLRequest requestWithURL:url]];
    _contentViewController.titleLabel.text = name;
    [_contentViewController release];

}

//关闭
- (void)closeDocTwoLevelData:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
