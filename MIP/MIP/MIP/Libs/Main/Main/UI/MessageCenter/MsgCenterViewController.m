//
//  MyDesktopViewController.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/13.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "MsgCenterViewController.h"
#import "MessageClassInfo.h"
#import "MainNetRequest.h"
#import "MainDataParser.h"
#import "OfficialCheckViewController.h"
#import "ApplicationInfor.h"
#import "NewsCenterCategory.h"
#import "NewsCenterLevelTwoViewController.h"

#define kCloudHome              @"云之家"
@interface MsgCenterViewController () <NSFetchedResultsControllerDelegate,CustomRefreshControlDelegate>
{
    NSFetchedResultsController   *_fetchedResultsController;
    
    BOOL    autoRefresh;
}

@end

@implementation MsgCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)tabViewDidAppear
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [MainNetRequest executeAsynchronous:@selector(getMessageList) callback:@selector(callbackMessageInfo:error:) backTarget:self args:nil];
    
    autoRefresh = NO;
}

- (void)loadView
{
    [super loadView];
    
    _fetchedResultsController = [MessageClassInfo sharedFetchedResultsController];
    
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
    
    m_msgCenterView = [[MsgCenterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    m_msgCenterView.delegate = self;

    [m_msgCenterView addBaseTileButton];
    
    self.view = m_msgCenterView;
    
    [self getMessageClassList];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (autoRefresh) {
        [self refreshMsgView];
    }
}

- (void)dealloc
{
    [m_msgCenterView release];
    
    [super dealloc];
}

-(void)callbackMessageInfo:(NSData *)data error:(NSError*)error
{
    autoRefresh = YES;
    
    [m_msgCenterView doneLoadingHeaderTableViewData];
    
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    NSData *bodyData = [MainNetRequest extractDataBodyFromResponsePackage:data];
    
    [MainDataParser parseMessageClassInfo:bodyData];

    if (![_fetchedResultsController performFetch:&error]) {
        
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    [m_msgCenterView addBaseTileButton];
    [self getMessageClassList];
}

- (void)refreshMsgView
{
    //发送下拉刷新请求
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [MainNetRequest executeAsynchronous:@selector(getMessageList) callback:@selector(callbackMessageInfo:error:) backTarget:self args:nil];
}

- (void)clickMsgTileButton:(NSInteger)index
{
    switch (index) {
        case 1:     //今日待办      =>      协同办公
        case 2:     //未读邮件      =>      协同办公
        case 5:     //网上公文      =>      协同办公
        {
            [self openBusinessView];
        }
            break;
        case 6:     //集团要闻      =>      新闻中心->集团要闻
        {
            [self getNewsCategoryDataWith:@"XWXX"];
        }
            break;
        case 3:     //通知公告      =>      新闻中心->通知公告
        {
            [self getNewsCategoryDataWith:@"TZGG"];
        }
            break;
        case 7:     //云之家动态    =>      云之家
        case 8:     //我的粉丝      =>      云之家
        case 9:     //我的关注      =>      云之家
        case 10:    //我的微博      =>      云之家
        {
            NSFetchedResultsController *_tmpFetchCtrl = [ApplicationInfor fetchedResultsController];
            
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ApplicationInfor class]) inManagedObjectContext:_tmpFetchCtrl.managedObjectContext];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appName == %@",kCloudHome];
            [request setPredicate:predicate];
            
            NSArray *results = [_tmpFetchCtrl.managedObjectContext executeFetchRequest:request error:nil];
            
            ApplicationInfor *appInfo = [results firstObject];
            Userinfo *userInfo = [Userinfo shareUserinfo];
            NSString *urlStr = [NSString stringWithFormat:@"%@?token=%@",appInfo.urlType,userInfo.token];
            
            NSURL *url = [NSURL URLWithString:urlStr];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"打开云之家应用失败" message:@"未找到该应用" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
            break;
        case 4:     //RTX消息    =>      第三方
        {
            
            Userinfo *userInfo = [Userinfo shareUserinfo];
            NSString *urlStr = [NSString stringWithFormat:@"%@?token=%@",@"RTX",userInfo.token];
            
            NSURL *url = [NSURL URLWithString:urlStr];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"打开应用失败"     message:@"未找到该应用" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
            break;
        default:
            break;
    }
}

- (void) getNewsCategoryDataWith:(NSString *)code
{
    Module *module = [[Userinfo shareUserinfo] getModuleWithIdentifier:@"newsCenterModuleIdentifier"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [MainNetRequest executeAsynchronous:@selector(getNewsCenterCategory) callback:@selector(callbackRequestCategory:error:) backTarget:self args:module.unionId,@"0",code,nil];
}

-(void)callbackRequestCategory:(ASIHTTPRequest *)request error:(NSError*)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSData *bodyData = [MainNetRequest extractDataBodyFromResponsePackage:request.responseData];
    [MainDataParser parserNewsCenter:bodyData];
    
    NSFetchedResultsController *tmpFetchCtrl = [NewsCenterCategory newsCenterCategoryResultsController];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterCategory class]) inManagedObjectContext:tmpFetchCtrl.managedObjectContext];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    
    NSString *code = [request.userInfo objectForKey:@"Category"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"code == %@", code];
    [fetchRequest setPredicate:predicate];
    
    NSArray *results = [tmpFetchCtrl.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if ([results count] > 0) {

        NewsCenterCategory *tmpCategory = [results firstObject];
        NewsCenterLevelTwoViewController *newsCenterLevelTwoViewController = [[NewsCenterLevelTwoViewController alloc] initWithCategory:tmpCategory];
        
        [self.navigationController pushViewController:newsCenterLevelTwoViewController animated:YES];
        [newsCenterLevelTwoViewController release];
    }
}

- (void) openBusinessView
{
    OfficialCheckViewController *bussessView = [[OfficialCheckViewController alloc] init];
    [self.navigationController pushViewController:bussessView animated:YES];
    [bussessView release];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self getMessageClassList];
}

- (void) getMessageClassList
{
    for (id<NSFetchedResultsSectionInfo> sectionInfo in _fetchedResultsController.sections) {
        
        NSMutableArray *tmpTitleArr = [[NSMutableArray alloc] init];
        for (MessageClassInfo *msgInfo in [sectionInfo objects]) {
            if (isValid(msgInfo.title)) {
                [tmpTitleArr addObject: msgInfo.title];
            }
        }
        
        [m_msgCenterView setNewsTitle:tmpTitleArr withClassName:[sectionInfo name]];
        [tmpTitleArr release];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
