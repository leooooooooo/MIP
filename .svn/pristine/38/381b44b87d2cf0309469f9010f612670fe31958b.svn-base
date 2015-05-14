//
//  LowCPortContentViewController.m
//  LCHarbour
//
//  Created by lu_sicong on 2014/04/25.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "LowCPortContentViewController.h"
#import "MBProgressHUD.h"

@interface LowCPortContentViewController ()
{
    MBProgressHUD   *_HUD;
}

@end

@implementation LowCPortContentViewController

@synthesize backBtn;
@synthesize contentWebView;
@synthesize titleLabel;
@synthesize authorLabel;

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
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
    [self.view addSubview:navBarImg];
    [navBarImg release];
    
    //返回按钮
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"t_back.png" imageBundle:mainBundle] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, 5, 55, 35);
    [backBtn addTarget:self action:@selector(backButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, self.view.frame.size.width - 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 70)];
    contentWebView.delegate = self;
    contentWebView.scalesPageToFit =YES;
    [self.view addSubview:contentWebView];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        navBarImg.frame = CGRectMake(0, 20, SCREEN_WIDTH, 54);
        backBtn.frame = CGRectMake(10, 25, 55, 35);
        titleLabel.frame = CGRectMake(90, 20, self.view.frame.size.width - 90, 40);
        contentWebView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70);
    }
}

- (void)backButtonPress:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [contentWebView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    DLog(@"StartLoad");
    if (_HUD)
        return;
    
    _HUD = [MBProgressHUD showHUDAddedTo:webView animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    DLog(@"FinishLoad");
    [MBProgressHUD hideHUDForView:webView animated:YES];
    _HUD = nil;
}

@end
