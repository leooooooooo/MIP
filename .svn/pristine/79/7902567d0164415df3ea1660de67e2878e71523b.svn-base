//
//  PopListTableViewController.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/09.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "PopListTableViewController.h"

#define RowHeight       30
#define MaxRowCount     5

#define BorderLineColor [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0]

#define TextColor       [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1.0]

@interface PopListTableViewController ()
{
    NSArray *m_dataArr;
    
    CGRect  m_tableFrame;
    
    NSInteger m_maxRowCount;
}

@end

@implementation PopListTableViewController

@synthesize dataArr = m_dataArr, tableFrame = m_tableFrame;

@synthesize maxRowCount = m_maxRowCount;

@synthesize delegate = m_delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        m_maxRowCount = MaxRowCount;
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
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.bounces = NO;
    self.tableView.rowHeight = RowHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [BorderLineColor CGColor];
    self.tableView.separatorColor = BorderLineColor;
    
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
#endif
}

- (void)setDataArr:(NSArray *)dataArr
{
    m_dataArr = dataArr;
    
    [self resetTableFrame];
}

- (void)setMaxRowCount:(NSInteger)maxRowCount
{
    m_maxRowCount = maxRowCount;
    if (m_maxRowCount == 0) {
        m_maxRowCount = MaxRowCount;
    }
    
    [self resetTableFrame];
}

- (void) resetTableFrame
{
    CGFloat tableHeight = 0.0;
    if ([m_dataArr count] > m_maxRowCount) {
        tableHeight = m_maxRowCount * RowHeight;
    }else {
        tableHeight = [m_dataArr count] * RowHeight;
    }
    
    CGRect frame = self.tableView.frame;
    frame.size.height = tableHeight;
    self.tableView.frame = frame;
}

- (void)setTableFrame:(CGRect)tableFrame
{
    if (self.tableView.frame.size.height > 0) {
        tableFrame.size.height = self.tableView.frame.size.height;
    }else {
        tableFrame.size.height = RowHeight;
    }
    
    m_tableFrame = tableFrame;
    
    self.tableView.frame = tableFrame;
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
    return [m_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [m_dataArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = TextColor;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.minimumScaleFactor = 10;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(selectedWithIndex:)]) {
        [m_delegate selectedWithIndex:indexPath.row];
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
