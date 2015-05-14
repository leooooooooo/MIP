//
//  OfficialCheckView.m
//  OfficialCheck
//
//  Created by kangqijun on 14-3-31.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "OfficialCheckView.h"

@implementation OfficialCheckView

@synthesize backBtn;
@synthesize contentWebView;
@synthesize showAffixView;
@synthesize showAffix;
@synthesize isEmail;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 54)];
        navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
        [self addSubview:navBarImg];
        [navBarImg release];
        
        //返回按钮
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"t_back.png" imageBundle:mainBundle] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(10, 27, 55, 35);
        [self addSubview:backBtn];
        
        titleLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 150, 50)];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.font = [UIFont boldSystemFontOfSize:20];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.text = @"协同办公";
        [self addSubview:titleLable];
        [titleLable release];
        
        closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"button_close.png" imageBundle:officialCheckBundle] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.frame = CGRectMake(frame.size.width - 40, 27, 35, 35);
        [self addSubview:closeBtn];
        closeBtn.hidden = YES;
        
        showAffix = NO;
        isEmail   = NO;
    }
    return self;
}

- (void)addWebView
{
    contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 70)];
    contentWebView.scalesPageToFit = YES;
    contentWebView.delegate = self;
    [self addSubview:contentWebView];
    
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/5.0 (iPhone Simulator; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}

- (void)removeWebView
{
    [contentWebView removeFromSuperview];
}

- (void)closeWebView
{
    if (isEmail == YES)
    {
        [contentWebView goBack];
        titleLable.text = @"协同办公";
        showAffix = NO;
        closeBtn.hidden = YES;
        backBtn.hidden = NO;
    }
    else
    {
        [showAffixView removeFromSuperview];
        titleLable.text = @"协同办公";
        showAffix = NO;
        closeBtn.hidden = YES;
        backBtn.hidden = NO;
    }
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
    
    [webView.scrollView setZoomScale:0.8 animated:YES];
    
    _HUD = nil;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    NSLog(@"%@",url);
    NSString *downString = [url absoluteString];
    NSRange foundObj=[downString rangeOfString:@"downfile" options:NSCaseInsensitiveSearch];
    
    if(foundObj.length > 0)
    {
        NSLog(@"是下载连接");
        NSRange isEmailURL=[downString rangeOfString:@"Email" options:NSCaseInsensitiveSearch];
        
        if (isEmailURL.length > 0)//是邮件模块链接
        {
            isEmail = YES;
            showAffix = NO;
            
            backBtn.hidden = YES;
            closeBtn.hidden = NO;
            titleLable.text = @"附件";
            
            return YES;
        }
        else
        {
            isEmail = NO;
            showAffix = YES;
            backBtn.hidden = YES;
            closeBtn.hidden = NO;
            titleLable.text = @"附件";
            
            showAffixView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 70)];
            showAffixView.scalesPageToFit = YES;
            [self addSubview:showAffixView];
            
            [showAffixView loadRequest:[NSURLRequest requestWithURL:url]];
            
            [showAffixView release];
            
            return NO;
        }
    }
    else
    {
        NSLog(@"不是下载连接");
        showAffix = NO;
        isEmail = NO;
    }
    
    return YES;
}

- (void)dealloc
{
    contentWebView.delegate = nil;
    [contentWebView release];
    [super dealloc];
}

@end
