//
//  MyAppListViewController.h
//  MyAppCenter
//
//  Created by mengxianglei on 2014/04/15.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import "MyAppListViewController.h"
#import "MyAppCenterNetRequest.h"
#import "MBProgressHUD.h"
#import "MyAppDataParser.h"
#import "ApplicationCell.h"
#import "ApplicationInfor.h"
#import "ApplicationType.h"
#import "MyAppCenterHandle.h"

@interface MyAppListViewController () <AppcationListCellDelegate>
{
    NSFetchedResultsController      *_fetchedResultsController;
}

@end

@implementation MyAppListViewController
@synthesize m_tableView;
@synthesize m_appList;
@synthesize appType = m_appType;

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

-(void)callBackGetAppList:(NSData *)data error:(NSError*)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [MyAppCenterNetRequest extractDataBodyFromResponsePackage:data];
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            
            if (0 == [ret intValue])
            {
                [MyAppDataParser parseAppList:bodyData withAppType:m_appType];
                
                NSError *error = nil;
                NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                
                if ([m_appType.appType intValue] != 0)
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"applitype.appType == %@",m_appType.appType];
                    [_fetchedResultsController.fetchRequest setPredicate:predicate];
                } else {
                    [_fetchedResultsController.fetchRequest setPredicate:nil];
                }
                
                self.m_appList = [context executeFetchRequest:_fetchedResultsController.fetchRequest error:&error];
                
                DLog(@"%d",[self.m_appList count]);
                
                [m_tableView reloadData];
                return;
            }
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"应用信息获取失败，请检查网络或者重新操作。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
    
    return;
    
}

- (void)loadView
{
    [super loadView];
    
    m_appCenterView = [[MyAppCenterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    m_appCenterView.titleLable.text = @"应用下载";
    [m_appCenterView.backBtn addTarget:self action:@selector(closeAppDownload:) forControlEvents:UIControlEventTouchUpInside];
    self.view = m_appCenterView;
    
    UIImageView *textFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 45)];
    textFieldBg.image = [UIImage imageNamed:@"search_bg.png" imageBundle:newsCenterBundle];
    [self.view addSubview:textFieldBg];
    [textFieldBg release];
    
    searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 70, self.view.frame.size.width-45, 45)];
    searchTextField.placeholder = @"请输入关键字搜索";
    searchTextField.font = [UIFont systemFontOfSize:15];
    searchTextField.backgroundColor = [UIColor clearColor];
    [searchTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    searchTextField.clearButtonMode = UITextFieldViewModeNever;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.delegate = self;
    [self.view addSubview:searchTextField];
    [searchTextField release];
    
    backSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backSearchBtn.frame = CGRectMake(self.view.frame.size.width-40, 85, 15, 15);
    [backSearchBtn setBackgroundImage:[UIImage imageNamed:@"search_cancel.png" imageBundle:newsCenterBundle] forState:UIControlStateNormal];
    [backSearchBtn addTarget:self action:@selector(clearSearch)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backSearchBtn];
    
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    m_tableView.rowHeight = 70;
    m_tableView.backgroundColor = [UIColor whiteColor];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    m_tableView.allowsMultipleSelection = NO;
    m_tableView.bounces = YES;
    
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        m_tableView.separatorInset = UIEdgeInsetsZero;
    }
#endif
    [m_tableView setDataSource:(id<UITableViewDataSource>)self];
    [m_tableView setDelegate:(id<UITableViewDelegate>)self];
    [self.view addSubview:m_tableView];
}

- (void) backButtonClick
{
    [self clearSearch];
}

- (BOOL) checkSearchText
{
    [searchTextField resignFirstResponder];
    
    NSString *sKey = searchTextField.text;
    
    if (sKey && sKey.length > 0) {
        return YES;
    }
    else {
        [self showAlert:@"没有输入关键字！" andMsg:@"请输入关键字"];
        return NO;
    }
}

- (void) showAlert : (NSString *) title andMsg : (NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self
                                          cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void) clearSearch
{
    [searchTextField resignFirstResponder];
    searchTextField.text = @"";
    [self searchByKey:searchTextField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self checkSearchText]) {
        return NO;
    }
    
    [self searchByKey:textField.text];
    return YES;
}

- (void)searchByKey:(NSString *) sKey
{
    NSError *error = nil;
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    if (sKey) {
        sKey = [NSString stringWithFormat:@"*%@*", sKey];

        NSPredicate *predicate = nil;
        if ([m_appType.appType intValue] != 0)
        {
            predicate = [NSPredicate predicateWithFormat:@"applitype.appType == %@ && appName like %@",m_appType.appType,sKey];
        } else {
            predicate = [NSPredicate predicateWithFormat:@"appName like %@",sKey];
        }
        [_fetchedResultsController.fetchRequest setPredicate:predicate];
    }else {
        [_fetchedResultsController.fetchRequest setPredicate:nil];
    }
    
    self.m_appList = [context executeFetchRequest:_fetchedResultsController.fetchRequest error:&error];
    
    DLog(@"%d",[self.m_appList count]);
    
    [m_tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.m_appList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplicationCell";
    
    ApplicationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[ApplicationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (self.m_appList.count > indexPath.row) {
        
        ApplicationInfor *appInfo = [self.m_appList objectAtIndex:indexPath.row];
        
        cell.m_strAppName = appInfo.appName;
        
        NSString *createDate = [self getIssueDateFormatter:appInfo.createTime];
        cell.m_strAppPublishTime = [NSString stringWithFormat:@"%@%@", @"发布时间：", createDate];
        cell.m_strAppVersion = [NSString stringWithFormat:@"%@%@", @"版本：V ", appInfo.version];
        cell.m_appIndex = indexPath.row;
        cell.m_appIsChecked = [appInfo.isChecked boolValue];
        
        cell.m_delegate = self;
        /*
        //TODO: 没有真实数据
        NSString *iconNum = [NSString stringWithFormat:@"%d", [appInfo.sn integerValue]];
        NSString *imageName = [NSString stringWithFormat:@"app_icon_%@.png", iconNum];
        
        cell.m_imgAppIcon = [UIImage imageNamed:imageName imageBundle:myAppCenterBundle];
         */
        cell.m_imgAppIcon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appInfo.iconUrl]]];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSString *)getIssueDateFormatter:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tmpDate = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *tmpStr = [dateFormatter stringFromDate:tmpDate];
    return tmpStr;
}

- (void)setAppType:(ApplicationType *)appType
{
    m_appType = appType;
}

- (void)viewDidAppear:(BOOL)animated
{
    _fetchedResultsController = [m_appType fetchedResultsController];
    
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    
    if (_fetchedResultsController &&
        ![_fetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [MyAppCenterNetRequest executeAsynchronous:@selector(requestForAppList) callback:@selector(callBackGetAppList:error:) backTarget:self args:m_appType.appType, pageSize, [self getCurTime], nil];
}

- (NSString *) getCurTime
{
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"] ;
    return [dateFormat stringFromDate:[NSDate date]];
}

- (void)downLoadApplicationWithIndex:(NSInteger)index
{
    //收起键盘
    [searchTextField resignFirstResponder];
    
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSArray *results = [context executeFetchRequest:_fetchedResultsController.fetchRequest error:nil];
    
    ApplicationInfor *appInfo = [results objectAtIndex:index];
    
    NSURL *url = [NSURL URLWithString:appInfo.attachUrl];
    
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认" message:@"打开应用" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    
    [alertView show];
    [alertView release];

}

- (void)updateApplicationWithIndex:(NSInteger)index
{
    //收起键盘
    [searchTextField resignFirstResponder];
 //TODO
}

- (void)addApplicationWithCell:(id)cell
{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSArray *results = [context executeFetchRequest:_fetchedResultsController.fetchRequest error:nil];
    
    ApplicationCell *appCell = (ApplicationCell *)cell;
    
    ApplicationInfor *appInfo = [results objectAtIndex:appCell.m_appIndex];
    
    MyAppCenterHandle *handle = [[MyAppCenterHandle alloc] init];
    
    appCell.m_appIsChecked = !appCell.m_appIsChecked;
    
    if (![handle setAppliMyDesktopState:(appCell.m_appIsChecked) atAppId:appInfo.appId])
    {
        appCell.m_appIsChecked = !appCell.m_appIsChecked;
    }

    [handle release];
}

//返回
- (void)closeAppDownload:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
