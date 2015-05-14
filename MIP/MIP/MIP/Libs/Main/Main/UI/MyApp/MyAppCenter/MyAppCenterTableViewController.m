//
//  MyAppCenterTableViewController.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/12.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "MyAppCenterTableViewController.h"
#import "AppTypeCell.h"
#import "MyAppCenterNetRequest.h"
#import "MBProgressHUD.h"
#import "MyAppDataParser.h"


@interface MyAppCenterTableViewController ()
{
    NSFetchedResultsController      *_fetchedResultsController;
    
    NSIndexPath *selectedPath;
    
    int         curRow;
}

@property (assign, nonatomic) int         curRow;

@end

@implementation MyAppCenterTableViewController

@synthesize m_delegate;

@synthesize curRow;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _fetchedResultsController = [ApplicationType fetchedResultsController];
    
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
    
//    [self.tableView selectRowAtIndexPath:selectedPath animated:NO
//                          scrollPosition:UITableViewScrollPositionNone];
    
    self.curRow = 0;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [MyAppCenterNetRequest executeAsynchronous:@selector(requestForAppTypeList) callback:@selector(callBackGetAppTypeList:error:) backTarget:self args:nil];
}

-(void)callBackGetAppTypeList:(NSData *)data error:(NSError*)error
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
                [MyAppDataParser parseAppTypeList:bodyData];
                
                [self.tableView reloadData];
                
//                selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
//                
//                [self.tableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//
//                if (m_delegate && [m_delegate respondsToSelector:@selector(didSelectedAppType:)]) {
//                    ApplicationType *appliType = [_fetchedResultsController objectAtIndexPath:selectedPath];
//                    [m_delegate didSelectedAppType: appliType];
//                }
                
                return;
            }
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"应用分类信息获取失败，请检查网络或者重新操作。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
    
    return;
    
}

-(void)loadView{
    
    [super loadView];
    
    self.tableView.frame = CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT - 70);
    self.tableView.rowHeight = 50;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.bounces = YES;
    
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
#endif
    
    selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"_fetchedResultsController.sections is %lu", (unsigned long)[[_fetchedResultsController.sections objectAtIndex:section] numberOfObjects]);
    return [[_fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_fetchedResultsController.sections count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FoldawayCell";
    
    AppTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[AppTypeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (_fetchedResultsController.fetchedObjects.count > indexPath.row) {
        
        ApplicationType *appliType = [_fetchedResultsController objectAtIndexPath:indexPath];
        
        cell.imageView.image = [UIImage imageNamed:@"list_icon.png" imageBundle:newsCenterBundle];
        
        UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selectBG.png" imageBundle:mainBundle]];
        cell.selectedBackgroundView = selectedBackgroundView;
        [selectedBackgroundView release];
        
        UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png" imageBundle:mainBundle]];
        accessoryView.frame = CGRectMake(0, 0, 10, 13);
        cell.accessoryView = accessoryView;
        [accessoryView release];

        cell.textLabel.text = appliType.appTypeName;
        cell.appCountLabel.text = appliType.appNum;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.curRow = (int)[indexPath row];
    
    AppTypeCell *cell = (AppTypeCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [cell setSelected:YES animated:YES];
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(didSelectedAppType:)]) {
        ApplicationType *appliType = [_fetchedResultsController objectAtIndexPath:indexPath];
        [m_delegate didSelectedAppType: appliType];
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    
    if (!selectedPath) {
        selectedPath = [self.tableView indexPathForSelectedRow];
    }
    
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
    
    [self.tableView flashScrollIndicators];
    
    if (self.curRow >= 0)
    {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.curRow inSection:0] animated:NO
                              scrollPosition:UITableViewScrollPositionNone];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
