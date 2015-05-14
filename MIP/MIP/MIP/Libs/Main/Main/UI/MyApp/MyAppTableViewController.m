//
//  MyAppTableViewController.m
//  Main
//
//  Created by mengxianglei on 14-4-15.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "MyAppTableViewController.h"
#import "AppTypeCell.h"
#import "MyAppCenterNetRequest.h"
#import "MBProgressHUD.h"
#import "MyAppDataParser.h"
#import "ApplicationType.h"

@interface MyAppTableViewController () <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController   *_fetchedResultsController;
    
    ApplicationType              *m_appType;
}

@end

@implementation MyAppTableViewController
@synthesize m_appList;
@synthesize _categoryDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*!
 @function
 @abstract      系统生命周期方法,当控制器需要绑定视图时,该方法将被系统调用
 @note          由于未使用xib,因此该方法在视图控制器中必须实现,在tableViewController中self.tableView与self.view未同一视图且自动创建,因此此处只是设置tableView的视图大小
 @result        无
 */
-(void)loadView{
    
    [super loadView];
    
    self.tableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableView.rowHeight = 50;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
#endif
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [MyAppCenterNetRequest executeAsynchronous:@selector(requestForAppTypeList) callback:@selector(callBackGetAppTypeList:error:) backTarget:self args:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSString *) getCurTime
{
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"] ;
    return [dateFormat stringFromDate:[NSDate date]];
}

-(void)callBackGetAppTypeList:(NSData *)data error:(NSError*)error
{
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
                
                NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ApplicationType class]) inManagedObjectContext:context];
                NSFetchRequest *request=[[NSFetchRequest alloc] init];
                [request setEntity:entityDescription];
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appType == %@",@"0"];
                
                [request setPredicate:predicate];
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (m_appType) {
                    [m_appType release];
                }
                
                m_appType = [[results firstObject] retain];
                
                if (m_appType) {
                    
                    [MyAppCenterNetRequest executeAsynchronous:@selector(requestForAppList) callback:@selector(callBackGetAppList:error:) backTarget:self args:m_appType.appType, pageSize, [self getCurTime], nil];
                    
                }
                
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
                
                _fetchedResultsController = [ApplicationInfor fetchedResultsController];
                
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
                
                self.m_appList = [NSMutableArray arrayWithArray:_fetchedResultsController.fetchedObjects];
                
                [self.m_appList addObject:@"添加应用"];
                
                DLog(@"%lu",(unsigned long)[self.m_appList count]);
                
                [self.tableView reloadData];
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
    return self.m_appList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    static NSString *CellIdentifier = @"Cell";
    AppTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[AppTypeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selectBG.png" imageBundle:mainBundle]];
    cell.selectedBackgroundView = selectedBackgroundView;
    [selectedBackgroundView release];
    
    UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png" imageBundle:mainBundle]];
    accessoryView.frame = CGRectMake(0, 0, 10, 13);
    cell.accessoryView = accessoryView;
    [accessoryView release];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    
    cell.textLabel.textColor = [UIColor grayColor];
    
    if (self.m_appList.count - 1 > indexPath.row) {
    
        ApplicationInfor *appInfo = [self.m_appList objectAtIndex:indexPath.row];
        
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appInfo.iconUrl]]];
        cell.textLabel.text = appInfo.appName;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"app_icon_add.png" imageBundle:myAppCenterBundle];
        cell.textLabel.text = @"添加应用";
    }
    
    return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_categoryDelegate respondsToSelector:@selector(didSelectedApp:)]) {
        [_categoryDelegate didSelectedApp:[self.m_appList objectAtIndex:indexPath.row]];
    }
}

@end
