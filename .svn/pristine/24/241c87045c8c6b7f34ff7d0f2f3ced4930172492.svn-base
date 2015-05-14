//
//  ContentViewController.m
//  NewsCenter
//
//  Created by wanghao on 14-3-19.
//
//

#import "ContentViewController.h"
#import "UILabel+CustomExtensions.h"

#define WebContentTextFont      300

@interface ContentViewController () <UIWebViewDelegate>

@end

@implementation ContentViewController
@synthesize contentWebView;
@synthesize titleLabel;
@synthesize authorLabel;
@synthesize contentDelegate;
@synthesize sourceLabel;


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
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
    [self.view addSubview:navBarImg];
    [navBarImg release];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"t_back.png" imageBundle:mainBundle] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, 5, 55, 35);
    [backBtn addTarget:self action:@selector(backButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIView *labView = [[UIView alloc] initWithFrame:CGRectMake(70, 5, 250, 50)];
    labView.backgroundColor = [UIColor clearColor];
    labView.clipsToBounds = YES;
    [self.view addSubview:labView];
    [labView release];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [labView addSubview:titleLabel];
    [titleLabel release];
    contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50)];
    contentWebView.scalesPageToFit =YES;
    contentWebView.delegate = self;
    [self.view addSubview:contentWebView];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        navBarImg.frame = CGRectMake(0, 20, SCREEN_WIDTH, 54);
        backBtn.frame = CGRectMake(10, 28, 55, 35);
        titleLabel.frame = CGRectMake(80, 20, 220, 40);
        contentWebView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70);
    }
    if (![titleLabel textIsLongerThanWidth])
    {
        CGRect rect = titleLabel.frame;
        rect.size.width = 180;
        titleLabel.frame = rect;
    }
    else
    {
        
    }
    
//    contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50)];
//    contentWebView.scalesPageToFit =YES;
//    contentWebView.delegate = self;
//    [self.view addSubview:contentWebView];
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
//        navBarImg.frame = CGRectMake(0, 20, SCREEN_WIDTH, 54);
//        backBtn.frame = CGRectMake(10, 28, 55, 35);
//        titleLabel.frame = CGRectMake(80, 20, 220, 40);
//        contentWebView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70);
//    }
    /*
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 748)];
    backImageView.image = [UIImage imageNamed:@"bg_pdf_toolBar_style1.png" imageBundle:newsCenterBundle];
    [self.view addSubview:backImageView];
    backImageView.userInteractionEnabled = YES;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 964, 60)];
    titleView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:titleView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 700, 60)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = UITextAlignmentRight;
    titleLabel.font = [UIFont boldSystemFontOfSize:24];
    [titleView addSubview:titleLabel];
    [titleLabel release];
    
    authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(700, 10, 200, 60)];
    authorLabel.textColor = [UIColor colorWithHex:@"3c557f"];
    authorLabel.backgroundColor = [UIColor clearColor];
    authorLabel.textAlignment = UITextAlignmentCenter;
    authorLabel.font = [UIFont systemFontOfSize:14];
    [titleView addSubview:authorLabel];
    [authorLabel release];
    
    sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(800, 10, 200, 60)];
    sourceLabel.textColor = [UIColor colorWithHex:@"3c557f"];
    sourceLabel.backgroundColor = [UIColor clearColor];
    sourceLabel.textAlignment = UITextAlignmentCenter;
    sourceLabel.font = [UIFont systemFontOfSize:14];
    [titleView addSubview:sourceLabel];
    [sourceLabel release];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 5, 60, 60)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_style1_1.png" imageBundle:newsCenterBundle] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_style1_2.png" imageBundle:newsCenterBundle] forState:UIControlStateHighlighted];
    [backImageView addSubview:backButton];
    
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [backButton addTarget:self action:@selector(backButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
    
    contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(60, 60, 964, 708)];
    [self.view addSubview:contentWebView];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        backImageView.frame = CGRectMake(0, 20, 60, 748);
        titleView.frame = CGRectMake(60, 20, 964, 60);
        contentWebView.frame = CGRectMake(60, 80, 964, 688);
        
    }
    */
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if ([titleLabel textIsLongerThanWidth])
    {
        [titleLabel widthFitLabText];
        [titleLabel showMarqueeStyle];
    }
}

- (void)backButtonPress:(id)sender
{
    if (contentDelegate)
    {
        [contentDelegate backToViewController];
    }
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
//    [self fontLarger];
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
//    [self fontLarger];
}

- (void) fontLarger
{
    NSString *jsString = [[NSString alloc] initWithFormat:@"for(item in document.getElementsByTagName('p')) {document.getElementsByTagName('p')[item].style.webkitTextSizeAdjust = '%d%%';}",WebContentTextFont];
    
    [self.contentWebView stringByEvaluatingJavaScriptFromString:jsString];
    [jsString release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#ifdef __IPHONE_6_0
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}
#endif

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return NO;
}

@end
