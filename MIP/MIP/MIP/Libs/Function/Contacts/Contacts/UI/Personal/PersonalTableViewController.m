//
//  PersonalTableViewController.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "PersonalTableViewController.h"
#import "ContactsNetRequest.h"
#import "MBProgressHUD.h"
#import "ContactsDataParser.h"
#import "PersonalInfoCell.h"
#import "PerContactsInfo.h"
#import "PersonalInfoCardViewController.h"
#import "FullCompanyInfo.h"
#import "NSDictionary+CustomExtensions.h"

#define TabelTitleLineColor             [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0]

#define TabelTitleBorderColor           [UIColor colorWithRed:121/255.0 green:179/255.0 blue:247/255.0 alpha:1.0]

#define TabelTitleTextColor             [UIColor colorWithRed:57/255.0 green:78/255.0 blue:102/255.0 alpha:1.0]
#define TabelTitleTextFont              [UIFont boldSystemFontOfSize:14]

#define TableFrameWidth         ([UIScreen mainScreen].bounds.size.width)
#define TableFrameHeight        ([UIScreen mainScreen].bounds.size.height - 20 - 50 - 45)

#define SinglePersonalFrame     CGRectMake(0, 0, TableFrameWidth, TableFrameHeight)

#define DetailInfoCount         4

@interface PersonalTableViewController () <PersonalCellClickDelegate>
{
    NSFetchedResultsController *_fetchedResultsController;
    
    NSIndexPath *selectedIndex;
}

@end

@implementation PersonalTableViewController
@synthesize selectCompanyid;
@synthesize selectCompanyname;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.tableView.frame = SinglePersonalFrame;
        
#ifdef __IPHONE_7_0
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
        {
            self.tableView.separatorInset = UIEdgeInsetsZero;
        }
#endif
        
        self.tableView.rowHeight = TableCellHeight;
        self.tableView.backgroundColor = [UIColor whiteColor];
        
        self.tableView.allowsSelection = NO;
        
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
    
    _fetchedResultsController = [PerContactsInfo sharedFetchedResultsController];
    
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
    
    m_headerView = [[UIView alloc] initWithFrame:CGRectZero];
    m_headerView.backgroundColor = [UIColor whiteColor];
    m_lineView = [[UIView alloc] initWithFrame:CGRectZero];
    m_lineView.backgroundColor = TabelTitleLineColor;
    headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310, 40)];
    headerLabel.font = [UIFont systemFontOfSize:22.0f];
    headerLabel.numberOfLines = 0;
    [m_headerView addSubview:m_lineView];
    [m_headerView addSubview:headerLabel];
}

- (void)dealloc
{
    [perContactInfoArr release];
    [m_headerView release];
    [m_lineView release];
    [headerLabel release];
    
    _fetchedResultsController = nil;
    
    [PerContactsInfo releaseFetchedResultsController];
    
    [super dealloc];
}

- (void) searchByKey : (NSString *) sKey
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    selectedIndex = nil;
    
    Userinfo *userinfo = [Userinfo shareUserinfo];
    if (sKey && sKey.length > 0) {
        [ContactsNetRequest executeAsynchronous:@selector(requestForSearchContacts) callback:@selector(personalSearchContactsCallback:error:) backTarget:self args:userinfo.token, sKey, nil];
        headerHeight = 0;
    }else {
        
        NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
        [context rollback];
        [ContactsNetRequest executeAsynchronous:@selector(requestForPersonalContacts) callback:@selector(personalContactsCallback:error:) backTarget:self args:userinfo.token, selectCompanyid,nil];
    }
}

- (void) personalSearchContactsCallback : (NSData *)data error: (NSError *)error
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

                if (isValid(bodyDictionary) && !error)
                {
                    NSDictionary *bizdata = [bodyDictionary dataForKey:@"bizdata"];
                    
                    if (isValid(bizdata))
                    {
                        
                        NSArray *dataArr = [bizdata dataArrForKey:@"percontacts"];
                        [self makeSearchPerContactInfo:dataArr];
                        
                        [self.tableView reloadData];
                        [self.tableView setContentOffset:CGPointMake(0.0, 0.0) animated:NO];
                        
                        return;
                    }
                }
            }
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"个人通讯录信息获取失败，请检查网络或者重新操作。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
    
    return;
}

- (void) makeSearchPerContactInfo:(NSArray *)dataArr
{
    [perContactInfoArr removeAllObjects];
    
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([PerContactsInfo class]) inManagedObjectContext:context];
    
    NSInteger index = 0;
    
    for (NSDictionary *itemDic in dataArr)
    {
        PerContactsInfo *perContactsInfo = [[PerContactsInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
        
        NSString *name = [itemDic objectForKeyWithOutCaps:@"name"];
        NSString *tel = [itemDic objectForKeyWithOutCaps:@"tel"];
        NSString *email = [itemDic objectForKeyWithOutCaps:@"email"];
        
        perContactsInfo.name = name;
        
        NSString *companyid = [itemDic objectForKeyWithOutCaps:@"companyid"];
        if (isValid(companyid)) {
            perContactsInfo.companyid = companyid;
        }
        
        NSString *companyname = [itemDic objectForKeyWithOutCaps:@"companyname"];
        if (isValid(companyname)) {
            perContactsInfo.companyname = companyname;
        }
        
        if (isValid(tel)) {
            perContactsInfo.tel = tel;
        }
        
        if (isValid(email)) {
            perContactsInfo.email = email;
        }
        
        NSString *departmentid = [itemDic objectForKeyWithOutCaps:@"departmentid"];
        if (isValid(departmentid)) {
            perContactsInfo.departmentid = departmentid;
        }
        
        NSString *departmentname = [itemDic objectForKeyWithOutCaps:@"departmentname"];
        if (isValid(departmentname)) {
            perContactsInfo.departmentname = departmentname;
        }
        
        NSString *userid = [itemDic objectForKeyWithOutCaps:@"userid"];
        if (isValid(userid)) {
            perContactsInfo.userid = userid;
        }
        
        NSString *duty = [itemDic objectForKeyWithOutCaps:@"duty"];
        if (isValid(duty)) {
            perContactsInfo.duty = duty;
        }
        
        NSString *baktel = [itemDic objectForKeyWithOutCaps:@"baktel"];
        if (isValid(baktel)) {
            perContactsInfo.baktel = baktel;
        }
        
        NSString *officetel = [itemDic objectForKeyWithOutCaps:@"officetel"];
        if (isValid(officetel)) {
            perContactsInfo.officetel = officetel;
        }
        
        NSString *bakofficetel = [itemDic objectForKeyWithOutCaps:@"bakofficetel"];
        if (isValid(bakofficetel)) {
            perContactsInfo.bakofficetel = bakofficetel;
        }
        
        NSString *peremail = [itemDic objectForKeyWithOutCaps:@"peremail"];
        if (isValid(peremail)) {
            perContactsInfo.peremail = peremail;
        }
        
        NSString *headpicurl = [itemDic objectForKeyWithOutCaps:@"headpicurl"];
        if (isValid(headpicurl)) {
            perContactsInfo.headpicurl = headpicurl;
        }
        
        NSString *markweibo = [itemDic objectForKeyWithOutCaps:@"markweibo"];
        if (isValid(markweibo)) {
            perContactsInfo.markweibo = markweibo;
        }
        
        perContactsInfo.num = [NSNumber numberWithInt: index++];
        
        [perContactInfoArr addObject:perContactsInfo];
        [perContactsInfo release];
    }
}

- (void) personalContactsCallback : (NSData *)data error: (NSError *)error
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
                [ContactsDataParser parsePerContactsList:bodyData];
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"companyid = %@", selectCompanyid];
                [_fetchedResultsController.fetchRequest setPredicate:predicate];
                
                NSError *error = nil;
                
                if (![_fetchedResultsController performFetch:&error]) {
                    DLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
                
                perContactInfoArr = [[NSMutableArray alloc] initWithArray:[_fetchedResultsController fetchedObjects]];
                
//                CGSize labelSize = [selectCompanyname sizeWithFont:[UIFont systemFontOfSize:22.0f]
//                                                 constrainedToSize:CGSizeMake(300, 1000)
//                                                     lineBreakMode:UILineBreakModeCharacterWrap];   // str是要显示的字符串
//                
//                headerLabel.frame = CGRectMake(10, 5, labelSize.width, labelSize.height);
//                headerHeight = labelSize.height + 13;
//                m_lineView.frame = CGRectMake(0, labelSize.height + 12.5, 320, 0.5);
//                m_headerView.frame = CGRectMake(0, 0, 320, labelSize.height + 13);
//                
//                headerLabel.text = selectCompanyname;
                
                [self.tableView reloadData];
                [self.tableView setContentOffset:CGPointMake(0.0, 0.0) animated:NO];
                
                return;
            }
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"个人通讯录信息获取失败，请检查网络或者重新操作。"
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return headerHeight;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return m_headerView;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
//    return [_fetchedResultsController.sections count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    return [[_fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
    return [perContactInfoArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex && ![selectedIndex compare:indexPath]) {
        return TableCellHeight + DetailInfoCount * TableSubCellHeight;
    }
    return TableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PersonalCellIdentifier";
    
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.delegate = self;
    }
    
    if (selectedIndex && [selectedIndex compare:indexPath] == NSOrderedSame) {
        [cell selectedCell:YES];
    }else {
        [cell selectedCell:NO];
    }
    
//    PerContactsInfo *perContactsInfo = [_fetchedResultsController objectAtIndexPath:indexPath];
    PerContactsInfo *perContactsInfo = [perContactInfoArr objectAtIndex:indexPath.row];
    
    cell.personName = perContactsInfo.name;
    cell.telNumber = perContactsInfo.tel;
    cell.emailAddress = perContactsInfo.email;
    cell.perContactsInfo = perContactsInfo;
    cell.officePhone=perContactsInfo.officetel;
    
    return cell;
}

- (void)selectedCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    if (selectedIndex != nil) {
        
        if ([selectedIndex compare:indexPath] != NSOrderedSame) {
            
            [indexPaths addObject:selectedIndex];
            
            [selectedIndex release];
            
            selectedIndex = [indexPath retain];
            
        }
        else {
            [selectedIndex release];
            
            selectedIndex = nil;
        }
    }else {
        
        selectedIndex = [indexPath retain];
        
    }
    
    if (indexPath != nil) {
        
        [indexPaths addObject:indexPath];
        
    }
    
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    [indexPaths release];
    
}

- (void)telBtnClickCell:(NSString *)telStr {
    
    if (telStr != nil && ![telStr isEqualToString:@""]) {
        
        NSString *tmpTel = [telStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tmpTel]];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.tableView addSubview:callWebview];
        [callWebview release];
    }
}

- (void)officeTelBtnClickCell:(NSString *)telStr {
    if (telStr != nil && ![telStr isEqualToString:@""]) {
        
        NSString *tmpTel = [telStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tmpTel]];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.tableView addSubview:callWebview];
        [callWebview release];
    }
}

- (void)mailBtnClickCell:(NSString *)mailStr {
    if (mailStr != nil && ![mailStr isEqualToString:@""]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",mailStr]]];
    }
}

- (void)moreBtnClickCell:(PerContactsInfo *)info {
    PersonalInfoCardViewController *control = [[PersonalInfoCardViewController alloc] init];
    control.perContactsInfo = info;
    [self.navigationController pushViewController:control animated:YES];
    [control release];
}

//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
//{
//    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
//    [self.tableView beginUpdates];
//}
//
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
//{
//    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
//    [self.tableView endUpdates];
//    
//    [self.tableView flashScrollIndicators];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
//{
//    
//    switch(type) {
//            
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeUpdate:
//            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            break;
//        case NSFetchedResultsChangeMove:
//            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}

@end
