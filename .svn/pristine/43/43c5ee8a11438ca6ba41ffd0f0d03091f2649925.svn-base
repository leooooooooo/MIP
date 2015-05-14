//
//  BusinessProcessLevelOneTableViewController.m
//  BusinessProcess
//
//  Created by wanghao on 14-3-12.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessProcessLevelOneTableViewController.h"
#import "BusinessType.h"
#import "BusinessDataParser.h"
#import "BusinessLevelOneCell.h"
#import "BusinessNetRequest.h"
#import "MBProgressHUD.h"

@interface BusinessProcessLevelOneTableViewController ()
{
    NSFetchedResultsController *_fetchedCtrl;
}

@end

@implementation BusinessProcessLevelOneTableViewController

@synthesize delegate = m_delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        
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
    
    _fetchedCtrl = [BusinessType sharedFetchedResultsController];
    
    _fetchedCtrl.delegate = self;
    
    NSError *error = nil;
    
    if (_fetchedCtrl &&
        ![_fetchedCtrl performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    if (_fetchedCtrl && [_fetchedCtrl.fetchedObjects count] == 0)
    {
        [BusinessDataParser parseBusinessTypeList:nil];
        if (![_fetchedCtrl performFetch:&error]) {
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)dealloc
{
    _fetchedCtrl = nil;
    
    [BusinessType releaseFetchedResultsController];
    
    [super dealloc];
}

-(void)loadView{
    
    [super loadView];
    
    self.tableView.frame = CGRectMake(0, 50, SCREEN_WIDTH - 70, SCREEN_HEIGHT);
    self.tableView.rowHeight = 50;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.bounces = NO;
    
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
#endif
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
    return [_fetchedCtrl.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[_fetchedCtrl.sections objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *businessTypeCellIdentifier = @"BusinessTypeCell";
    BusinessLevelOneCell *cell = [tableView dequeueReusableCellWithIdentifier:businessTypeCellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[[BusinessLevelOneCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:businessTypeCellIdentifier] autorelease];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"list_icon.png" imageBundle:newsCenterBundle];
    
    UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selectBG.png" imageBundle:mainBundle]];
    cell.selectedBackgroundView = selectedBackgroundView;
    [selectedBackgroundView release];
    
    UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png" imageBundle:mainBundle]];
    accessoryView.frame = CGRectMake(0, 0, 10, 13);
    cell.accessoryView = accessoryView;
    [accessoryView release];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];

    BusinessType *tmpType = [_fetchedCtrl objectAtIndexPath:indexPath];
    
    cell.textLabel.text = tmpType.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessType *selectedType = [_fetchedCtrl objectAtIndexPath:indexPath];
    
    if ([selectedType.type integerValue] == 0) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"lygais://"]]) {
            // 如果能打开应用，直接打开之
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"lygais://"]];
        }else {
            // 如果不能打开，说明应用没有安装，跳转到AppStore
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/lian-yun-gang-gangais/id830262378?mt=8"]];
        }
        return;
    }
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(selectBusinessType:)]) {
        [m_delegate selectBusinessType: selectedType];
    }
    
}

- (void) setUnionId : (NSString *)unionId
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BusinessNetRequest executeAsynchronous:@selector(requestForNextModuleList) callback:@selector(moduleListCallback:error:) backTarget:self args:unionId, nil];
}

- (void) moduleListCallback : (NSData *)data error: (NSError *)error
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
                [BusinessDataParser parseBusinessTypeList:bodyData];
                
                if (![_fetchedCtrl performFetch:&error]) {
                    DLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
                
                [self.tableView reloadData];
                
                return;
            }
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"列表信息获取失败，请检查网络或者重新操作。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
    
    return;
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
