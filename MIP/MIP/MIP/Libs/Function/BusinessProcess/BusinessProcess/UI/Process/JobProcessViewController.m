//
//  JobProcessViewController.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "JobProcessViewController.h"
#import "ProcessBaseView.h"
#import "BusinessNetRequest.h"
#import "MBProgressHUD.h"
#import "BusinessDataParser.h"

@interface JobProcessViewController () <JobProcessViewDelegate>
{
    NSString *strBerthName;

    NSString *strBerthNo;
}

@end

@implementation JobProcessViewController

@synthesize strBerthName, strBerthNo;

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
    [super loadView];
    CGRect rect=[[UIScreen mainScreen] bounds];
    m_jobProcessView = [[JobProcessView alloc] initWithFrame:CGRectMake(0, 0, rect.size.height, 320-20-44)];
    [self.contentView addSubview:m_jobProcessView];
    
    m_jobProcessView.delegate = self;
    
    self.title = @"作业处理";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForJobProcessInfoDetail)
                                   callback:@selector(berthBusinessProcessCallback:error:)
                                 backTarget:self
                                       args:self.shipId, nil];
}


- (void) saveRequestCallback : (ASIHTTPRequest *)request error: (NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"%@",[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding]);
    if (isValid(request.responseData))
    {
        //获取body中的数据
        NSData *bodyData = [BusinessNetRequest extractDataBodyFromResponsePackage:request.responseData];
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            
            if (0 == [ret intValue])
            {
                NSString *msg = [request.userInfo objectForKey:@"msg"];
                msg = [NSString stringWithFormat:@"%@成功。",msg];
                [self showAlert:@"提示" withMsg:msg];
                return;
            }
        }
    }
    
    NSString *msg = [request.userInfo objectForKey:@"msg"];
    if (isValid(msg)) {
        msg = [NSString stringWithFormat:@"%@失败，请检查网络或者重新操作。",msg];
        [self showAlert:@"提示" withMsg:msg];
        return;
    }
    
    [self showAlert:@"提示" withMsg:@"获取数据失败!"];
    
    return;
    
}

- (void) berthBusinessProcessCallback : (NSData *)data error: (NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [BusinessNetRequest extractDataBodyFromResponsePackage:data];
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            
            if (0 == [ret intValue])
            {
                NSDictionary *resultData = [BusinessDataParser parseShipInfoDetail:bodyData];
                
                m_jobProcessView.unloadMargin = [resultData objectForKey:@"currestton"];
                
                m_jobProcessView.unloadCount = [resultData objectForKey:@"loadunloadweight"];
                m_jobProcessView.totalStopTime = [resultData objectForKey:@"shipremaintime"];
                
                m_jobProcessView.unloadStartTime = [resultData objectForKey:@"unloadbegintime"];
                m_jobProcessView.unloadEndTime = [resultData objectForKey:@"unloadendtime"];
                m_jobProcessView.loadingStartTime = [resultData objectForKey:@"loadbegintime"];
                m_jobProcessView.loadingEndTime = [resultData objectForKey:@"loadendtime"];
                
                self.strBerthNo = [resultData objectForKey:@"berthno"];
                m_jobProcessView.curBerth = self.strBerthNo;
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"船只信息获取失败，请检查网络或者重新操作。"];
    
    return;
}

- (void) saveMarginValue : (NSString *)margin
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveMarginValue)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, margin, [self getCurTime], nil];
}

- (void) confirmAssessment : (NSString *)unloadCount andStopTime:(NSString *)stopTime
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForConfirmAssessment)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, self.strBerthNo, unloadCount, stopTime, [self getCurTime], nil];
}

- (void) saveUnloadStartTime : (NSString *)unloadStartTime
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveUnloadStartTime)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, self.strBerthNo, unloadStartTime, [self getCurTime], nil];
}

- (void) saveUnloadStartTime:(NSString *)unloadStartTime withUnloadEndTime:(NSString *)unloadEndTime
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveUnloadEndTime)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, self.strBerthNo, unloadStartTime, unloadEndTime, [self getCurTime], nil];
}

- (void) saveloadStartTime : (NSString *)loadStartTime
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveloadStartTime)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, self.strBerthNo, loadStartTime, [self getCurTime], nil];
}

- (void) saveloadStartTime:(NSString *)loadStartTime withLoadEndTime:(NSString *)loadEndTime
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveloadEndTime)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, self.strBerthNo, loadStartTime, loadEndTime, [self getCurTime], nil];
}

- (void) saveErrorHandling
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveErrorHandling)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, self.strBerthNo, [self getCurTime], nil];
}

- (void) saveNonLoadUnloadShip
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveNonLoadUnloadShip)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, [self getCurTime], nil];
}

- (NSString *) getCurTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *curTime = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    return curTime;
}

- (void)showErrorAlert:(NSString *)title
{
    [self showAlert:title withMsg:nil];
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
