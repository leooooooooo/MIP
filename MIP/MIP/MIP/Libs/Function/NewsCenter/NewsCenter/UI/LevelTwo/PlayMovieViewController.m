//
//  PlayMovieViewController.m
//  NewsCenter
//
//  Created by kangqijun on 14-4-16.
//
//

#import "PlayMovieViewController.h"


@interface PlayMovieViewController ()
{
    NewsCenterDocument    *curDocument;
}

@property (retain, nonatomic) NewsCenterDocument    *curDocument;

@end

@implementation PlayMovieViewController

@synthesize curDocument;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDocument:(NewsCenterDocument *)document
{
    self = [super init];
    if (self)
    {
        self.curDocument = document;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *window = [windows objectAtIndex:0];
    NSLog(@"------------%@",NSStringFromCGRect(window.frame));
    
    UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, window.frame.size.height, 54)];
//    navBarImg.contentMode = UIViewContentModeScaleAspectFit;
    navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
    [self.view addSubview:navBarImg];
    [navBarImg release];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 60, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"t_back.png" imageBundle:mainBundle] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 22, window.frame.size.height-70, 50)];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = self.curDocument.title;
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    //播放器
    moviePlayer = [[MPMoviePlayerController alloc] init];
    moviePlayer.view.frame = CGRectMake(0, 70, window.frame.size.height, window.frame.size.width-70);
    [moviePlayer setMovieSourceType:MPMovieSourceTypeStreaming];
    [self.view addSubview:moviePlayer.view];
    
//    self.view.transform = CGAffineTransformRotate(self.view.transform,M_PI/2.0);;
    
    [self playVedioRecordWith:self.curDocument];
}

- (void)backToList
{
    [moviePlayer stop];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)])
    {
        [[UIDevice currentDevice]performSelector:@selector(setOrientation:)
                                      withObject:(id)UIDeviceOrientationPortrait];
    }
}

//播放视频
- (void)playVedioRecordWith:(NewsCenterDocument *)record
{
    if (isValid(record.url))
    {
        NSString *s = [record.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:s];
        moviePlayer.contentURL = url;
        [moviePlayer play];
    }
}

- (void)dealloc
{
    [moviePlayer release];
    
    [super dealloc];
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
    return UIInterfaceOrientationMaskLandscape;
}
#endif

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
