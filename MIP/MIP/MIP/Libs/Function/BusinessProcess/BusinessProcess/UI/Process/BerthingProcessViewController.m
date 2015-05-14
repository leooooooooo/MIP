//
//  BerthingProcessViewController.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/01.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BerthingProcessViewController.h"
#import "BusinessNetRequest.h"
#import "MBProgressHUD.h"
#import "BusinessDataParser.h"
#import "BerthList.h"
#import "BerthPosList.h"
#define FrameWidth         ([[UIScreen mainScreen] bounds].size.height)

@interface BerthingProcessViewController ()<BerthingProcessDelegate>

@end

@implementation BerthingProcessViewController

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
    
    m_berthProcessView = [[BerthingProcessView alloc] initWithFrame:self.contentView.frame];
    
    m_berthProcessView.planEnterPortTime = m_planEnterPortTime;
    m_berthProcessView.planLeavePortTime = m_planLeavePortTime;
    
    m_berthProcessView.delegate = self;
    
    [self.contentView addSubview:m_berthProcessView];
    
    self.title = @"靠泊处理";
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForBerthList)
                                   callback:@selector(berthListCallback:error:) backTarget:self args:nil];
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForBerthPosList)
                                   callback:@selector(berthPosListCallback:error:) backTarget:self args:nil];
}

- (void) berthListCallback : (NSData *)data error: (NSError *)error
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
                [BusinessDataParser parseBerthInfoList:bodyData];
                
                if (![[BerthList sharedFetchedResultsController] performFetch:nil]) {
                    return;
                }
                
                NSMutableArray *tmpBerthList = [[NSMutableArray alloc] init];
                NSMutableArray *tmpBerthValueList = [[NSMutableArray alloc] init];
                NSMutableArray *tmpBerthDeptList = [[NSMutableArray alloc] init];
                NSMutableArray *tmpBerthDeptValueList = [[NSMutableArray alloc] init];
                
                for (BerthList *tmpBerth in [BerthList sharedFetchedResultsController].fetchedObjects) {
                    if (tmpBerth.berthNo) {
                        [tmpBerthList addObject:tmpBerth.berthNo];
                    }
                    else {
                        continue;
                    }
                    
                    if (tmpBerth.berthId) {
                        [tmpBerthValueList addObject:tmpBerth.berthId];
                    }
                    else {
                        [tmpBerthValueList addObject:@""];
                    }
                    
                    if (tmpBerth.deptCode) {
                        [tmpBerthDeptValueList addObject:tmpBerth.deptCode];
                    }
                    else {
                        [tmpBerthDeptValueList addObject:@""];
                    }
                    
                    if (tmpBerth.department) {
                        [tmpBerthDeptList addObject:tmpBerth.department];
                    }
                    else {
                        [tmpBerthDeptList addObject:@"锚地"];
                    }
                }
                
                m_berthProcessView.berthComList = tmpBerthDeptList;
                m_berthProcessView.berthComValueList = tmpBerthDeptValueList;
                m_berthProcessView.berthNameList = tmpBerthList;
                m_berthProcessView.berthNameValueList = tmpBerthValueList;
                
                [tmpBerthList release];
                [tmpBerthValueList release];
                [tmpBerthDeptList release];
                [tmpBerthDeptValueList release];
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"船只信息获取失败，请检查网络或者重新操作。"];
    
    return;
}

- (void) berthPosListCallback : (NSData *)data error: (NSError *)error
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
                [BusinessDataParser parseBerthPosInfoList:bodyData];
                
                if (![[BerthPosList sharedFetchedResultsController] performFetch:nil]) {
                    return;
                }
                
                NSMutableArray *tmpBerthList = [[NSMutableArray alloc] init];
                
                for (BerthPosList *tmpBerthPos in [BerthPosList sharedFetchedResultsController].fetchedObjects) {
                    if (tmpBerthPos.position) {
                        [tmpBerthList addObject:tmpBerthPos.position];
                    }
                }
                
                m_berthProcessView.berthPosList = tmpBerthList;
                
                [tmpBerthList release];
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"船只信息获取失败，请检查网络或者重新操作。"];
    
    return;
}

- (void)planCompleteClick
{
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveBerthingPlanComplete)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, [self getCurTime], nil];
}

- (void)berthingClick:(NSString *)berthTime withBerthId:(NSString *)berthId andBerthPos:(NSString *)berthPos andCompId:(NSString *)companyId andRemark:(NSString *)remark
{
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveShipBerthing)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, remark, berthId, berthPos, companyId, berthTime, nil];
}

- (void) saveRequestCallback : (ASIHTTPRequest *)request error: (NSError *)error
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
                [self showAlert:@"提示" withMsg:@"靠泊处理信息保存成功。"];
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"靠泊处理信息保存失败，请检查网络或者重新操作。"];
    
    return;
    
}

- (NSString *) getCurTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *curTime = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    return curTime;
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
