//
//  RootViewController.m
//  MIP
//
//  Created by Sea on 13-9-3.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "RootViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "DeviceAuthNetRequest.h"

#import "CustomAlertController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        _loginViewController = [[LoginViewController alloc] init];
        
        [self addChildViewController:_loginViewController];
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    
    [_loginViewController release];
    _loginViewController    = nil;
    
    [_mainViewController release];
    _mainViewController     = nil;
    
    [super dealloc];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    
    self.view = tempView;
    
    [tempView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _loginViewController.delegate = self;
    
    [self.view addSubview:_loginViewController.view];
}

- (void)checkDeviceLostState:(NSData *)data
{
    NSData *bodyData = [DeviceAuthNetRequest extractDataBodyFromResponsePackage:data];
    
    if (isValid(bodyData))
    {
        NSError *error = nil;
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        DLog(@"%@",retMsg);
        
        if (7 == [ret intValue])
        {
            [self showOperateFinish:@"此设备已丢失，正在清洗数据..."];
            
            [self cleanFileData];
        }
        
    }
    
}

//操作结果提示
- (void)showOperateFinish:(NSString *)msg {
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
    
    bgImageView.image = [UIImage imageNamed:@"bg_alert_style1.png" imageBundle:publicResourceBundle];
    
    UIView *alertView = [[UIView alloc] initWithFrame:bgImageView.frame];
    [alertView addSubview:bgImageView];
    
    //描述信息
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, bgImageView.frame.size.width, 50)];
    titleLab.text = @"提示";
    titleLab.font = [UIFont boldSystemFontOfSize:22];
    titleLab.textAlignment = UITextAlignmentCenter;
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [alertView addSubview:titleLab];
    [titleLab release];
    
    contentLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 360, 80)];
    contentLab.text = msg;
    contentLab.font = [UIFont boldSystemFontOfSize:16];
    contentLab.numberOfLines = 2;
    contentLab.textAlignment = UITextAlignmentCenter;
    [contentLab setTextColor:[UIColor colorWithHex:@"474747"]];
    [contentLab setBackgroundColor:[UIColor whiteColor]];
    [alertView addSubview:contentLab];
    [contentLab release];
    
    proView = [[UIProgressView alloc] initWithFrame:CGRectMake(40, 110, 320, 20)];
    [proView setProgressViewStyle:UIProgressViewStyleBar]; //设置进度条类型
    [alertView addSubview:proView];
    [proView release];
    
    CustomAlertController *alertController = [[CustomAlertController alloc] initWithContentView:alertView];
    
    alertController.touchDownOutsideContentWillDismiss = NO;
    alertController.animateStyle = CustomAlertAnimateStyleDefault;
    
    [alertController show];
    
    [alertController release];
    [bgImageView release];
    [alertView release];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES]; //利用计时器，每隔1秒调用一次（changeProgress）
}

-(void)changeProgress
{
    proValue += 1.0;
    
    if(proValue > 15)
    {
        //停用计时器
        [timer invalidate];
        
        timer = nil;
        
        [self cleanDataFinish];
    }
    else
    {
        [proView setProgress:(proValue/15.0) animated:YES];//重置进度条
    }
}


- (void)cleanFileData
{
    NSString *DocumentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *subDir = [fileManager subpathsOfDirectoryAtPath:DocumentPath error:nil];
    
    for (NSString *fileName in subDir)
    {
        NSString *filePath = [DocumentPath stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:filePath error:NULL];
    }
}

- (void)cleanDataFinish
{
    contentLab.text = @"清洗完成！";
    
    [self performSelector:@selector(getOutToApp) withObject:nil afterDelay:1.0];
}

- (void)getOutToApp
{
    exit(0);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    return NO;
}


#pragma mark -
#pragma mark LoginDelegate methods
/*!
 @function
 @abstract      登陆成后的,通知root,根控制器负责进行页面跳转
 
 @result
 */
- (void)loginSuccess {
    
    
    if (!_mainViewController) {
        
        _mainViewController = [[MainViewController alloc] init];
        _mainViewController.mainDelegate = self;
        [self addChildViewController:_mainViewController];
    }
    
    [self transitionFromViewController:_loginViewController toViewController:_mainViewController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        
        CATransition *animation = [CATransition animation];
        animation.duration = 1.0f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.fillMode = kCAFillModeForwards;
        animation.type = @"rippleEffect";
        [self.view.layer addAnimation:animation forKey:@"animation"];
        
    } completion:^(BOOL finished) {
        
    }];
}



#pragma mark -
#pragma mark MainViewDelegate methods
/*!
 @function
 @abstract      mainView即将消失的回调方法
 
 @result
 */
- (void)logOutSuccess {
    
    [self transitionFromViewController:_mainViewController toViewController:_loginViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            [_mainViewController removeFromParentViewController];
            [_mainViewController release];
            _mainViewController = nil;
        }
    }];
    
}

@end
