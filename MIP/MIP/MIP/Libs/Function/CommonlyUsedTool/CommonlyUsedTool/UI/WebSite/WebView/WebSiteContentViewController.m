//
//  WebSiteContentViewController.m
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-27.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "WebSiteContentViewController.h"
#import "MBProgressHUD.h"

@interface WebSiteContentViewController (){
    MBProgressHUD   *_HUD;
}

@end

@implementation WebSiteContentViewController
@synthesize contentWebView;
@synthesize titleLabel;
@synthesize authorLabel;
- (void)dealloc{
    [contentWebView release];
    [super dealloc];
}
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
    
//    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 748)];
//    backImageView.image = [UIImage imageNamed:@"bg_pdf_toolBar_style1.png" imageBundle:newsCenterBundle];
//    [self.view addSubview:backImageView];
//    backImageView.userInteractionEnabled = YES;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 60)];
    titleView.backgroundColor = [UIColor grayColor];
    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 964, 60)];
    titleLabel.textColor = [UIColor colorWithHex:@"3c557f"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleView addSubview:titleLabel];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 5, 60, 60)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_style1_1.png" imageBundle:newsCenterBundle] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_style1_2.png" imageBundle:newsCenterBundle] forState:UIControlStateHighlighted];
    [titleView addSubview:backButton];
    
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [backButton addTarget:self action:@selector(backButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
    
    [self.view addSubview:titleView];
    
    [titleView release];
    
    
    contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, 1024, 708)];
    contentWebView.delegate = self;
    contentWebView.scalesPageToFit =YES;
    [self.view addSubview:contentWebView];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
//        backImageView.frame = CGRectMake(0, 20, 60, 748);
        titleView.frame = CGRectMake(0, 20, 1024, 60);
        contentWebView.frame = CGRectMake(0, 80, 1024, 688);
        
    }
}

- (void)backButtonPress:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
