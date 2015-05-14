//
//  LCLevelOneTableViewController.m
//  LCHarbour
//
//  Created by kangqijun on 14-3-25.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "LCLevelOneTableViewController.h"
#import "LCNetRequest.h"
#import "MBProgressHUD.h"
#import "LowCPortDataParser.h"
#import "LowCPortMenuInfo.h"
#import "LowCLevelOneCell.h"

#define TableFrameWidth         ([UIScreen mainScreen].bounds.size.width)
#define TableFrameHeight        ([UIScreen mainScreen].bounds.size.height - 20 - 50)

#define TableCellHeight         50

#define TableFrame              CGRectMake(0, 0, TableFrameWidth - 70, TableFrameHeight)

@interface LCLevelOneTableViewController () < NSFetchedResultsControllerDelegate>
{
    //coreData数据查询控制器,负责保存新闻中心栏目列表数据及控制
    NSFetchedResultsController      *_fetchedResultsController;
}

@end

@implementation LCLevelOneTableViewController

@synthesize m_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.tableView.frame = TableFrame;
        
#ifdef __IPHONE_7_0
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
        {
            self.tableView.separatorInset = UIEdgeInsetsZero;
        }
#endif
        
        self.tableView.rowHeight = TableCellHeight;
        self.tableView.backgroundColor = [UIColor whiteColor];
        
        self.tableView.allowsMultipleSelection = NO;
        
        self.tableView.bounces = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _customRefreshControl.headerView.frame = CGRectMake(0.0f, -170.0f, TableFrameWidth, 170.0f);
    CGRect rect = _customRefreshControl.headerLastUpdatedLabel.frame;
    rect = CGRectMake((TableFrameWidth-rect.size.width)/2, rect.origin.y, rect.size.width, rect.size.height);
    _customRefreshControl.headerLastUpdatedLabel.frame = rect;
    rect = _customRefreshControl.headerStatusLabel.frame;
    rect = CGRectMake((TableFrameWidth-rect.size.width)/2, rect.origin.y, rect.size.width, rect.size.height);
    
    _customRefreshControl.headerStatusLabel.frame = rect;
    rect = _customRefreshControl.headerActivityView.frame;
    
    _customRefreshControl.headerActivityView.frame = CGRectMake(50, rect.origin.y, rect.size.width, rect.size.height);
    rect = _customRefreshControl.headerArrowImage.frame;
    
    _customRefreshControl.headerArrowImage.frame = CGRectMake(50, rect.origin.y, rect.size.width, rect.size.height);
    _fetchedResultsController = [LowCPortMenuInfo sharedFetchedResultsController];
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    
    if (_fetchedResultsController && ![_fetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    if (isValid([Userinfo shareUserinfo].token))
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [LCNetRequest executeAsynchronous:@selector(getEngSuperviseList) callback:@selector(callbackGetEngSuperviseListRequest:error:) backTarget:self args:[Userinfo shareUserinfo].token,@"",nil];
    }
}

- (void)callbackGetEngSuperviseListRequest:(NSData *)data error:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSData *bodyData = [LCNetRequest extractDataBodyFromResponsePackage:data];
    
    if (isValid(bodyData))
    {
        [LowCPortDataParser parserEngSuperviseList:bodyData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_fetchedResultsController sections].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCellIdentifier";
    
    LowCLevelOneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[LowCLevelOneCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.imageView.image = [UIImage imageNamed:@"list_icon.png" imageBundle:newsCenterBundle];
        
        UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selectBG.png" imageBundle:mainBundle]];
        cell.selectedBackgroundView = selectedBackgroundView;
        [selectedBackgroundView release];
        
        UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png" imageBundle:mainBundle]];
        accessoryView.frame = CGRectMake(0, 0, 10, 13);
        cell.accessoryView = accessoryView;
        [accessoryView release];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    
    LowCPortMenuInfo *lowCPortMenu = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = lowCPortMenu.menuName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LowCPortMenuInfo *lowCPortMenu = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(selectedLowCPortUrl:withTitle:)]) {
        [m_delegate selectedLowCPortUrl:lowCPortMenu.url withTitle:lowCPortMenu.menuName];
    }
}

- (void)dealloc
{
    [LowCPortMenuInfo releaseFetchedResultsController];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
    
    [self.tableView flashScrollIndicators];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

@end
