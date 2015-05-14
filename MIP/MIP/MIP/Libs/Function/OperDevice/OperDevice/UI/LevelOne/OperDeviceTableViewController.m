//
//  OperDeviceTableViewController.m
//  OperDevice
//
//  Created by lu_sicong on 2014/04/25.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "OperDeviceTableViewController.h"
#import "OperDeviceTableViewCell.h"
#import "OperDeviceMenuInfo.h"
#import "OperDeviceNetRequest.h"
#import "MBProgressHUD.h"
#import "OperDeviceDataParser.h"

#define TableFrameWidth         ([UIScreen mainScreen].bounds.size.width)
#define TableFrameHeight        ([UIScreen mainScreen].bounds.size.height - 20 - 50)

#define TableCellHeight         50

#define TableFrame              CGRectMake(0, 0, TableFrameWidth - 70, TableFrameHeight)

@interface OperDeviceTableViewController () < NSFetchedResultsControllerDelegate>
{
    //coreData数据查询控制器,负责保存新闻中心栏目列表数据及控制
    NSFetchedResultsController      *_fetchedResultsController;
    
    MBProgressHUD                   *_HUD;
}

@end

@implementation OperDeviceTableViewController

@synthesize m_delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    _fetchedResultsController = [OperDeviceMenuInfo sharedFetchedResultsController];
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

    [self requestUrl];
}

- (void)requestUrl{
    
    if (_HUD)
        return;
    
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.parentViewController.view bringSubviewToFront:_HUD];
    
    [OperDeviceNetRequest executeAsynchronous:@selector(getOperDeviceUrl) callback:@selector(callbackGetUrl:error:) backTarget:self args:@"",nil];
}

- (void)callbackGetUrl:(NSData *)data error:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _HUD = nil;
    
    NSData *bodyData = [OperDeviceNetRequest extractDataBodyFromResponsePackage:data];
    
    [OperDeviceDataParser parserOperDeviceList:bodyData];
}

- (void)dealloc
{
    [OperDeviceMenuInfo releaseFetchedResultsController];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    
    OperDeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[OperDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
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
    
    OperDeviceMenuInfo *operDeviceMenu = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = operDeviceMenu.menuName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OperDeviceMenuInfo *operDeviceMenu = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(selectedOperDeviceUrl:withTitle:)]) {
        [m_delegate selectedOperDeviceUrl:operDeviceMenu.url withTitle:operDeviceMenu.menuName];
    }
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
