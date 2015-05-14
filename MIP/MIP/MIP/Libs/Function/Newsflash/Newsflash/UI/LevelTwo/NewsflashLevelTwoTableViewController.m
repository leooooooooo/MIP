//
//  NewsflashLevelTwoTableViewController.m
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "NewsflashLevelTwoTableViewController.h"

#import "NewsflashNetRequest.h"

#import "NewsflashBLL.h"

#import "NewsflashLevelTwoCell.h"

#import "NewsflashContentViewController.h"

#import "SecurityDailyInfo.h"

#import "PDFToolViewController.h"

#define kNewsflashTableViewWidth                   self.view.frame.size.width
#define kNewsflashTableViewHeight                  self.view.frame.size.height

#define kPdfFilePath            @"pdfFilePath"
#define kPdfTitle               @"pdfTitle"

@interface NewsflashLevelTwoTableViewController ()<PDFToolDelegate>
{
    NewsflashContentViewController           *_contentViewController;
    
    PDFToolViewController *_pdfToolViewController;
    
    NSArray *urlList;
}

@property (nonatomic, retain) NewsflashEntity *parentEntity;
@property (nonatomic, retain) SecurityDailyInfo *selectNews;

@end

@implementation NewsflashLevelTwoTableViewController

@synthesize parentEntity;

@synthesize selectNews;

- (void)dealloc {
    self.parentEntity = nil;
    
    [super dealloc];
}

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
    
    self.tableView.rowHeight = TableCellHeight;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
#endif
    
    self.tableView.frame = CGRectMake(0, 70, kNewsflashTableViewWidth, kNewsflashTableViewHeight-50);
    emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 150, 380, 45)];
    emptyImageView.backgroundColor = [UIColor clearColor];
    emptyImageView.image = [UIImage imageNamed:@"list_noData.png" imageBundle:publicResourceBundle];
    [self.tableView addSubview:emptyImageView];
    emptyImageView.hidden = YES;
    [emptyImageView release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isAllowAutoFooterLoading = YES;
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    _customRefreshControl.headerView.frame = CGRectMake(0.0f, -170.0f, kNewsflashTableViewWidth, 170.0f);
    
    CGRect rect = _customRefreshControl.headerLastUpdatedLabel.frame;
    
    rect = CGRectMake((kNewsflashTableViewWidth-rect.size.width)/2, rect.origin.y, rect.size.width, rect.size.height);
    
    _customRefreshControl.headerLastUpdatedLabel.frame = rect;
    
    rect = _customRefreshControl.headerStatusLabel.frame;
    
    rect = CGRectMake((kNewsflashTableViewWidth-rect.size.width)/2, rect.origin.y, rect.size.width, rect.size.height);
    
    _customRefreshControl.headerStatusLabel.frame = rect;
    
    rect = _customRefreshControl.headerActivityView.frame;
    
    _customRefreshControl.headerActivityView.frame = CGRectMake(50, rect.origin.y, rect.size.width, rect.size.height);
    
    rect = _customRefreshControl.headerArrowImage.frame;
    
    _customRefreshControl.headerArrowImage.frame = CGRectMake(50, rect.origin.y, rect.size.width, rect.size.height);
}


- (void)updateNewsflashEntityWithParentEntity:(NewsflashEntity *)entity
{
    if (self.parentEntity != entity) {
        
        self.parentEntity = entity;
        
        NSFetchedResultsController *afetchedResultsController = parentEntity.fetchedResultsController;
        afetchedResultsController.delegate = self;
        
        NSError *error;
        if (afetchedResultsController && ![afetchedResultsController performFetch:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [self.tableView reloadData];
    }
    
    [self requestNewsflashEntityData];
}

/*!
 @function
 @abstract      详细列表数据请求完毕后的回调方法
 
 @param         data                        网络请求的原始数据
 @param         error                       网络请求错误,ASI提供的error
 
 @note
 
 @result        无
 */

-(void)requestNewsflashEntityData
{
    //lixiangai
    emptyImageView.hidden = YES;
    //end
    
    if (!isValid([Userinfo shareUserinfo].token))
    {
        emptyImageView.hidden = NO;
        
        return;
    }
    
    if (hud == nil)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:YES];
    }
    
    [self requestForSecurityDaily:nil andKey:nil];
    
}

- (void) requestForSecurityDaily : (NSString *)queryDate andKey : (NSString *)sKey
{
    if (!queryDate) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        queryDate = [dateFormat stringFromDate:[NSDate date]];
        queryDate=[queryDate stringByAppendingString:@" 23:59:59"];
        ;
    }
    
    sKey = sKey ? sKey : @"";
    
    [NewsflashNetRequest executeAsynchronous:@selector(getSecurityDailyList) callback:@selector(callbackRequestSecurityDailyList:error:) backTarget:self args:queryDate,sKey,nil];
}

-(void)callbackRequestSecurityDailyList:(NSData *)data error:(NSError*)error
{
    [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
    hud = nil;
    NSData *bodyData = [NewsflashNetRequest extractDataBodyFromResponsePackage:data];
    [NewsflashBLL getSecurityDaily:bodyData];
    //处理完成后隐藏下拉页面
    [self doneLoadingHeaderTableViewData];
}

-(void)requestMoreNewsflashEntityData
{
    //下拉更新结束后，调用，用于scrollView复位
    [self doneLoadingAutoFooterTableViewData];
}



#pragma mark -CustomRefreshControlDelegate
- (void)refreshTableHeaderDidTriggerRefresh:(CustomRefreshControl*)view
{
    //发送下拉刷新请求
    [self requestNewsflashEntityData];
}

- (void)autoFooterLoading {
    
    [self requestMoreNewsflashEntityData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*!
 @function
 @abstract      UITableView的datasource方法
 
 @param         tableView                       被实现协议的tableView
 
 @note
 
 @result        tableView区的个数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.parentEntity.fetchedResultsController sections].count;
}

/*!
 @function
 @abstract      UITableView的datasource方法
 
 @param         tableView                       被实现协议的tableView
 @param         section                         当前tableView的区的编号
 
 @note
 
 @result        tableView每个区的中行的个数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.parentEntity.fetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

/*!
 @function
 @abstract      配置tableViewCell的属性
 
 @param         cell                            当前需要配置的cell
 @param         indexPath                       当前cell的位置
 
 @note
 
 @result        无
 */
- (void)configureCell:(NewsflashLevelTwoCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (self.parentEntity.fetchedResultsController.fetchedObjects.count > indexPath.row)
    {
        SecurityDailyInfo *entity = [self.parentEntity.fetchedResultsController objectAtIndexPath:indexPath];
        
        cell.textLabel.text = entity.dailyName;
        
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1000];
        
        if (Readed == [entity.readType intValue])
        {
            imageView.image = nil;
            
        }
        else if (Unreaded == [entity.readType intValue])
        {
            imageView.image = [UIImage imageNamed:@"new.png" imageBundle:newsCenterBundle];
            
        }
    }
    
}

/*!
 @function
 @abstract      UITableView的datasource方法
 
 @param         tableView                       被实现协议的tableView
 @param         indexPath                       当前cell的位置
 
 @note
 
 @result        indexPath位置的cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NewsflashLevelTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[NewsflashLevelTwoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.imageView.image = [UIImage imageNamed:@"list_icon.png" imageBundle:newsCenterBundle];
        
        UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selectBG.png" imageBundle:mainBundle]];
        cell.selectedBackgroundView = selectedBackgroundView;
        [selectedBackgroundView release];
        
        UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png" imageBundle:mainBundle]];
        accessoryView.frame = CGRectMake(0, 0, 10, 13);
        cell.accessoryView = accessoryView;
        [accessoryView release];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        UIImageView *unreadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(39, 3, 19.5, 15)];
        unreadImageView.image = [UIImage imageNamed:@"tag_unread.png" imageBundle:newsCenterBundle];
        unreadImageView.backgroundColor = [UIColor clearColor];
        unreadImageView.tag = 1000;
        [cell.contentView addSubview:unreadImageView];
        [unreadImageView release];
        
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
//        cell.detailTextLabel.textColor = cell.detailTextLabel.highlightedTextColor = [UIColor grayColor];
    }
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecurityDailyInfo *entity = [self.parentEntity.fetchedResultsController objectAtIndexPath:indexPath];
    
    self.selectNews = entity;
    
    [NewsflashNetRequest executeAsynchronous:@selector(getSecurityDailyDetail) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:entity.dailyId,nil];
}

- (void)callbackGetDocumentURL:(NSData *)data error:(NSError *)error
{
    NSData *bodyData = [NewsflashNetRequest extractDataBodyFromResponsePackage:data];
    
    NSDictionary *dailyDetail = [NewsflashBLL getSecurityDailyDetail:bodyData];
    
    urlList = [dailyDetail objectForKey:@"urlList"];
    
    if ([urlList count] > 0) {
        
        NSString *url = [urlList firstObject];
        
        NSString *pathName = [[url lastPathComponent] stringByDeletingPathExtension];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",pathName]];
        
        if (![manager fileExistsAtPath:filePath])
        {
            [NewsflashNetRequest executeAsynchronous:@selector(downloadPDF) callback:@selector(callbackDownloadPDF:error:) backTarget:self args:url, pathName, nil];
        }
        else
        {
            [self openFile:filePath];
        }
        
    }else
    {
        //没有PDF 没有content
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"暂未获取到数据，请稍后在试！"
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:
                                  nil];
        [alertView show];
        [alertView release];
    }
}

- (void)callbackDownloadPDF:(NSString *)filePath error:(NSError *)error
{
    [MBProgressHUD hideHUDForView:_pdfToolViewController.view animated:YES];
    hud = nil;
    
    if (error == nil)
    {
        [self openFile:filePath];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"PDF文件下载失败"
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:
                                  nil];
        [alertView show];
        [alertView release];
    }
}

- (void)openFile:(NSString *)pdfFilePath
{
    [NewsflashBLL setSecurityDailyReadState:self.selectNews.dailyId];
    
    PDFDocument *document = [[PDFDocument alloc] init];
    
    document.title = self.selectNews.dailyName;
    
    NSString *path = [pdfFilePath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    document.url = path;
    
    if (_pdfToolViewController == nil)
    {
        _pdfToolViewController = [[PDFToolViewController alloc] initWithDocument:document];
        
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFCommitPermission];
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFSignPermission];
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFAccessoryPermission];
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFInfoPermission];
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFHelpPermission];
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFCheckPermission];
        
        _pdfToolViewController.delegate = self;
        
        [self presentViewController:_pdfToolViewController animated:YES completion:NULL];
        
        //        [self.navigationController pushViewController:_pdfToolViewController animated:YES];
        
        [document release];
        
        [_pdfToolViewController release];
    }
    else
    {
        [_pdfToolViewController loadPDFDocument:document];
    }
    
}

#pragma mark PDFToolDelegate methods

- (void)tappedInPDFToolbar:(UIView *)toolbar backButton:(UIButton *)button
{
    _pdfToolViewController = nil;
}

#pragma mark - NSFetchedResultsControllerDelegate
/*!
 @function
 @abstract      NSFetchedResultsControllerDelegate方法,当其管理的数据内容将要发生变化时,该方法将会被触发
 
 @param         controller                      被实现协议的controller
 
 @note          tableView准备开始更新
 
 @result        无
 */
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    if (self.parentEntity.fetchedResultsController == controller)
    {
        [self.tableView beginUpdates];
    }
}



/*!
 @function
 @abstract      NSFetchedResultsControllerDelegate方法,当其管理的数据内容将要发生变化时,该方法将会被触发
 
 @param         controller                      被实现协议的controller
 @param
 
 @note          根据当前数据发生的增,删,改,移动,视图对应的处理
 
 @result        无
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    if (self.parentEntity.fetchedResultsController == controller)
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
                
                
                
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                
                break;
                
            case NSFetchedResultsChangeMove:
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
        }
        
    }
}



/*!
 @function
 @abstract      NSFetchedResultsControllerDelegate方法,当其管理的数据内容变化完成时,该方法将会被触发
 
 @param         controller                      被实现协议的controller
 @param
 
 @note          tableView结束更新
 
 @result        无
 */
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    //lixiangai 三级目录数据错误问题
    if (self.parentEntity.fetchedResultsController == controller)
    {
        [self.tableView endUpdates];
        
        [self.tableView flashScrollIndicators];
    }
    
}

@end
