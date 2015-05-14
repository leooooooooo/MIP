//
//  SignListTableViewController.m
//  Main
//
//  Created by lu_sicong on 2014/03/17.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "SignListTableViewController.h"
#import "SignHistoryInfo.h"

#define TableWidth              self.tableView.frame.size.width
#define TableHeight             self.tableView.frame.size.height
#define TableFrame              CGRectMake(0, 0, TableWidth, TableHeight)

#define TableRowHeight          45
#define TableHeaderHeight       98


#define TableHeaderBackFrame    CGRectMake(0, -200, TableWidth, 200)

#define TableHeaderFrame        CGRectMake(0, 0, TableWidth, TableHeaderHeight)
#define TableHeaderClockImage   [UIImage imageNamed:@"sign_time.png" imageBundle:mainBundle]
#define TableHeaderClockFrame   CGRectMake(45, 48, 25.5, 25.5)
#define TableHeaderTitleFrame   CGRectMake(10, 16, 150, 20)
#define TableHeaderCurDateFrame CGRectMake(80, 54, 150, 17)
#define TableHeaderTextColor    [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0]
#define TableHeaderTextFont     [UIFont boldSystemFontOfSize:18]
#define TableHeaderCurDateColor [UIColor colorWithRed:87/255.0 green:107/255.0 blue:130/255.0 alpha:1.0]
#define TableHeaderCurDateFont  [UIFont systemFontOfSize:18]
#define TableHeaderLineImage    [UIImage imageNamed:@"sign_line.png" imageBundle:mainBundle]
#define TableHeaderLineFrame    CGRectMake(57, TableHeaderHeight - 25, 1.5, 25)

#define TableBgColor            [UIColor colorWithRed:244/255.0 green:249/255.0 blue:255/255.0 alpha:1.0]
#define TableBgLineFrame        CGRectMake(57, TableHeaderHeight, 1.5, TableHeight - TableHeaderHeight)

#define CellClockLineImage      [UIImage imageNamed:@"sign_time_d.png" imageBundle:mainBundle]
#define CellClockLineFrame      CGRectMake(51.5, 16.5, 13, 12.5)
#define CellLineFrame           CGRectMake(57, 0, 1.5, TableRowHeight)
#define CellTextBackImage       [UIImage imageNamed:@"sign_t.png" imageBundle:mainBundle]
#define CellTextBackFrame       CGRectMake(74, 5, 238, 37.5)

#define CellTimeFrame           CGRectMake(10, 0, 35, TableRowHeight)
#define CellTimeColor           [UIColor colorWithRed:138/255.0 green:159/255.0 blue:185/255.0 alpha:1.0]
#define CellTimeFont            [UIFont systemFontOfSize:11]
#define CellCurPlaceFrame       CGRectMake(90, 0, 205, TableRowHeight)
#define CellCurPlaceColor       [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0]
#define CellCurPlaceFont        [UIFont boldSystemFontOfSize:12]

#define SelectedCellTextColor   [UIColor colorWithRed:85/255.0 green:160/255.0 blue:254/255.0 alpha:1.0]

#define HeaderTimeFormat        @"yyyy-MM-dd"
#define SignTimeFormat          @"yyyy-MM-dd HH:mm:ss"
#define CellTimeFormat          @"HH:mm"

@interface SignListTableViewController ()

@end

@implementation SignListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 105 - 60 - 20);
        self.tableView.backgroundColor = TableBgColor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.allowsSelection = NO;
        
        self.tableView.rowHeight = TableRowHeight;
        
        UIView *headerBackGround = [[UIView alloc] initWithFrame:TableHeaderBackFrame];
        headerBackGround.backgroundColor = TableBgColor;
        [self.tableView addSubview:headerBackGround];
        [headerBackGround release];
        
        //
        UIView *tableHeader = [[UIView alloc] initWithFrame:TableHeaderFrame];
        tableHeader.backgroundColor = TableBgColor;
        
        UILabel *tableHeaderTitle = [[UILabel alloc] initWithFrame:TableHeaderTitleFrame];
        [tableHeaderTitle setBackgroundColor:[UIColor clearColor]];
        tableHeaderTitle.textColor = TableHeaderTextColor;
        tableHeaderTitle.textAlignment = UITextAlignmentLeft;
        tableHeaderTitle.font = TableHeaderTextFont;
        tableHeaderTitle.text = @"我的签到记录";
        [tableHeader addSubview:tableHeaderTitle];
        [tableHeaderTitle release];
        
        UILabel *curDateTitle = [[UILabel alloc] initWithFrame:TableHeaderCurDateFrame];
        [curDateTitle setBackgroundColor:[UIColor clearColor]];
        curDateTitle.textColor = TableHeaderCurDateColor;
        curDateTitle.textAlignment = UITextAlignmentLeft;
        curDateTitle.font = TableHeaderCurDateFont;
        curDateTitle.text = [self getCurDate];
        [tableHeader addSubview:curDateTitle];
        [curDateTitle release];
        
        UIImageView *clockIcon = [[UIImageView alloc] initWithImage:TableHeaderClockImage];
        clockIcon.frame = TableHeaderClockFrame;
        [tableHeader addSubview:clockIcon];
        [clockIcon release];
        
        UIImageView *clockLine = [[UIImageView alloc] initWithImage:TableHeaderLineImage];
        clockLine.frame = TableHeaderLineFrame;
        [tableHeader addSubview:clockLine];
        [clockLine release];
        
        self.tableView.tableHeaderView = tableHeader;
        [tableHeader release];
        
        UIView *bgView = [[UIView alloc] initWithFrame:TableFrame];
        
        UIImageView *bgLine = [[UIImageView alloc] initWithImage:TableHeaderLineImage];
        bgLine.frame = TableBgLineFrame;
        [bgView addSubview:bgLine];
        [bgLine release];
        
        self.tableView.backgroundView = bgView;
        
        [bgView release];
        
        [SignHistoryInfo signFetchedResultsController].delegate = self;
        
        NSError *error = nil;
        
        if ([SignHistoryInfo signFetchedResultsController] &&
            ![[SignHistoryInfo signFetchedResultsController] performFetch:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
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

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取当前日期的字符串
- (NSString *) getCurDate
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:HeaderTimeFormat];
    NSString *tmpDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return tmpDateStr;
}

#pragma mark - Table view data source
//table行数与记录条数绑定
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[SignHistoryInfo signFetchedResultsController].sections objectAtIndex:section] numberOfObjects];
}

//table组数与记录组数绑定（为1）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[SignHistoryInfo signFetchedResultsController].sections count];
}

//从数据生成TableCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *signListCellIdentifier = @"SignListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:signListCellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:signListCellIdentifier] autorelease];
        
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        UIImageView *lineImage = [[UIImageView alloc] initWithImage:TableHeaderLineImage];
        lineImage.frame = CellLineFrame;
        [backView addSubview:lineImage];
        [lineImage release];
        UIImageView *clockLineImage = [[UIImageView alloc] initWithImage:CellClockLineImage];
        clockLineImage.frame = CellClockLineFrame;
        [backView addSubview:clockLineImage];
        [clockLineImage release];
        UIImageView *textBackImage = [[UIImageView alloc] initWithImage:CellTextBackImage];
        textBackImage.frame = CellTextBackFrame;
        [backView addSubview:textBackImage];
        [textBackImage release];
        
        cell.backgroundView = backView;
        
        [backView release];
        
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CellTimeFrame];
        timeLab.font = CellTimeFont;
        timeLab.tag = 250;
        timeLab.backgroundColor = [UIColor clearColor];
        [cell addSubview:timeLab];
        
        [timeLab release];
        
        UILabel *placeLab = [[UILabel alloc] initWithFrame:CellCurPlaceFrame];
        placeLab.numberOfLines=0;
        placeLab.font = CellCurPlaceFont;
        placeLab.tag = 1000;
        placeLab.backgroundColor = [UIColor clearColor];
        [cell addSubview:placeLab];
        
        [placeLab release];
        
        cell.backgroundColor = [UIColor clearColor];
    }
    
    SignHistoryInfo *signInfo = [[SignHistoryInfo signFetchedResultsController] objectAtIndexPath:indexPath];
    
    UILabel *rTimeLab = (UILabel *)[cell viewWithTag:250];
    rTimeLab.text = [self getSignTimeFormat:signInfo.signTime];
    rTimeLab.textColor = (indexPath.row == 0)? SelectedCellTextColor : CellTimeColor;
    
    UILabel *rPlaceLab = (UILabel *)[cell viewWithTag:1000];
    rPlaceLab.text = signInfo.location;
    rPlaceLab.textColor = (indexPath.row == 0)? SelectedCellTextColor : CellCurPlaceColor;
    
    
    return cell;
}

//把数据中获取的签到时间进行格式化
- (NSString *) getSignTimeFormat:(NSString *)signTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:SignTimeFormat];
    NSDate *signTimeDate = [dateFormatter dateFromString:signTime];
    [dateFormatter setDateFormat:CellTimeFormat];
    NSString *tmpSignTimeStr = [dateFormatter stringFromDate:signTimeDate];
    [dateFormatter release];
    return tmpSignTimeStr;
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
