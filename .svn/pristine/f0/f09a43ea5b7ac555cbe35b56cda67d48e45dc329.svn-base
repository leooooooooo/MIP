//
//  OutwardProcessViewController.m
//  BusinessProcess
//
//  Created by mengxianglei on 14-5-22.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "OutwardProcessViewController.h"
#import "BusinessNetRequest.h"
#import "MBProgressHUD.h"
#import "BusinessDataParser.h"
#import "BerthList.h"
#import "BerthPosList.h"

@interface OutwardProcessViewController ()

@end

@implementation OutwardProcessViewController

@synthesize planEnterPortTime,planLeavePortTime;

@dynamic delegate;

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
    
    m_outwardProcessView = [[OutwardProcessView alloc] initWithFrame:CGRectMake(0, 0, 1004, 678)];
    m_outwardProcessView.delegate = self;
    m_outwardProcessView.planEnterPortTime = m_planEnterPortTime;
    m_outwardProcessView.planLeavePortTime = m_planLeavePortTime;
    
    [self.contentView addSubview:m_outwardProcessView];
    
    self.title = @"离港处理";
}

#pragma OutwardProcessViewDelegate
-(void)planCompleteClickAction
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveLeavePlanComplete)
                                   callback:@selector(saveLeavePlanCompleteCallback:error:) backTarget:self args:self.shipId,[self getCurTime],nil];
}

-(void)shipLeaveClickAction:(NSString *)remark andLeadTime:(NSString *)leadTime andLeaveTime:(NSString *)leaveTime
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveShipLeave)
                                   callback:@selector(saveShipLeaveCallback:error:) backTarget:self args:self.shipId,remark,leadTime,leaveTime,nil];
}

- (NSString *) getCurTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *curTime = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    return curTime;
}

- (void) saveLeavePlanCompleteCallback : (ASIHTTPRequest *)request error: (NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
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
                [self showAlert:@"提示" withMsg:@"保存离港处理计划执行完毕数据成功。"];
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"保存离港处理计划执行完毕数据失败，请检查网络或者重新操作。"];
    
    return;
}

- (void) saveShipLeaveCallback: (ASIHTTPRequest *)request error: (NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
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
                [self showAlert:@"提示" withMsg:@"保存离港处理船舶离港数据成功。"];
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"保存离港处理船舶离港数据失败，请检查网络或者重新操作。"];
    
    return;
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
