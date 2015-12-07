//
//  OfficialCheckViewController.m
//  OfficialCheck
//
//  Created by kangqijun on 14-3-31.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "OfficialCheckViewController.h"

@interface OfficialCheckViewController ()

@end

@implementation OfficialCheckViewController

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
    [officialCheckView release];
    [super dealloc];
}

- (void)loadView
{
    officialCheckView = [[OfficialCheckView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];//减去的15个像素为左边的阴影
    [officialCheckView.backBtn addTarget:self action:@selector(closeDocTwoLevelData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = officialCheckView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [officialCheckView addWebView];
    
//    NSString *urlString = [NSString stringWithFormat:@"http://218.92.115.51/portal/m/index_sso.jsp?userId=%@",[Userinfo shareUserinfo].uid];
    NSString *urlString = [NSString stringWithFormat:@"http://218.92.115.51/portal/m_index_sso.jsp?userid=%@&pwd=%@",[Userinfo shareUserinfo].uid,[Userinfo shareUserinfo].password];
    [officialCheckView.contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

//返回
- (void)closeDocTwoLevelData:(id)sender
{
    /*
    if (officialCheckView.isEmail == YES)
    {
        [officialCheckView.contentWebView goBack];
        officialCheckView.isEmail = NO;
    }
    else
    {
        if (officialCheckView.showAffix == YES)
        {
            [officialCheckView.showAffixView removeFromSuperview];
            officialCheckView.showAffix = NO;
        }
        else
        {
            [officialCheckView removeWebView];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    */
    [officialCheckView removeWebView];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
