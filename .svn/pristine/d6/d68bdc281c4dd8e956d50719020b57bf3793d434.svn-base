//
//  BusinessProcessLevelTwoViewController.m
//  BusinessProcess
//
//  Created by wanghao on 14-3-12.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//
#import "AlertView.h"
#import "BusinessProcessLevelTwoViewController.h"
#import "BusinessProcessLevelTwoView.h"
#import "BusinessProcessLevelTwoTableViewController.h"
#import "BusinessType.h"
#import "BusinessDefine.h"
#import "ShipDetailViewController.h"
#import "JobProcessViewController.h"
#import "BerthingProcessViewController.h"
#import "OutwardProcessViewController.h"
#import "UnberthingProcessViewController.h"

#define kKalCalendarBundle          @"KalCalendar"
#import "BusinessNetRequest.h"
#import "BusinessDataParser.h"
#import "JobCompany.h"

#import "BusinessDatePickerView.h"

#import "MBProgressHUD.h"

@interface BusinessProcessLevelTwoViewController () <BusinessProcessViewDelegate, BusinessProcessTableDelegate, ProcessBaseControllerDelegate>
{
    BusinessType *m_businessType;
    
    BusinessProcessLevelTwoView *m_levelTwoView;
    
    BusinessProcessLevelTwoTableViewController *m_levelTwoTable;
}

@end

@implementation BusinessProcessLevelTwoViewController

@synthesize businessType = m_businessType;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)loadView
{
    m_levelTwoView = [[BusinessProcessLevelTwoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = m_levelTwoView;
    m_levelTwoView.delegate = self;
    
    m_levelTwoTable = [[BusinessProcessLevelTwoTableViewController alloc] initWithStyle:UITableViewStylePlain];
    m_levelTwoTable.delegate = self;
    
    if (m_businessType) {
        
        self.businessType = m_businessType;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)setBusinessType:(BusinessType *)businessType
{
    m_businessType = businessType;
    
    [m_levelTwoView setProcessType:[m_businessType.type integerValue] andProcessTypeName:m_businessType.title];
    
    if ([m_businessType.type integerValue] == BusinessLargeCommission) {
        
        [BusinessNetRequest executeAsynchronous:@selector(requestForJobCompanyList)
                                       callback:@selector(jobCompanyCallback:error:) backTarget:self args:nil];
        
        [self tabButtonClick:0];
    }
    
    m_levelTwoTable.processType = m_businessType;

    [m_levelTwoView setTableTitleView:[m_levelTwoTable getTableTitle]];
    
    [m_levelTwoView setTableContentView:m_levelTwoTable.tableView];
    
    m_levelTwoTable.tableView.frame = [m_levelTwoView tableViewFrame];
}

- (void) jobCompanyCallback : (NSData *)data error: (NSError *)error
{
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
                [BusinessDataParser parseJobCompanyList:bodyData];
                
                if (![[JobCompany sharedFetchedResultsController] performFetch:nil]) {
                    return;
                }
                
                NSMutableArray *tmpJobCompany = [[NSMutableArray alloc] init];
                NSMutableArray *tmpJobComValueList = [[NSMutableArray alloc] init];
                
                [tmpJobCompany addObject:@"所有公司"];
                [tmpJobComValueList addObject:@""];
                
                for (JobCompany *tmpCom in [JobCompany sharedFetchedResultsController].fetchedObjects) {
                    if (tmpCom.codeDepartment) {
                        [tmpJobComValueList addObject:tmpCom.codeDepartment];
                    }
                    else {
                        continue;
                    }
                    
                    if (tmpCom.department) {
                        [tmpJobCompany addObject:tmpCom.department];
                    }
                    else {
                        [tmpJobCompany addObject:@""];
                    }
                }
                
                m_levelTwoView.jobComNameList = tmpJobCompany;
                m_levelTwoView.jobComIdList = tmpJobComValueList;
                
                [tmpJobCompany release];
                [tmpJobComValueList release];
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"船只信息获取失败，请检查网络或者重新操作。"];
    
    return;
}

- (void)tabButtonClick:(NSInteger)index
{
    if (index == 0) {
        m_levelTwoTable.withShip = YES;
    }else {
        m_levelTwoTable.withShip = NO;
    }
    
    [m_levelTwoView setTableTitleView:[m_levelTwoTable getTableTitle]];
}

- (void) search:(NSDictionary *)dic
{
    [m_levelTwoTable search:dic];
}

- (void)closeBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)])
    {
        [[UIDevice currentDevice]performSelector:@selector(setOrientation:)
                                      withObject:(id)UIDeviceOrientationPortrait];
    }
}

- (void)clickBtn:(NSInteger)index withShipId:(NSString *)shipId andDataDic : (NSDictionary *)data
{
    
    if (index == 0) {
        
        ShipDetailViewController *shipDetailCtrl = [[ShipDetailViewController alloc] init];
        
        shipDetailCtrl.shipId = shipId;
        
//        [self presentViewController:shipDetailCtrl animated:YES completion:NULL];
        
        [self.navigationController pushViewController:shipDetailCtrl animated:YES];
        
        [shipDetailCtrl release];
        
        return;
    }
    
    switch ([m_businessType.type integerValue]) {
            
        case BerthingProcess:
        {
            BerthingProcessViewController *berthProcessCtrl = [[BerthingProcessViewController alloc] init];
            
            berthProcessCtrl.shipId = shipId;
            
            berthProcessCtrl.planEnterPortTime = [data objectForKey:@"planInPortTime"];
            
            berthProcessCtrl.planLeavePortTime = [data objectForKey:@"planOutPortTime"];
            
            berthProcessCtrl.delegate = self;
            
//            [self presentViewController:berthProcessCtrl animated:YES completion:NULL];
            [self.navigationController pushViewController:berthProcessCtrl animated:YES];
            
            [berthProcessCtrl release];
        }
            break;
        case JobProcess:
        {
            JobProcessViewController *jobProcessCtrl = [[JobProcessViewController alloc] init];
            
            jobProcessCtrl.shipId = shipId;
            
            jobProcessCtrl.delegate = self;
            
            [self.navigationController pushViewController:jobProcessCtrl animated:YES];
            
            [jobProcessCtrl release];
        }
            break;
        case UnberthingProcess:
        {
            UnberthingProcessViewController *unberthProcessCtrl = [[UnberthingProcessViewController alloc] init];
            
            unberthProcessCtrl.shipId = shipId;
            
            unberthProcessCtrl.planMoveBerthTime = [data objectForKey:@"planMoveBerthTime"];
            
            unberthProcessCtrl.planMoveBerthNo = [data objectForKey:@"planMoveBerthNo"];
            
            unberthProcessCtrl.delegate = self;
            
            [self.navigationController pushViewController:unberthProcessCtrl animated:YES];
            
            [unberthProcessCtrl release];
        }
            break;
        case OutwardProcess:
        {
            OutwardProcessViewController *outwardProcessCtrl = [[OutwardProcessViewController alloc] init];
            
            outwardProcessCtrl.shipId = shipId;
            
            outwardProcessCtrl.planEnterPortTime = [data objectForKey:@"planInPortTime"];
            
            outwardProcessCtrl.planLeavePortTime = [data objectForKey:@"planOutPortTime"];
            
            outwardProcessCtrl.delegate = self;
            
            [self.navigationController pushViewController:outwardProcessCtrl animated:YES];
            
            [outwardProcessCtrl release];
        }
            
            break;
    }
    
    if ([m_businessType.type integerValue] ==BerthingProcess)
    {
        return;
    }
}

- (void)clickBtn:(NSString *)bcNo andSerial:(NSString *)serial andAuditState:(BOOL)auditState
{
    [MBProgressHUD showHUDAddedTo:m_levelTwoTable.view animated:YES];
    
    if (m_levelTwoTable.withShip) {
        
        if (auditState) {
            [BusinessNetRequest executeAsynchronous:@selector(requestForAuditShipJob)
                                           callback:@selector(auditShipCallBack:error:) backTarget:self args:bcNo,serial,nil];
        }
        else {
            [BusinessNetRequest executeAsynchronous:@selector(requestForUndoAuditShipJob)
                                           callback:@selector(auditShipCallBack:error:) backTarget:self args:bcNo,serial,nil];
        }
        
    }
    else {
        
        if (auditState) {
            [BusinessNetRequest executeAsynchronous:@selector(requestForAuditNonShipJob)
                                           callback:@selector(auditShipCallBack:error:) backTarget:self args:bcNo,serial,nil];
        }
        else {
            [BusinessNetRequest executeAsynchronous:@selector(requestForUnAuditNonShipJob)
                                           callback:@selector(auditShipCallBack:error:) backTarget:self args:bcNo,serial,nil];
        }
    }
}

- (void) auditShipCallBack : (ASIHTTPRequest *)request error: (NSError *)error
{
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
                [MBProgressHUD hideHUDForView:m_levelTwoTable.view animated:YES];
                
                BOOL auditState = [[request.userInfo objectForKey:@"auditState"] boolValue];
                
                NSString *resultMsg = nil;
                
                if (auditState) {
                    resultMsg = @"审核成功";
                }else {
                    resultMsg = @"撤销审核成功";
                }
                
                [self showAlert:resultMsg withMsg:nil];
                
                NSString *bcno = [request.userInfo objectForKey:@"bcno"];
                
                [m_levelTwoTable refreshTableData : bcno];
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"船只信息获取失败，请检查网络或者重新操作。"];
    
    return;
    
    
}

- (void)refreshTable
{
    
}

- (void) showAlert : (NSString *)title withMsg: (NSString *)message
{
    AlertView *alert=[[AlertView alloc] initWithTitle:title andMessage:message];
    
    [alert addToView:self.view];

    [alert release];
}

- (void) dealloc
{
    [m_levelTwoView release];
    
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
