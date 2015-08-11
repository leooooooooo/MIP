//
//  BusinessProcessLevelTwoTableViewController.m
//  BusinessProcess
//
//  Created by wanghao on 14-3-12.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessLevelTwoCell.h"
#import "BusinessNetRequest.h"
#import "BusinessType.h"
#import "MBProgressHUD.h"
#import "BusinessDataParser.h"
#import "BusinessProcessButton.h"
#import "BusinessDefine.h"
#import "ShipInfo.h"
#import "LargeCommission.h"
#import "BusinessProcessLevelTwoTableViewController.h"
#import "AlertView.h"

#define TableFrameWidth                 self.view.frame.size.width
#define TableFrameHeight                self.view.frame.size.height

#define TableWidth                      (TableFrameWidth > TableFrameHeight ? TableFrameWidth : TableFrameHeight)
#define TableHeight                     (TableFrameWidth > TableFrameHeight ? TableFrameHeight : TableFrameWidth)

#define TableCellFrameHeight            CellHeight

#define TabelTitleBorderColor           [UIColor colorWithRed:214/255.0 green:217/255.0 blue:219/255.0 alpha:1.0]

#define TabelTitleTextColor             [UIColor colorWithRed:57/255.0 green:78/255.0 blue:102/255.0 alpha:1.0]
#define TabelTitleTextFont              [UIFont boldSystemFontOfSize:14]

#define ResizeableCellWidth             (SCREEN_HEIGHT == 480 ? 0 : 88)

#define LargeCommissionNoShipNames      [NSArray arrayWithObjects:@"作业公司",@"船代",@"申请时间",@"批准",@"审核", nil]
#define LargeCommissionNoShipWidths     (SCREEN_HEIGHT == 480 ? [NSArray arrayWithObjects:@"120",@"120",@"100",@"39",@"80", nil] : [NSArray arrayWithObjects:@"142",@"142",@"122",@"61",@"80", nil])

#define LargeCommissionWithShipNames    [NSArray arrayWithObjects:@"船名",@"航次",@"作业公司",@"船代",@"申请时间",@"批准",@"审核", nil]
#define LargeCommissionWithShipWidths   (SCREEN_HEIGHT == 480 ? [NSArray arrayWithObjects:@"70",@"50",@"70",@"90",@"90",@"29", @"60", nil] : [NSArray arrayWithObjects:@"92",@"50",@"92",@"112",@"112",@"29", @"60", nil])

#define BusinessProcessLabelWidths      [NSArray arrayWithObjects:@"70",@"140",@"70",@"35",@"35",@"109", nil]
#define LargeBusinessProcessLabelWidths [NSArray arrayWithObjects:@"90",@"160",@"90",@"49",@"49",@"109", nil]

#define BerthingProcessLabelNames       [NSArray arrayWithObjects:@"中文船名",@"抵锚时间",@"船代",@"引水",@"计划",@"靠泊", nil]
#define BerthingProcessLabelWidths      (SCREEN_HEIGHT == 480 ? BusinessProcessLabelWidths : LargeBusinessProcessLabelWidths)

#define JobProcessLabelNames            [NSArray arrayWithObjects:@"中文船名",@"抵锚时间",@"船代",@"引水",@"计划",@"作业", nil]
#define JobProcessLabelWidths           (SCREEN_HEIGHT == 480 ? BusinessProcessLabelWidths : LargeBusinessProcessLabelWidths)

#define UnberthingProcessLabelNames     [NSArray arrayWithObjects:@"中文船名",@"抵锚时间",@"船代",@"引水",@"计划",@"移泊", nil]
#define UnberthingProcessLabelWidths    (SCREEN_HEIGHT == 480 ? BusinessProcessLabelWidths : LargeBusinessProcessLabelWidths)

#define OutwardProcessLabelNames        [NSArray arrayWithObjects:@"中文船名",@"抵锚时间",@"船代",@"引水",@"计划",@"离港", nil]
#define OutwardProcessLabelWidths       (SCREEN_HEIGHT == 480 ? BusinessProcessLabelWidths : LargeBusinessProcessLabelWidths)



@interface BusinessProcessLevelTwoTableViewController () <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_fetchCtrl;
    
    BusinessType *m_processType;
    
    NSArray     *m_businessProcessLevelTwoLabelWidths;
    
    NSArray     *m_businessProcessLevelTwoLabelNameList;
    
    NSDictionary *m_searchDic;
    
    BOOL        withShip;
    
    NSDate      *checkDate;
}

@end

@implementation BusinessProcessLevelTwoTableViewController

@synthesize processType = m_processType, withShip, delegate = m_delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.tableView.frame = CGRectMake(0, 0, TableFrameWidth, TableFrameHeight);
        self.tableView.rowHeight = TableCellFrameHeight;
        
        self.tableView.allowsSelection = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.userInteractionEnabled = YES;

//        self.tableView.bounces = NO;
        
#ifdef __IPHONE_7_0
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
        {
            self.tableView.separatorInset = UIEdgeInsetsZero;
        }
#endif
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isAllowAutoFooterLoading = YES;
    
    _customRefreshControl.headerView.frame = CGRectMake(0.0f, -80.0f, TableFrameWidth, 80.0f);
    _customRefreshControl.headerView.backgroundColor = [UIColor clearColor];
    
    CGRect rect = _customRefreshControl.headerLastUpdatedLabel.frame;
    
    rect = CGRectMake((TableFrameWidth-rect.size.width)/2, rect.origin.y - 90, rect.size.width, rect.size.height);
    
    _customRefreshControl.headerLastUpdatedLabel.frame = rect;
    
    rect = _customRefreshControl.headerStatusLabel.frame;
    
    rect = CGRectMake((TableFrameWidth-rect.size.width)/2, rect.origin.y - 90, rect.size.width, rect.size.height);
    
    _customRefreshControl.headerStatusLabel.frame = rect;
    
    rect = _customRefreshControl.headerActivityView.frame;
    
    _customRefreshControl.headerActivityView.frame = CGRectMake(100, rect.origin.y - 90, rect.size.width, rect.size.height);
    
    rect = _customRefreshControl.headerArrowImage.frame;
    
    _customRefreshControl.headerArrowImage.frame = CGRectMake(100, rect.origin.y - 90, rect.size.width, rect.size.height);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    withShip = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    [m_businessProcessLevelTwoLabelWidths release];
    [m_businessProcessLevelTwoLabelNameList release];
    
    _fetchCtrl = nil;
    
    [LargeCommission releaseFetchedResultsController];
    
    [ShipInfo releaseFetchedResultsController];
    
    [super dealloc];
}

- (void) largeCommCallback : (ASIHTTPRequest *)request error: (NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    //下拉更新结束后，调用，用于scrollView复位
    [self doneLoadingHeaderTableViewData];
    [self doneLoadingAutoFooterTableViewData];
    
    NSNumber *processType = [request.userInfo objectForKey:@"processType"];
    
    if (![processType isEqualToNumber:m_processType.type]) {
        return;
    }
    
    NSLog(@"%@",[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding]);
    
    if (isValid(request.responseData))
    {
        //获取body中的数据
        NSData *bodyData = [BusinessNetRequest extractDataBodyFromResponsePackage:request.responseData];
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            //NSString *msg=[bodyDictionary objectForKey:@"retMsg"];
            if (0 == [ret intValue])
            {
                [BusinessDataParser parseLargeCommList:bodyData withShip:withShip];
                
                if (_fetchCtrl) {
                    [_fetchCtrl.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"withship = %hhd && createDate > %@", withShip, checkDate]];
                    
                    NSError *error = nil;
                    if (![_fetchCtrl performFetch:&error]) {
                        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
                        abort();
                    }
                    
                    if ([_fetchCtrl.fetchedObjects count] == 0) {
                        
                        [self showAlert:@"未检索到符合条件的数据!" withMsg:nil];
                    }
                }
                
                [self.tableView reloadData];
                
                return;
            }
        }
    }
    [self showAlert:@"业务委托信息获取失败!" withMsg:nil];
    
    return;
}

- (void) shipInfoCallback : (ASIHTTPRequest *)request error: (NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    //下拉更新结束后，调用，用于scrollView复位
    [self doneLoadingHeaderTableViewData];
    [self doneLoadingAutoFooterTableViewData];
    
    NSNumber *processType = [request.userInfo objectForKey:@"processType"];
    
    if (![processType isEqualToNumber:m_processType.type]) {
        return;
    }
    
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
                [BusinessDataParser parseShipInfoList:bodyData withType:m_processType];
                
                if (_fetchCtrl) {
                    [_fetchCtrl.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"processType.type = %d", [m_processType.type integerValue]]];
                    
                    NSError *error = nil;
                    if (![_fetchCtrl performFetch:&error]) {
                        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
                        abort();
                    }
                    
                    if ([_fetchCtrl.fetchedObjects count] == 0) {
//                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未检索到符合条件的数据。"
//                                                                            message:nil
//                                                                           delegate:nil
//                                                                  cancelButtonTitle:nil
//                                                                  otherButtonTitles:@"确定", nil];
//                        [alertView show];
//                        [alertView release];
                        [self showAlert:@"未检索到符合条件的数据。" withMsg:nil];
                    }
                    
                    
                }
                
                [self.tableView reloadData];
                
                return;
            }
        }
    }
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"船只信息获取失败，请检查网络或者重新操作。"
//                                                       delegate:nil
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:@"确定", nil];
//    [alertView show];
//    [alertView release];
    
    [self showAlert:@"船只信息获取失败，请检查网络或者重新操作!" withMsg:nil];
    
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setProcessType:(BusinessType *)processType
{
//    if (m_processType && (m_processType.type != processType.type)) {
//        self.tableView.numberOfSections = 0;
//        [self.tableView reloadData];
//    }
    
    m_processType = processType;
    
    if (m_businessProcessLevelTwoLabelWidths || m_businessProcessLevelTwoLabelNameList) {
        [m_businessProcessLevelTwoLabelWidths release];
        m_businessProcessLevelTwoLabelWidths = nil;
        [m_businessProcessLevelTwoLabelNameList release];
        m_businessProcessLevelTwoLabelNameList = nil;
    }
    
    switch ([processType.type integerValue]) {
        case BusinessLargeCommission:
        {
            if (withShip) {
                m_businessProcessLevelTwoLabelWidths = [LargeCommissionWithShipWidths retain];
                m_businessProcessLevelTwoLabelNameList = [LargeCommissionWithShipNames retain];
            }else {
                m_businessProcessLevelTwoLabelWidths = [LargeCommissionNoShipWidths retain];
                m_businessProcessLevelTwoLabelNameList = [LargeCommissionNoShipNames retain];
            }
        }
            break;
        case BerthingProcess:
        {
            m_businessProcessLevelTwoLabelWidths = [BerthingProcessLabelWidths retain];
            m_businessProcessLevelTwoLabelNameList = [BerthingProcessLabelNames retain];
        }
            break;
        case JobProcess:
        {
            m_businessProcessLevelTwoLabelWidths = [JobProcessLabelWidths retain];
            m_businessProcessLevelTwoLabelNameList = [JobProcessLabelNames retain];
        }
            
            break;
        case UnberthingProcess:
        {
            m_businessProcessLevelTwoLabelWidths = [UnberthingProcessLabelWidths retain];
            m_businessProcessLevelTwoLabelNameList = [UnberthingProcessLabelNames retain];
        }
            break;
        case OutwardProcess:
        {
            m_businessProcessLevelTwoLabelWidths = [OutwardProcessLabelWidths retain];
            m_businessProcessLevelTwoLabelNameList = [OutwardProcessLabelNames retain];
        }
            break;
    }
    
    [self clearTable];
    
    if ([processType.type integerValue] == BusinessLargeCommission) {
        
        [LargeCommission sharedFetchedResultsController].delegate = self;
        
        [[LargeCommission sharedFetchedResultsController].fetchRequest setFetchBatchSize:20];
        
        return;
        
    }else {
        _fetchCtrl = [ShipInfo sharedFetchedResultsController];
        
        _fetchCtrl.delegate = self;
        
        NSPredicate *predicate = nil;
        
        if (checkDate) {
            [checkDate release];
        }
        
        checkDate = [[NSDate date] retain];
        
        predicate = [NSPredicate predicateWithFormat:@"processType.type = %d && createDate > %@", [m_processType.type integerValue], checkDate];
        
        [_fetchCtrl.fetchRequest setPredicate:predicate];
        
        [_fetchCtrl.fetchRequest setFetchBatchSize:20];
        
        NSError *error = nil;
        
        if (_fetchCtrl && ![_fetchCtrl performFetch:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [self.tableView reloadData];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormat stringFromDate:checkDate];
        
        [self refreshTableWithDate : strDate];
    }

}

- (void)setWithShip:(BOOL)withship
{
    withShip = withship;
    
    if (m_businessProcessLevelTwoLabelWidths || m_businessProcessLevelTwoLabelNameList) {
        [m_businessProcessLevelTwoLabelWidths release];
        m_businessProcessLevelTwoLabelWidths = nil;
        [m_businessProcessLevelTwoLabelNameList release];
        m_businessProcessLevelTwoLabelNameList = nil;
    }
    
    if (withShip) {
        m_businessProcessLevelTwoLabelWidths = [LargeCommissionWithShipWidths retain];
        m_businessProcessLevelTwoLabelNameList = [LargeCommissionWithShipNames retain];
    }else {
        m_businessProcessLevelTwoLabelWidths = [LargeCommissionNoShipWidths retain];
        m_businessProcessLevelTwoLabelNameList = [LargeCommissionNoShipNames retain];
    }
    
    [self clearTable];
}

- (void) clearTable
{
    _fetchCtrl = nil;
    
    [self.tableView reloadData];
}

- (void) refreshTableData : (NSString *)bcno
{
    NSFetchedResultsController *tmpFetchCtrl = [LargeCommission sharedFetchedResultsController];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([LargeCommission class]) inManagedObjectContext:tmpFetchCtrl.managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"bcno = %@",bcno]];

    NSArray *results = [tmpFetchCtrl.managedObjectContext executeFetchRequest:request error:NULL];
    
    if ([results count] > 0) {
        LargeCommission *largeComm = [results firstObject];
        
        largeComm.createDate = [NSDate date];
        
        largeComm.withship = [NSNumber numberWithBool:![largeComm.withship boolValue]];
        
        [tmpFetchCtrl.managedObjectContext save:NULL];
    }
    
    [_fetchCtrl performFetch:NULL];
    [self.tableView reloadData];
}

- (void)search:(NSDictionary *)dic
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (m_searchDic) {
        [m_searchDic release];
    }
    
    m_searchDic = [dic retain];
    
    if (checkDate) {
        [checkDate release];
    }
    
    checkDate = [[NSDate date] retain];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"withship = %hhd && createDate > %@", withShip, checkDate];
    
    _fetchCtrl = [LargeCommission sharedFetchedResultsController];
    
    [_fetchCtrl.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    if (_fetchCtrl && ![_fetchCtrl performFetch:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormat stringFromDate:checkDate];
    
    if (withShip) {
        [BusinessNetRequest executeAsynchronous:@selector(requestForLargeCommissionWithShipInfoList) callback:@selector(largeCommCallback:error:) backTarget:self args: [m_searchDic objectForKey:@"beginDate"] ,[m_searchDic objectForKey:@"endDate"],[m_searchDic objectForKey:@"shipName"],[m_searchDic objectForKey:@"voyage"],[m_searchDic objectForKey:@"jobCompanyId"],[m_searchDic objectForKey:@"auditMark"],strDate,m_processType.type, nil];
    }else {
        [BusinessNetRequest executeAsynchronous:@selector(requestForLargeCommissionWithNonShipInfoList) callback:@selector(largeCommCallback:error:) backTarget:self args: [m_searchDic objectForKey:@"beginDate"] ,[m_searchDic objectForKey:@"endDate"],[m_searchDic objectForKey:@"jobCompanyId"],[m_searchDic objectForKey:@"auditMark"],strDate,m_processType.type, nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_fetchCtrl.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[_fetchCtrl.sections objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ShipCellIdentifier = @"ShipInfoCell";
    static NSString *LargeCommWithShipInfoCellIdentifier = @"LargeCommWithShipInfoCell";
    static NSString *LargeCommWithOutShipInfoCellIdentifier = @"LargeCommWithOutShipInfoCell";
    
    NSString *identifier = nil;
    
    if ([m_processType.type integerValue] == BusinessLargeCommission) {
        
        if (withShip) {
            identifier = LargeCommWithShipInfoCellIdentifier;
        }else {
            identifier = LargeCommWithOutShipInfoCellIdentifier;
        }
        
    }else {
        identifier = ShipCellIdentifier;
    }
    
    BusinessLevelTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[[BusinessLevelTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        
        [cell setFrameWithWidthList:m_businessProcessLevelTwoLabelWidths];
    }
    
    NSArray *textList = nil;
    
    if ([m_processType.type integerValue] == BusinessLargeCommission) {
        LargeCommission *tmpShipInfo = [_fetchCtrl objectAtIndexPath:indexPath];
        
        if (withShip) {
            textList = [NSArray arrayWithObjects:tmpShipInfo.shipname, tmpShipInfo.voyage, tmpShipInfo.jobcompanyname, tmpShipInfo.shipclientname, tmpShipInfo.applydate, tmpShipInfo.auditmarkname, nil];
        }else {
            textList = [NSArray arrayWithObjects:tmpShipInfo.jobcompanyname, tmpShipInfo.shipclientname, tmpShipInfo.applydate, tmpShipInfo.auditmarkname, nil];
        }
        
    }else {
        ShipInfo *tmpShipInfo = [_fetchCtrl objectAtIndexPath:indexPath];
        
        textList = [NSArray arrayWithObjects:tmpShipInfo.shipnamecn, tmpShipInfo.arriveanchortime, tmpShipInfo.shipclientname, tmpShipInfo.leadmarkname, tmpShipInfo.planmarkname, nil];
        
    }
    
    [cell addText:textList];
    
    [cell.customBtnView addSubview:[self getTableCellButtonViewWithIndexPath:indexPath]];
    
    return cell;
}

- (void) shipInfoTableBtnClick : (id)sender
{
    UIButton *tmpBtn = (UIButton *)sender;
    NSInteger row = floor(tmpBtn.tag / 10);
    
    if ([m_processType.type integerValue] == BusinessLargeCommission) {
        
        LargeCommission *tmpCommInfo = [_fetchCtrl objectAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        
        if (m_delegate && [m_delegate respondsToSelector:@selector(clickBtn:withShipId:andDataDic:)]) {
            [m_delegate clickBtn:tmpCommInfo.bcno andSerial:tmpCommInfo.serial andAuditState:![tmpCommInfo.auditmarkname isEqualToString:@"Y"]];
        }
        
        return;
    }
    
    ShipInfo *tmpShipInfo = [_fetchCtrl objectAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    switch ([m_processType.type integerValue]) {
        case BerthingProcess:
        {
            if (tmpShipInfo.planinporttime) {
                [dic setObject:tmpShipInfo.planinporttime forKey:@"planInPortTime"];
            }
            if (tmpShipInfo.planoutporttime) {
                [dic setObject:tmpShipInfo.planoutporttime forKey:@"planOutPortTime"];
            }
        }
            break;
        case JobProcess:
        {
            
        }
            break;
        case UnberthingProcess:
        {
            if (tmpShipInfo.planmoveberthtime) {
                [dic setObject:tmpShipInfo.planmoveberthtime forKey:@"planMoveBerthTime"];
            }
            if (tmpShipInfo.planmoveberthno) {
                [dic setObject:tmpShipInfo.planmoveberthno forKey:@"planMoveBerthNo"];
            }
        }
            break;
        case OutwardProcess:
        {
            if (tmpShipInfo.planinporttime) {
                [dic setObject:tmpShipInfo.planinporttime forKey:@"planInPortTime"];
            }
            if (tmpShipInfo.planoutporttime) {
                [dic setObject:tmpShipInfo.planoutporttime forKey:@"planOutPortTime"];
            }
        }
            break;
    }
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(clickBtn:withShipId:andDataDic:)]) {
        [m_delegate clickBtn:(tmpBtn.tag % 10) withShipId:tmpShipInfo.shipid andDataDic:dic];
    }
    
    [dic release];
}

- (UIView *) getTableCellButtonViewWithIndexPath : (NSIndexPath *)indexPath
{
    UIView *buttonView = nil;
    
    if ([m_processType.type integerValue] != BusinessLargeCommission) {
        buttonView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 185, TableCellFrameHeight)] autorelease];
        buttonView.backgroundColor = [UIColor clearColor];
        
        BusinessProcessButton *detailBtn = [BusinessProcessButton buttonWithTitle:@"明细"];
        [detailBtn setFrame: CGRectMake(6, 3, 47, 16)];
        detailBtn.tag = indexPath.row * 10;
        [detailBtn addTarget:self action:@selector(shipInfoTableBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:detailBtn];
        
        BusinessProcessButton *processBtn = [BusinessProcessButton buttonWithTitle:@"处理"];
        [processBtn setFrame: CGRectMake(58, 3, 47, 16)];
        processBtn.tag = indexPath.row * 10 + 1;
        [processBtn addTarget:self action:@selector(shipInfoTableBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:processBtn];
        
    } else{
        buttonView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, TableCellFrameHeight)] autorelease];
        buttonView.backgroundColor = [UIColor clearColor];
        
        NSString *btnTitle = nil;
        LargeCommission *tmpLargeComm = [_fetchCtrl objectAtIndexPath:indexPath];
        if ([tmpLargeComm.auditmarkname isEqualToString:@"Y"]) {
            btnTitle = @"销审";
        }else {
            btnTitle = @"审核";
        }
        
        BusinessProcessButton *detailBtn = [BusinessProcessButton buttonWithTitle:btnTitle];
        float x = (withShip ? 8 : 17);
        [detailBtn setFrame: CGRectMake(x, 3, 47, 16)];
        detailBtn.tag = indexPath.row * 10;
        [detailBtn addTarget:self action:@selector(shipInfoTableBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:detailBtn];
    }
    
    return buttonView;
}

- (UIView *) getTableTitle
{
    UIView *titleView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, TableWidth, TableCellFrameHeight)] autorelease];
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_b.png" imageBundle:businessProcessBundle]];
    bgView.frame = CGRectMake(0, 0, TableWidth, TableCellFrameHeight);
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [TabelTitleBorderColor CGColor];
    
    [titleView addSubview:bgView];
    [bgView release];
    
    if (m_businessProcessLevelTwoLabelWidths) {
        
        CGFloat originX = 0;
        
        for (NSString *strLabelName in m_businessProcessLevelTwoLabelNameList) {
            
            CGFloat labelWidth = [[m_businessProcessLevelTwoLabelWidths objectAtIndex:[m_businessProcessLevelTwoLabelNameList indexOfObject:strLabelName]] floatValue];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originX, 0, labelWidth + 1, TableCellFrameHeight)];
            label.textColor = TabelTitleTextColor;
            label.backgroundColor = [UIColor clearColor];
            label.font = TabelTitleTextFont;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = strLabelName;
            label.layer.borderWidth = 1;
            label.layer.borderColor = [TabelTitleBorderColor CGColor];
            
            [titleView addSubview:label];
            [label release];
            
            originX += labelWidth;
        }
    }
    
    return titleView;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if ([m_processType.type integerValue] == BusinessLargeCommission) {
        return;
    }
    
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if ([m_processType.type integerValue] == BusinessLargeCommission) {
        return;
    }
    
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    if ([m_processType.type integerValue] == BusinessLargeCommission) {
        return;
    }
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)refreshTableHeaderDidTriggerRefresh:(CustomRefreshControl *)view
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormat stringFromDate:[NSDate date]];
    
    [self refreshTableWithDate : dateStr];
}

- (void)refreshTableFooterDidTriggerRefresh:(CustomRefreshControl *)view
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if (checkDate) {
        [checkDate release];
        checkDate = nil;
    }
    
    checkDate = [NSDate date];
    
    NSString *dateStr = [dateFormat stringFromDate:checkDate];
    
    [self refreshTableWithDate : dateStr];
}

- (void)autoFooterLoading
{
    id lastObject = nil;
    
    if ([_fetchCtrl.fetchedObjects count] > _fetchCtrl.fetchRequest.fetchBatchSize)
    {
        lastObject = [_fetchCtrl.fetchedObjects objectAtIndex:_fetchCtrl.fetchRequest.fetchBatchSize - 1];
    } else {
        lastObject = [_fetchCtrl.fetchedObjects lastObject];
    }
    
    NSString *dateStr = nil;
    
    if ([m_processType.type integerValue] == BusinessLargeCommission) {
        LargeCommission *lastLargeComm = lastObject;
        dateStr = lastLargeComm.applydate;
    }else {
        ShipInfo *lastShipInfo = lastObject;
        dateStr = lastShipInfo.arriveanchortime;
    }
    
    _fetchCtrl.fetchRequest.fetchBatchSize += 20;
    
    [self refreshTableWithDate : dateStr];
}

- (void) refreshTableWithDate : (NSString *) dateStr
{
    if (!m_searchDic && [m_processType.type integerValue] == BusinessLargeCommission) {
        //下拉更新结束后，调用，用于scrollView复位
        [self doneLoadingHeaderTableViewData];
        [self doneLoadingAutoFooterTableViewData];
        return;
    }
    
    switch ([m_processType.type integerValue]) {
        case BusinessLargeCommission:
        {
            if (withShip) {
                [BusinessNetRequest executeAsynchronous:@selector(requestForLargeCommissionWithShipInfoList) callback:@selector(largeCommCallback:error:) backTarget:self args: [m_searchDic objectForKey:@"beginDate"] ,[m_searchDic objectForKey:@"endDate"],[m_searchDic objectForKey:@"shipName"],[m_searchDic objectForKey:@"voyage"],[m_searchDic objectForKey:@"jobCompanyId"],[m_searchDic objectForKey:@"auditMark"],dateStr,m_processType.type, nil];
            }else {
                [BusinessNetRequest executeAsynchronous:@selector(requestForLargeCommissionWithNonShipInfoList) callback:@selector(largeCommCallback:error:) backTarget:self args: [m_searchDic objectForKey:@"beginDate"] ,[m_searchDic objectForKey:@"endDate"],[m_searchDic objectForKey:@"jobCompanyId"],[m_searchDic objectForKey:@"auditMark"],dateStr,m_processType.type, nil];
            }
        }
            break;
        case BerthingProcess:
        {
            [BusinessNetRequest executeAsynchronous:@selector(requestForBerthingProcessInfoList) callback:@selector(shipInfoCallback:error:) backTarget:self args:dateStr,m_processType.type,nil];
        }
            break;
        case JobProcess:
        {
            [BusinessNetRequest executeAsynchronous:@selector(requestForJobProcessInfoList) callback:@selector(shipInfoCallback:error:) backTarget:self args:dateStr,m_processType.type,nil];
        }
            break;
        case UnberthingProcess:
        {
            [BusinessNetRequest executeAsynchronous:@selector(requestForUnberthingProcessInfoList) callback:@selector(shipInfoCallback:error:) backTarget:self args:dateStr,m_processType.type,nil];
        }
            break;
        case OutwardProcess:
        {
            [BusinessNetRequest executeAsynchronous:@selector(requestForOutwardProcessInfoList) callback:@selector(shipInfoCallback:error:) backTarget:self args:dateStr,m_processType.type,nil];
        }
            break;
    }
}

- (void) showAlert : (NSString *)title withMsg: (NSString *)message
{
    AlertView *alert=[[AlertView alloc] initWithTitle:title andMessage:message];
    
    [alert addToView:self.view];
    
    [alert release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
