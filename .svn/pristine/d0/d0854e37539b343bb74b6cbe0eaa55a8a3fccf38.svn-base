//
//  UnberthingProcessViewController.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/05/23.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "UnberthingProcessViewController.h"
#import "BusinessNetRequest.h"
#import "MBProgressHUD.h"
#import "BusinessDataParser.h"
#import "BerthList.h"
#import "BerthPosList.h"

@interface UnberthingProcessViewController ()<UnberthingProcessDelegate>

@end

@implementation UnberthingProcessViewController

@synthesize planMoveBerthTime,planMoveBerthNo;

@synthesize strBerthNo,strBerthName;

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
    
    m_unberthProcessView = [[UnberthingProcessView alloc] initWithFrame:CGRectMake(0, 0, 1004, 678)];
    
    m_unberthProcessView.planMoveBerthTime = planMoveBerthTime;
    m_unberthProcessView.planMoveBerthNo = planMoveBerthNo;
    m_unberthProcessView.curBerth = strBerthName;
    m_unberthProcessView.delegate = self;
    
    [self.contentView addSubview:m_unberthProcessView];
    
    self.title = @"移泊处理";
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForJobProcessInfoDetail)
                                   callback:@selector(berthBusinessProcessCallback:error:)
                                 backTarget:self
                                       args:self.shipId, nil];
    
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
                
                m_unberthProcessView.berthComList = tmpBerthDeptList;
                m_unberthProcessView.berthComValueList = tmpBerthDeptValueList;
                m_unberthProcessView.berthNameList = tmpBerthList;
                m_unberthProcessView.berthNameValueList = tmpBerthValueList;
                
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
                
                m_unberthProcessView.berthPosList = tmpBerthList;
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"船只信息获取失败，请检查网络或者重新操作。"];
    
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
                
                self.strBerthNo = [resultData objectForKey:@"curberthno"];
                m_unberthProcessView.curBerth = self.strBerthNo;
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"船只信息获取失败，请检查网络或者重新操作。"];
    
    return;
}

- (void) planCompleteClick
{
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveShiftingPlanComplete)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, [self getCurTime], nil];
}

- (void) leaveBerthingClick:(NSString *)leaveTime
{
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveShipLeaveBerth)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, self.strBerthNo, leaveTime, nil];
}

- (void) moveBerthingClick:(NSString *)berthTime withBerthId:(NSString *)berthId andBerthPos:(NSString *)berthPos andCompId:(NSString *)companyId
{
    [BusinessNetRequest executeAsynchronous:@selector(requestForSaveShipShiftBerth)
                                   callback:@selector(saveRequestCallback:error:) backTarget:self
                                       args:self.shipId, berthTime, berthId, berthPos, companyId, nil];
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
                [self showAlert:@"提示" withMsg:@"移泊处理信息保存成功。"];
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"移泊处理信息保存失败，请检查网络或者重新操作。"];
    
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

@end
