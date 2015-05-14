//
//  ComLevelTwoTableViewController.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/26.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ComLevelTwoTableViewController.h"
#import "ContactsDataParser.h"
#import "ComContactsInfo.h"
#import "ContactsNetRequest.h"
#import "MBProgressHUD.h"
#import "ComContactsDepartCell.h"
#import "ComContactsDetailInfoCell.h"
#import "InsetTextField.h"

#define TableFrameWidth         ([UIScreen mainScreen].bounds.size.width)
#define TableFrameHeight        ([UIScreen mainScreen].bounds.size.height - 20 - 50 - 45)

#define ComLevelTwoFrame        CGRectMake(0, 0, TableFrameWidth, TableFrameHeight)

#define TitleBgViewFrame        CGRectMake(0, 0, TableFrameWidth, 53.5)
#define TitleBgViewImage        [UIImage imageNamed:@"title.png" imageBundle:contactsBundle]

#define BackButtonFrame         CGRectMake(5, 5, 60, 39.5)
#define BackButtonBgImage       [UIImage imageNamed:@"t_back.png" imageBundle:contactsBundle]

#define TitleTextFrame          CGRectMake(65, 0, 190, 50)
#define TitleTextColor          [UIColor whiteColor]
#define TitleTextFont           [UIFont boldSystemFontOfSize:22]

#define SearchBarTextImage      [UIImage imageNamed:@"search_bg.png" imageBundle:contactsBundle]
#define SearchBarTextFrame      CGRectMake(0, 50, 320, 45)
#define SearchBarTextFont       [UIFont boldSystemFontOfSize:15]

#define SearchResultViewFrame   CGRectMake(0, 50, 320, 45)
#define SearchResultBgColor     [UIColor colorWithRed:117/255.0 green:144/255.0 blue:173/255.0 alpha:1.0]
#define SearchResultTextFrame   CGRectMake(70, 0, 240, 45)
#define SearchResultBtnBgImage  [UIImage imageNamed:@"button_q.png" imageBundle:contactsBundle]
#define SearchResultBtnFrame    CGRectMake(240, 10, 60, 25)
#define SearchResultTextFont    [UIFont systemFontOfSize:12]
#define SearchResultTextColor   [UIColor colorWithHex:@"3c557f"]

@interface ComLevelTwoTableViewController () < UITextFieldDelegate>
{
    NSFetchRequest  *fetchRequest;
    
    NSArray *m_contactsDataList;
    
    NSIndexPath *m_selectedIndex;
    
    NSMutableArray *m_searchDataList;
    
    NSString *m_strDepartmentSort;
    
    NSString *m_strKey;
    
    NSString *m_strSubKey;
    
    MBProgressHUD *_HUD;
}

@end

@implementation ComLevelTwoTableViewController

@synthesize strCompanyName = m_strCompanyName, strSubKey = m_strSubKey;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.tableView.frame = ComLevelTwoFrame;
        
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
    
}

- (void)dealloc
{
    if (m_strKey) {
        [m_strKey release];
    }
    
    if (m_strSubKey) {
        [m_strSubKey release];
    }
    
    [fetchRequest release];
    
    fetchRequest = nil;
    
    [m_contactsDataList release];
    
    _HUD = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshContactsDetailList
{
    
    if (m_searchDataList) {
        
        NSPredicate *predicate = nil;
        
        if (m_strDepartmentName) {
            if (m_strSubKey) {
                
                NSString *sKey = [NSString stringWithFormat:@"*%@*", m_strSubKey];
                
                predicate = [NSPredicate predicateWithFormat:@"company = %@ && department like %@ && (duties = \"\" || department = %@)", m_strCompanyName, sKey, m_strDepartmentName];
                
            }else {
                predicate = [NSPredicate predicateWithFormat:@"company = %@ && department <> \"\" && (duties = \"\" || department = %@)", m_strCompanyName, m_strDepartmentName];
            }
        }
        else {
            
            if (m_strSubKey) {
                
                NSString *sKey = [NSString stringWithFormat:@"*%@*", m_strSubKey];
                
                predicate = [NSPredicate predicateWithFormat:@"company = %@ && department like %@ && duties = \"\"", m_strCompanyName, sKey, (m_strKey ? m_strKey : @"")];
                
            }else {
                predicate = [NSPredicate predicateWithFormat:@"company = %@ && department <> \"\" && duties = \"\"", m_strCompanyName, (m_strKey ? m_strKey : @"")];
            }
        }
        
        if (m_contactsDataList) {
            [m_contactsDataList release];
            m_contactsDataList = nil;
        }
        
        m_contactsDataList = [[m_searchDataList filteredArrayUsingPredicate:predicate] retain];
        
        return;
    }
    
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    if (!fetchRequest) {
        
        fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([ComContactsInfo class]) inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"num" ascending:YES];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [sortDescriptor release];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        [sortDescriptors release];
        
    }
    
    if (m_strDepartmentName) {
        NSPredicate *predicate = nil;
        
        if (m_strSubKey) {
            
            NSString *sKey = [NSString stringWithFormat:@"*%@*", m_strSubKey];
            
            predicate = [NSPredicate predicateWithFormat:@"company = %@ && department like %@ && (duties = \"\" || department = %@)", m_strCompanyName, sKey, m_strDepartmentName];
            
        }else {
            predicate = [NSPredicate predicateWithFormat:@"company = %@ && department <> \"\" && (duties = \"\" || department = %@)", m_strCompanyName, m_strDepartmentName];
        }
        
        [fetchRequest setPredicate:predicate];
    }
    else {
       
        NSPredicate *predicate = nil;
        
        if (m_strSubKey) {
            
            NSString *sKey = [NSString stringWithFormat:@"*%@*", m_strSubKey];
            
            predicate = [NSPredicate predicateWithFormat:@"company = %@ && department like %@ && duties = \"\"", m_strCompanyName, sKey];
            
        }else {
            predicate = [NSPredicate predicateWithFormat:@"company = %@ && department <> \"\" && duties = \"\"", m_strCompanyName];
        }
        
        [fetchRequest setPredicate:predicate];
    }
    
    
    NSError *error = nil;
    
    if (m_contactsDataList) {
        [m_contactsDataList release];
        m_contactsDataList = nil;
    }
    
    m_contactsDataList = [[context executeFetchRequest:fetchRequest error:&error] retain];

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
    return [m_contactsDataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([m_contactsDataList count] <= indexPath.row) {
        return 0;
    }
    
    ComContactsInfo *comInfo = [m_contactsDataList objectAtIndex:indexPath.row];
    
    if ([comInfo.duties length] > 0) {
        return TableSubCellHeight;
    }
    
    return TableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ComContactsInfoCell";
    static NSString *SubCellIdentifier = @"ComContactsInfoSubCell";
    
    if ([m_contactsDataList count] <= indexPath.row) {
        return nil;
    }
    
    ComContactsInfo *comInfo = [m_contactsDataList objectAtIndex:indexPath.row];
    
    if ([comInfo.duties length] > 0) {
        ComContactsDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:SubCellIdentifier];
        
        if (!cell) {
            cell = [[[ComContactsDetailInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SubCellIdentifier] autorelease];
        }
        
        ComContactsInfo *comInfo = [m_contactsDataList objectAtIndex:indexPath.row];
        
        cell.title = comInfo.duties;
        
        cell.tel = comInfo.tel;
        
        return cell;
        
    }else {
        
        ComContactsDepartCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[ComContactsDepartCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
        
        ComContactsInfo *comInfo = [m_contactsDataList objectAtIndex:indexPath.row];
        
        cell.isSelected = (m_strDepartmentName && [m_strDepartmentName isEqualToString: comInfo.department]);
        cell.title = comInfo.department;
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComContactsInfo *comInfo = [m_contactsDataList objectAtIndex:indexPath.row];
    
    if (![m_strDepartmentName isEqualToString:comInfo.department] && [comInfo.duties isEqualToString:@""]) {
        m_strDepartmentName = comInfo.department;
        m_strDepartmentSort = comInfo.num;
        m_selectedIndex = [indexPath retain];
    }else if ([comInfo.duties isEqualToString:@""]){
        m_strDepartmentName = nil;
        m_strDepartmentSort = @"";
        m_selectedIndex = nil;
    }else{
        return;
    }
    
    [self refreshContactsDetailList];
    
    [self.tableView reloadData];
    
    if (!m_strDepartmentName || m_searchDataList) {
        return;
    }
    
    if (!_HUD) {
        _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    [ContactsNetRequest executeAsynchronous:@selector(requestForGroupContacts)
                                   callback:@selector(groupDetailContactsCallback:error:) backTarget:self args:m_strCompanyName, m_strDepartmentName, @"", @"", nil];
}


- (void) setStrCompanyName:(NSString *)strCompanyName
{
    [self setStrCompanyNameWithOutRequest:strCompanyName];
    
    if (strCompanyName && strCompanyName.length > 0) {
        
        if (!_HUD) {
            _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
        
        [ContactsNetRequest executeAsynchronous:@selector(requestForGroupContacts) callback:@selector(groupDetailContactsCallback:error:) backTarget:self args:m_strCompanyName, @"", @"", @"", nil];
    }

}

- (void) setStrCompanyNameWithOutRequest:(NSString *)strCompanyName
{
    if (strCompanyName && strCompanyName.length > 0) {
        
        m_strCompanyName = strCompanyName;
        
        m_lblTableTitle.text = m_strCompanyName;
        
        m_strDepartmentName = nil;
        
        m_strDepartmentSort = @"";
        
        m_searchDataList = nil;
        
        [m_strKey release];
        
        m_strKey = nil;
        
        [m_selectedIndex release];
        
        m_selectedIndex = nil;
        
        [self refreshContactsDetailList];
        
        [self.tableView reloadData];
    }
    
}

- (void) setSearchResult : (NSMutableArray *)resultList
             withCompany : (NSString *) strCompanyName
                  andKey : (NSString *) sKey
{
    m_strCompanyName = strCompanyName;
    
    if (strCompanyName && strCompanyName.length > 0) {
        
        m_lblTableTitle.text = m_strCompanyName;
    }
    else {
        
        m_lblTableTitle.text = @"公司部门";
    }
    
    m_strDepartmentName = nil;
    
    m_strDepartmentSort = @"";
    
    m_searchDataList = resultList;
    
    m_strKey = [sKey retain];
    
    NSPredicate *tmpPre = [NSPredicate predicateWithFormat:@"tel = %@", m_strKey];
    NSArray *tmpArray = [m_searchDataList filteredArrayUsingPredicate:tmpPre];
    if (tmpArray.count > 0) {
        ComContactsInfo *tmpInfo = [tmpArray firstObject];
        m_strDepartmentName = tmpInfo.department;
        m_strDepartmentSort = tmpInfo.num;
    }
    
    [self refreshContactsDetailList];
    
    [self.tableView reloadData];
}

- (void) groupDetailContactsCallback : (NSData *)data error: (NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _HUD = nil;
    
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
                [ContactsDataParser parseComContactsList:bodyData withSort:m_strDepartmentSort];

                [self refreshContactsDetailList];
                
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


- (void)setStrSubKey:(NSString *)strSubKey
{
    m_strSubKey = [strSubKey retain];
    
    [self refreshContactsDetailList];
    [self.tableView reloadData];
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
