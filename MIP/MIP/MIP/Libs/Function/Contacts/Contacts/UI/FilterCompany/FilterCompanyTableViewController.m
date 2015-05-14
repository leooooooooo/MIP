//
//  FilterCompanyTableViewController.m
//  Contacts
//
//  Created by mengxianglei on 2014/05/14.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import "FilterCompanyTableViewController.h"
#import "ContactsNetRequest.h"
#import "MBProgressHUD.h"
#import "ContactsDataParser.h"
#import "FullCompanyCell.h"
#import "FullCompanyInfo.h"
#import "ComLevelTwoTableViewController.h"
#import "ComLevelTwoViewController.h"

#define TableFrameWidth         ([UIScreen mainScreen].bounds.size.width)
#define TableFrameHeight        ([UIScreen mainScreen].bounds.size.height - 20 - 50 - 45)

#define ComLevelOneFrame        CGRectMake(0, 0, TableFrameWidth, TableFrameHeight)

@interface FilterCompanyTableViewController () <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_fetchedResultsController;

    ComLevelTwoViewController *m_subLevelCtrl;
}

@end

@implementation FilterCompanyTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.tableView.frame = ComLevelOneFrame;
        
#ifdef __IPHONE_7_0
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
        {
            self.tableView.separatorInset = UIEdgeInsetsZero;
        }
#endif
        self.tableView.rowHeight = TableCellHeight;
        self.tableView.backgroundColor = BackGroundColor;
        
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
    
    _fetchedResultsController = [FullCompanyInfo sharedFetchedResultsController];
    
    _fetchedResultsController.delegate = self;
    
    [_fetchedResultsController.fetchRequest setPredicate:nil];
    
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
    
    [ContactsNetRequest executeAsynchronous:@selector(requestForFullCompany) callback:@selector(fullCompanyCallback:error:) backTarget:self args:nil];
}

- (void)dealloc
{
    if (m_lblTableTitle) {
        [m_lblTableTitle release];
        m_lblTableTitle = nil;
    }
    
    _fetchedResultsController = nil;
    
    [FullCompanyInfo releaseFetchedResultsController];
    
    if (m_strKey) {
        [m_strKey release];
        m_strKey = nil;
    }
    
    [m_subLevelCtrl release];
    
    [super dealloc];
}

- (void) fullCompanyCallback : (NSData *)data error: (NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [ContactsNetRequest extractDataBodyFromResponsePackage:data];
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            
            if (0 == [ret intValue])
            {
                [ContactsDataParser parseFullCompanyList:bodyData];
                
                if (_fetchedResultsController) {
                    [_fetchedResultsController.fetchRequest setPredicate:nil];
                    
                    NSError *error = nil;
                    if (![_fetchedResultsController performFetch:&error]) {
                        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
                        abort();
                    }
                }
                
                [self.tableView reloadData];

                return;
            }
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"企业通讯录信息获取失败，请检查网络或者重新操作。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
    
    return;
}

- (void) searchByKey : (NSString *) sKey
{
    if (_fetchedResultsController) {
        
        if (sKey) {
            
            sKey = [NSString stringWithFormat:@"*%@*", sKey];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"companyname like %@ ", sKey];
            [_fetchedResultsController.fetchRequest setPredicate:predicate];
            
        }else {
            
            [_fetchedResultsController.fetchRequest setPredicate:nil];
            
        }
        
        NSError *error = nil;
        
        if (![_fetchedResultsController performFetch:&error]) {
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_fetchedResultsController.fetchedObjects count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FullCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[FullCompanyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    FullCompanyInfo *comInfo = [_fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    
    cell.title = comInfo.companyname;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FullCompanyInfo *comInfo = [_fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshContractsForCom" object:comInfo];
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
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
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
