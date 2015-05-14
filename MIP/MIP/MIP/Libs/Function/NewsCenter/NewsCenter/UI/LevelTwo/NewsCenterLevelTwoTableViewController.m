//
//  NewsCenterLevelTwoTableViewController.m
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import "NewsCenterLevelTwoTableViewController.h"

#import "NewsCenterLevelTwoViewController.h"

#import "NewsCenterLevelTwoCell.h"

#import "NewsCenterNetRequest.h"

#import "NewsCenterBLL.h"

#import "NewsCenterPDF.h"

#import "SuspendController.h"

#import "ContentPDFViewController.h"


#define kNewsCenterDocumentTableViewWidth                   320
#define kNewsCenterDocumentTableViewHeight                  self.parentViewController.view.frame.size.height

@interface NewsCenterLevelTwoTableViewController (){
    
//    IphonePDFToolViewController           *_iphonePDFToolViewController;
    
    PDFToolViewController                 *_pdfToolViewController;
    
    ContentPDFViewController        *_contentPdfToolViewController;
    
    ContentViewController           *_contentViewController;
    
    SuspendController               *suspendViewController;
    
    NSMutableArray                  *pdfListArr;
    
}
@property (nonatomic, retain) NewsCenterDocument *curDocument;
@property (nonatomic, retain) NewsCenterPDF      *curPdf;
@property (nonatomic, retain) NSMutableArray     *pdfListArr;

@property (nonatomic, retain) NSDictionary     *contentAndPDFListDict;

@property (nonatomic, retain) NSString           *typeID;

@property (nonatomic, assign) NewsType           currentNewsType;

@end

@implementation NewsCenterLevelTwoTableViewController
@synthesize documentDelegate = _documentDelegate;

@synthesize currentCategory;

@synthesize curDocument;

@synthesize curPdf;

@synthesize typeID;

@synthesize currentNewsType;

@synthesize pdfListArr;

@synthesize contentAndPDFListDict;
- (void)dealloc {
    
    [currentCategory removeObserver:self forKeyPath:@"keyword" context:NULL];
    
    self.currentCategory.fetchedResultsController.delegate = nil;
    
    self.currentCategory.fetchedResultsController = nil;
    
    self.currentCategory = nil;
    
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
    
    self.tableView.frame = CGRectMake(0, 115, 320, [UIScreen mainScreen].bounds.size.height-95-20);
    
    self.currentCategory = nil;
    
    self.tableView.rowHeight = TableCellHeight;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
#endif
    
    emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 150, 300, 45)];
    emptyImageView.backgroundColor = [UIColor clearColor];
    emptyImageView.image = [UIImage imageNamed:@"list_noData.png" imageBundle:publicResourceBundle];
    [self.tableView addSubview:emptyImageView];
    emptyImageView.hidden = YES;
    [emptyImageView release];
    
    self.typeID = @"";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _isAllowAutoFooterLoading = YES;
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    _customRefreshControl.headerView.frame = CGRectMake(150.0f, -170.0f, self.parentViewController.view.frame.size.width, 170.0f);
    
    CGRect rect = _customRefreshControl.headerLastUpdatedLabel.frame;
    
    rect = CGRectMake((self.parentViewController.view.frame.size.width-rect.size.width)/2, rect.origin.y, rect.size.width, rect.size.height);
    
    _customRefreshControl.headerLastUpdatedLabel.frame = rect;
    
    rect = _customRefreshControl.headerStatusLabel.frame;
    
    rect = CGRectMake((self.parentViewController.view.frame.size.width-rect.size.width)/2, rect.origin.y, rect.size.width, rect.size.height);
    
    _customRefreshControl.headerStatusLabel.frame = rect;
    
    rect = _customRefreshControl.headerActivityView.frame;
    
    _customRefreshControl.headerActivityView.frame = CGRectMake(50, rect.origin.y, rect.size.width, rect.size.height);
    
    rect = _customRefreshControl.headerArrowImage.frame;
    
    _customRefreshControl.headerArrowImage.frame = CGRectMake(-70, rect.origin.y, rect.size.width, rect.size.height);
}

- (void)changeToShowSegmentedControl
{
    CGRect rect = self.tableView.frame;
    rect.origin.y = 105;
    rect.size.height = 643;
    self.tableView.frame = rect;
}
- (void)changeToHideSegmentedControl
{
    CGRect rect = self.tableView.frame;
    rect.origin.y = 105 - 50;
    rect.size.height = 643 + 50;
    self.tableView.frame = rect;
}

#pragma mark -
#pragma mark DownloadEntity KVO Delegate Methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"keyword"]) {
        
        NSString *old = [change objectForKey:NSKeyValueChangeOldKey];
        NSString *new = [change objectForKey:NSKeyValueChangeNewKey];
        
        if (!isValid(old) || (isValid(old) && ![old isEqualToString:new])) {
            
            NSError *error;
            if (self.currentCategory.fetchedResultsController && ![self.currentCategory.fetchedResultsController performFetch:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 */
                DLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            
            [self.tableView reloadData];
            
        }
        
    }
    else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)updateDocumentsWithCategory:(NewsCenterCategory *)category
{
    category.newsType = OTHERS;
    currentNewsType = OTHERS;
    self.currentCategory.typeID = @"";
    self.currentCategory.keyword = category.keyword;
//    NewsCenterLevelTwoViewController *newsCenterLevelTwoViewController = (NewsCenterLevelTwoViewController *)self.parentViewController;
//    NewsClickIndex newsClickIndex = newsCenterLevelTwoViewController.newsClickIndex;
//    if ([category.code isEqualToString:@"XWXX"]) {
//        if (newsClickIndex == hotNews) {//今日关注
//            category.newsType = HOT_NEWS;
//            currentNewsType = HOT_NEWS;
//        }else if (newsClickIndex == allNews){//全部新闻
//            category.newsType = ALL_NEWS;
//            currentNewsType = ALL_NEWS;
//        }
//    }
    
    if (self.currentCategory != category) {
        
        if (self.currentCategory.observationInfo != nil)
        {
            [currentCategory removeObserver:self forKeyPath:@"keyword" context:NULL];
        }
        
        self.currentCategory = category;
        
        [currentCategory addObserver:self forKeyPath:@"keyword" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
        NSFetchedResultsController *afetchedResultsController = category.fetchedResultsController;
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
    
    [self requestNewsCenterDocumentData];
}

- (void)updateDocumentsWithCategory:(NewsCenterCategory *)category newsType:(NewsType)newsType{
    
    self.tableView.frame = CGRectMake(0, 115, 320, [UIScreen mainScreen].bounds.size.height-95-20);
    
    if (self.currentCategory != category || self.currentCategory.newsType != newsType) {
        
        [currentCategory removeObserver:self forKeyPath:@"keyword" context:NULL];
        category.newsType = newsType;
        self.currentCategory = category;
        self.currentNewsType = newsType;
        
        [currentCategory addObserver:self forKeyPath:@"keyword" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
        NSFetchedResultsController *afetchedResultsController = category.fetchedResultsController;
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
    
    [self requestNewsCenterDocumentData];
}

- (void)updateDocumentsWithCategory:(NewsCenterCategory *)category  typeID:(NSString *)aTypeID{
    
    self.currentCategory.keyword = nil;
    if (self.currentCategory != category || self.currentCategory.typeID != aTypeID) {
        
        [currentCategory removeObserver:self forKeyPath:@"keyword" context:NULL];
        category.typeID = aTypeID;
        self.currentCategory = category;
        self.typeID = aTypeID;
        
        [currentCategory addObserver:self forKeyPath:@"keyword" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
        NSFetchedResultsController *afetchedResultsController = category.fetchedResultsController;
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
    
    [self requestNewsCenterDocumentData];
}

/*!
 @function
 @abstract      详细列表数据请求完毕后的回调方法
 
 @param         data                        网络请求的原始数据
 @param         error                       网络请求错误,ASI提供的error
 
 @note
 
 @result        无
 */

-(void)requestNewsCenterDocumentData
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
    
       NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *destDateString = [dateFormat stringFromDate:[NSDate date]];
       destDateString=[destDateString stringByAppendingString:@" 23:59:59"];
    NSString *keyString = @"";
    if (self.currentCategory.keyword != nil)
    {
        keyString = self.currentCategory.keyword;
    }
    
    if ([currentCategory.code isEqualToString:@"TZGG"]) {//TZGG  通知公告
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterTZGGDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    
    }else if([currentCategory.code isEqualToString:@"AQRB"]){//AQRB  安全日报
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterAQRBDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
        
    }else if([currentCategory.code isEqualToString:@"XMDC"]){//XMDC  项目督查
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterXMDCDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
        
    }else if([currentCategory.code isEqualToString:@"DZGB"]){//DZGB  电子港报
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterDZGBDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
        
    }else if([currentCategory.code isEqualToString:@"XWXX"]){//XWXX
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterJTYWDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
        
    }else if([currentCategory.code isEqualToString:@"SPXW"]){//SPXW  视频新闻
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterSPXWDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }
    else if([currentCategory.code isEqualToString:@"JCDT"]){//基层动态
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterJCDTDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }
    else if([currentCategory.code isEqualToString:@"GHZX"]){//港行咨询
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterGHZXDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }
    else if([currentCategory.code isEqualToString:@"LQSM"]){//陆桥扫描
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterLQSMDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }
    else if([currentCategory.code isEqualToString:@"QZLX"]){//群众路线
        
    [NewsCenterNetRequest executeAsynchronous:@selector(getNewSCenterQZLXDocument) callback:@selector(callbackNewsCenterDocuments:error:)backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }

}

-(void)callbackNewsCenterDocuments:(ASIHTTPRequest *)request  error:(NSError*)error
{
    [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
    hud = nil;
    
    
    NSData *bodyData = [NewsCenterNetRequest extractDataBodyFromResponsePackage:request.responseData];
    
    NewsCenterCategory *category = [request.userInfo objectForKey:@"category"];
    
    if (category == self.currentCategory)
    {
        [NewsCenterBLL synchroniseNewsCenterDocuments:bodyData category:self.currentCategory];
    }
    
    
    //下拉更新结束后，调用，用于scrollView复位
    [self doneLoadingHeaderTableViewData];
    [self doneLoadingAutoFooterTableViewData];
    
    //搜索
    if ((isValid(self.currentCategory.keyword) && ![self.currentCategory.keyword isEqualToString:@""])||(isValid(self.currentCategory.typeID)&&![self.currentCategory.typeID isEqualToString:@""]))
    {
        [(NewsCenterLevelTwoViewController *)self.parentViewController searchNewsCenterResultCount:[self.currentCategory.fetchedResultsController.fetchedObjects count]];
    }
    
    //lixiangai
    if([self.currentCategory.fetchedResultsController.fetchedObjects count] == 0)
    {
        //        self.tableView.separatorColor = [UIColor clearColor];
        emptyImageView.hidden = NO;
        [self.tableView beginUpdates];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView endUpdates];
    }
    else
    {
        //        self.tableView.separatorColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        emptyImageView.hidden = YES;
        [self.tableView beginUpdates];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.tableView endUpdates];
    }
    //end
}

-(void)requestMoreNewsCenterDocumentData
{
    //lixiangai
    emptyImageView.hidden = YES;
    //end
    if (hud == nil)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:YES];
    }
    
    NewsCenterDocument *document = [self.currentCategory.fetchedResultsController.fetchedObjects lastObject];
    
    NSString *destDateString = @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    destDateString = [dateFormatter stringFromDate:document.generateDate];
    [dateFormatter release];
    
    NSString *keyString = @"";
    if (self.currentCategory.keyword != nil)
    {
        keyString = self.currentCategory.keyword;
    }
    
    if ([currentCategory.code isEqualToString:@"TZGG"]) {//TZGG  通知公告
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterTZGGDocument) callback:@selector(callbackMoreNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
        
    }else if([currentCategory.code isEqualToString:@"AQRB"]){//AQRB  安全日报
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterAQRBDocument) callback:@selector(callbackMoreNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
        
    }else if([currentCategory.code isEqualToString:@"XMDC"]){//XMDC  项目督查
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterXMDCDocument) callback:@selector(callbackMoreNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
        
    }else if([currentCategory.code isEqualToString:@"DZGB"]){//DZGB  电子港报
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterDZGBDocument) callback:@selector(callbackMoreNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
        
    }else if([currentCategory.code isEqualToString:@"XWXX"]){//XWXX  新闻信息
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterJTYWDocument) callback:@selector(callbackMoreNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
        
    }else if([currentCategory.code isEqualToString:@"SPXW"]){//SPXW  视频新闻
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterSPXWDocument) callback:@selector(callbackNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }
    else if([currentCategory.code isEqualToString:@"JCDT"]){//基层动态
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterJCDTDocument) callback:@selector(callbackMoreNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }
    else if([currentCategory.code isEqualToString:@"GHZX"]){//港行咨询
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterGHZXDocument) callback:@selector(callbackMoreNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }
    else if([currentCategory.code isEqualToString:@"LQSM"]){//陆桥扫描
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterLQSMDocument) callback:@selector(callbackMoreNewsCenterDocuments:error:) backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }
    else if([currentCategory.code isEqualToString:@"QZLX"]){//群众路线
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getNewSCenterQZLXDocument) callback:@selector(callbackNewsCenterDocuments:error:)backTarget:self args:[[Userinfo shareUserinfo] token],destDateString,pageSize,keyString,self.currentCategory,nil];
    }
}

-(void)callbackMoreNewsCenterDocuments:(ASIHTTPRequest *)request error:(NSError*)error
{
    [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
    hud = nil;
    
    NSData *bodyData = [NewsCenterNetRequest extractDataBodyFromResponsePackage:request.responseData];
    
    NewsCenterCategory *category = [request.userInfo objectForKey:@"category"];
    
    if (category == self.currentCategory)
    {
        [NewsCenterBLL synchroniseNewsCenterDocuments:bodyData category:self.currentCategory];
    }
    
    //下拉更新结束后，调用，用于scrollView复位
    [self doneLoadingAutoFooterTableViewData];
    [self doneLoadingAutoFooterTableViewData];
    
    //搜索
    if (isValid(self.currentCategory.keyword) && ![self.currentCategory.keyword isEqualToString:@""])
    {
        [(NewsCenterLevelTwoViewController *)self.parentViewController searchNewsCenterResultCount:[self.currentCategory.fetchedResultsController.fetchedObjects count]];
    }
    
    //lixiangai
    if([self.currentCategory.fetchedResultsController.fetchedObjects count] == 0)
    {
        //        self.tableView.separatorColor = [UIColor clearColor];
        emptyImageView.hidden = NO;
        [self.tableView beginUpdates];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView endUpdates];
    }
    else
    {
        //        self.tableView.separatorColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        emptyImageView.hidden = YES;
        [self.tableView beginUpdates];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.tableView endUpdates];
    }
    //end
}

- (void)callbackNewsCenterNewsType:(NSData *)data error:(NSError*)error{
    NSData *bodyData = [NewsCenterNetRequest extractDataBodyFromResponsePackage:data];
    
    if (! isValid(bodyData))
    {
        return;
    }
    
    [NewsCenterBLL synchroniseNewsCenterNewsType:bodyData];
//    页面赋值
    NSArray *typeArray = [NewsCenterBLL synchroniseNewsCenterNewsType:bodyData];;
    NSMutableString *typeStr = [[NSMutableString alloc] init];
    
    for (NSDictionary *dict in typeArray) {
        [typeStr appendFormat:@"%@,",[dict objectForKey:@"name"]];
    }
    NewsCenterLevelTwoViewController *newsCenterLevelTwoViewController = (NewsCenterLevelTwoViewController *)self.parentViewController;
    newsCenterLevelTwoViewController.newsCenterLevelTwoView.filtrateStr = [typeStr length]>0?[typeStr substringToIndex:[typeStr length]-1]:@"";
    [typeStr release];
}

#pragma mark -CustomRefreshControlDelegate
- (void)refreshTableHeaderDidTriggerRefresh:(CustomRefreshControl*)view
{
    //发送下拉刷新请求
    [self requestNewsCenterDocumentData];
}

- (void)autoFooterLoading {
    
    [self requestMoreNewsCenterDocumentData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_documentDelegate)
    {
        [_documentDelegate tableViewDidScroll];
    }
}

/*!
 @function
 @abstract      UITableView的datasource方法
 
 @param         tableView                       被实现协议的tableView
 
 @note
 
 @result        tableView区的个数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.currentCategory.fetchedResultsController sections].count;
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
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.currentCategory.fetchedResultsController sections] objectAtIndex:section];
    
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
- (void)configureCell:(NewsCenterLevelTwoCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentCategory.fetchedResultsController.fetchedObjects.count > indexPath.row)
    {
        NewsCenterDocument *entity = [self.currentCategory.fetchedResultsController objectAtIndexPath:indexPath];
        
        cell.textLabel.text = entity.title;
        
        NSString *detailStr = nil;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        if ([currentCategory.code isEqualToString:@"XWXX"]||[currentCategory.code isEqualToString:@"AQRB"]||[currentCategory.code isEqualToString:@"DZGB"]) {
            [dateFormatter setDateFormat:@"时间: yyyy-MM-dd"];
            
            NSString *date = [dateFormatter stringFromDate:entity.generateDate];
            
            detailStr = [NSString stringWithFormat:@"[%@]                   %@",entity.typeName,date];
        }else{
            [dateFormatter setDateFormat:@"时间: yyyy-MM-dd HH:mm:ss"];
            
            NSString *date = [dateFormatter stringFromDate:entity.generateDate];
            
            detailStr = [NSString stringWithFormat:@"[%@]     %@",entity.typeName,date];
        }
        
        [dateFormatter release];
        
        cell.detailTextLabel.text = detailStr;
        
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1000];
        
        if (![entity.newMark boolValue])
        {
//            imageView.image = [UIImage imageNamed:@"tag_read.png" imageBundle:newsCenterBundle];
            imageView.image = nil;
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"tag_unread.png" imageBundle:newsCenterBundle];
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
    NewsCenterLevelTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[NewsCenterLevelTwoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.imageView.image = [UIImage imageNamed:@"icon_txt.png" imageBundle:newsCenterBundle];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selectBG.png" imageBundle:mainBundle]];
        //lixiangai
        imageView.backgroundColor = [UIColor clearColor];
        //end
        cell.selectedBackgroundView = imageView;
        
        [imageView release];
        
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png" imageBundle:mainBundle]];
        
        cell.accessoryView = imageView;
        
        [imageView release];
        
        cell.textLabel.textColor = cell.textLabel.highlightedTextColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
        
        UIImageView *unreadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(39, 3, 19.5, 15)];
        unreadImageView.image = [UIImage imageNamed:@"tag_unread.png" imageBundle:newsCenterBundle];
        unreadImageView.backgroundColor = [UIColor clearColor];
        unreadImageView.tag = 1000;
        [cell.contentView addSubview:unreadImageView];
        [unreadImageView release];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        cell.detailTextLabel.textColor = cell.detailTextLabel.highlightedTextColor = [UIColor grayColor];
        
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (hud == nil)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:YES];
    }
    
    NewsCenterDocument *document = [self.currentCategory.fetchedResultsController objectAtIndexPath:indexPath];
    
    self.curDocument = document;
    
    if([self.currentCategory.code isEqualToString:@"DZGB"]){//DZGB  电子港报
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getDZGBDocumentURL) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:[Userinfo shareUserinfo].token,document.uid,nil];
        
    }else if([currentCategory.code isEqualToString:@"XWXX"]){//XWXX  新闻信息
        [NewsCenterNetRequest executeAsynchronous:@selector(getJTYWDocumentURL) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:[Userinfo shareUserinfo].token,document.uid,nil];
        
    }else if ([currentCategory.code isEqualToString:@"TZGG"]) {//TZGG  通知公告
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getTZGGDocumentURL) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:[Userinfo shareUserinfo].token,document.uid,nil];
        
    }else if([currentCategory.code isEqualToString:@"AQRB"]){//AQRB  安全日报
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getAQRBDocumentURL) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:[Userinfo shareUserinfo].token,document.uid,nil];
        
    }else if([currentCategory.code isEqualToString:@"XMDC"]){//XMDC  项目督查
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getXMDCDocumentURL) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:[Userinfo shareUserinfo].token,document.uid,nil];
        
    }else if([currentCategory.code isEqualToString:@"SPXW"]){//SPXW  视频新闻
        
        [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
        
        if (_documentDelegate && [_documentDelegate respondsToSelector:@selector(playThisVeddioRecordWith:)])
        {
            if (_documentDelegate)
            {
                [_documentDelegate playThisVeddioRecordWith:document];
                
                [NewsCenterNetRequest executeAsynchronous:@selector(updateHaveReadState) callback:@selector(callbackUpdateReadState:error:) backTarget:self args:[Userinfo shareUserinfo].token,[Userinfo shareUserinfo].name,document.msgTypeID,document.uid,nil];
            }
        }
    }
    else if([currentCategory.code isEqualToString:@"JCDT"]){//基层动态
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getJCDTDocumentURL) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:[Userinfo shareUserinfo].token,document.uid,nil];
    }
    else if([currentCategory.code isEqualToString:@"GHZX"]){//港行咨询
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getGHZXDocumentURL) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:[Userinfo shareUserinfo].token,document.uid,nil];
    }
    else if([currentCategory.code isEqualToString:@"LQSM"]){//陆桥扫描
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getLQSMDocumentURL) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:[Userinfo shareUserinfo].token,document.uid,nil];
    }else if([currentCategory.code isEqualToString:@"QZLX"]){//群众路线
        
        [NewsCenterNetRequest executeAsynchronous:@selector(getQZLXDocumentURL) callback:@selector(callbackGetDocumentURL:error:) backTarget:self args:[Userinfo shareUserinfo].token,document.uid,nil];
    }

    
    document.newMark = [NSNumber numberWithBool:NO];
    [document.managedObjectContext save:NULL];
}
-(void)test
{
    NSLog(@"test");
}

- (void)callbackUpdateReadState:(NSData *)data error:(NSError *)error
{
    NSData *bodyData = [NewsCenterNetRequest extractDataBodyFromResponsePackage:data];
    
    if (bodyData) {
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",bodyDictionary);
        
    }
    
    return;
}

- (void)callbackGetDocumentURL:(NSData *)data error:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
    hud = nil;
    
    if([self.currentCategory.code isEqualToString:@"DZGB"]){//DZGB  电子港报
     
        NSData *bodyData = [NewsCenterNetRequest extractDataBodyFromResponsePackage:data];
        
        self.pdfListArr = [NewsCenterBLL getNewsCenterPDFList:bodyData];
        
        if ([self.pdfListArr count] > 0)
        {
            self.curPdf = [pdfListArr objectAtIndex:0];
            
            NSString *pathName = [[self.curPdf.url lastPathComponent] stringByDeletingPathExtension];
            
            NSFileManager *manager = [NSFileManager defaultManager];
            
            NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",pathName]];
            
            if (![manager fileExistsAtPath:filePath])
            {
                [NewsCenterNetRequest executeAsynchronous:@selector(downloadPDF) callback:@selector(callbackDownloadPDF:error:) backTarget:self args:curPdf.url,pathName,nil];
            }
            else
            {
                [self openFile:self.curPdf];
            }
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"没有PDF文件"
                                      delegate:nil
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:
                                      nil];
            [alertView show];
            [alertView release];
        }
    
    }else if([self.currentCategory.code isEqualToString:@"TZGG"]||[self.currentCategory.code isEqualToString:@"AQRB"]||[self.currentCategory.code isEqualToString:@"XMDC"]||[self.currentCategory.code isEqualToString:@"XWXX"] || [self.currentCategory.code isEqualToString:@"JCDT"] || [self.currentCategory.code isEqualToString:@"GHZX"] || [self.currentCategory.code isEqualToString:@"LQSM"]|| [self.currentCategory.code isEqualToString:@"QZLX"]){//TZGG  通知公告  AQRB  安全日报 XMDC  项目督查
        NSData *bodyData = [NewsCenterNetRequest extractDataBodyFromResponsePackage:data];
        
        self.contentAndPDFListDict = [NewsCenterBLL getNewsCenterPDFAndContent:bodyData andDocumentID:curDocument.uid];
        
        self.pdfListArr = [contentAndPDFListDict objectForKey:@"PDFArr"];
        
        NSString *contentStr = [contentAndPDFListDict objectForKey:@"content"];
        
        if ([self.pdfListArr count] > 0 && !(isValid(contentStr) && ![contentStr isEqualToString:@""])) //只有PDF 没有content
        {
            self.curPdf = [pdfListArr objectAtIndex:0];
            
            NSString *pathName = [[self.curPdf.url lastPathComponent] stringByDeletingPathExtension];
            
            NSFileManager *manager = [NSFileManager defaultManager];
            
            NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",pathName]];
            
            if (![manager fileExistsAtPath:filePath])
            {
                [NewsCenterNetRequest executeAsynchronous:@selector(downloadPDF) callback:@selector(callbackDownloadPDF:error:) backTarget:self args:curPdf.url,pathName,nil];
            }
            else
            {
                [self openFile:self.curPdf];
            }
        }else if([self.pdfListArr count] > 0 && (isValid(contentStr) && ![contentStr isEqualToString:@""])){//有PDF 有content
            if ([self.currentCategory.code isEqual:@"XWXX"]) {
                [self openContent:self.contentAndPDFListDict];
            }else{
                self.curPdf = [pdfListArr objectAtIndex:0];
                
                NSString *pathName = [[self.curPdf.url lastPathComponent] stringByDeletingPathExtension];
                
                NSFileManager *manager = [NSFileManager defaultManager];
                
                NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",pathName]];
                
                if (![manager fileExistsAtPath:filePath])
                {
                    [NewsCenterNetRequest executeAsynchronous:@selector(downloadPDF) callback:@selector(callbackDownloadPDF:error:) backTarget:self args:curPdf.url,pathName,nil];
                }
                else
                {
                    //                [self openFile:self.curPdf andConent:contentStr];
                    [self openFile:self.curPdf];
                }
            }
        }else if([self.pdfListArr count] == 0 && (isValid(contentStr) && ![contentStr isEqualToString:@""])){//没有PDF 有content
            [self openContent:self.contentAndPDFListDict];
        }else{//没有PDF 没有content
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
}

- (void)callbackDownloadPDF:(NSString *)filePath error:(NSError *)error
{
    [MBProgressHUD hideHUDForView:_pdfToolViewController.view animated:YES];
    hud = nil;
    
    if (error == nil)
    {
        curPdf.filePath = filePath;
        [curPdf.managedObjectContext save:NULL];
        
        self.curDocument.filePath = filePath;
        [curDocument.managedObjectContext save:NULL];
        
        [self openFile:curPdf];
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

- (void)openFile:(NewsCenterPDF *)pdf
{
    PDFDocument *document = [[PDFDocument alloc] init];
    
    if ([self.pdfListArr count] > 1)
    {
        document.title = pdf.name;
    }
    else
    {
        document.title = self.curDocument.title;
    }
    
    NSString *path = [pdf.filePath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    document.url = path;
    
    if (_pdfToolViewController == nil)
    {
        _pdfToolViewController = [[PDFToolViewController alloc] initWithDocument:document];
        
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFCommitPermission];
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFSignPermission];
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFAccessoryPermission];
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFInfoPermission];
        [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFHelpPermission];
        
        if ([self.pdfListArr count] > 1)
        {
            [_pdfToolViewController setToolbarPermission:ON forKey:kPDFCheckPermission];
        }
        else
        {
            [_pdfToolViewController setToolbarPermission:OFF forKey:kPDFCheckPermission];
        }
        
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

- (void)openContent:(NSDictionary *)content
{
    [self.tableView reloadData];
    _contentViewController = [[ContentViewController alloc] init];
    _contentViewController.contentDelegate = self;
    [self presentViewController:_contentViewController animated:YES completion:NULL];
    [_contentViewController.contentWebView loadHTMLString:[content objectForKey:@"content"] baseURL:nil];
    [_contentViewController release];
    
    NSString *author = [content objectForKey:@"author"];
    if (isValid(author)&&![author isEqualToString:@""]) {
        _contentViewController.authorLabel.text = [NSString stringWithFormat:@"作者 %@",author];
    }
    
    NSString *source = [content objectForKey:@"source"];
    if (isValid(source)&&![source isEqualToString:@""]) {
        _contentViewController.sourceLabel.text = [NSString stringWithFormat:@"来源 %@",source];
    }
    
    _contentViewController.titleLabel.text = self.curDocument.title;
}

#pragma mark - ContentViewControllerDelegate

- (void)backToViewController
{
    [_contentViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)lookAtThisPDF:(NewsCenterPDF *)pdf
{
    self.curPdf = pdf;
    
    [suspendViewController dismiss];
    
    NSString *pathName = [[pdf.url lastPathComponent] stringByDeletingPathExtension];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",pathName]];
    
    if (![manager fileExistsAtPath:filePath])
    {
        if (hud == nil)
        {
            hud = [MBProgressHUD showHUDAddedTo:_pdfToolViewController.view animated:YES];
        }
        
        [NewsCenterNetRequest executeAsynchronous:@selector(downloadPDF) callback:@selector(callbackDownloadPDF:error:) backTarget:self args:pdf.url,pathName,nil];
    }
    else
    {
        [self openFile:pdf];
    }
}


#pragma mark PDFToolDelegate methods
- (void)tappedInPDFToolbar:(UIView *)toolbar checkButton:(UIButton *)button
{
    PDFListViewController *pdfListController = [[PDFListViewController alloc] initWithPDFList:self.pdfListArr];
    
    pdfListController.pdfListDelegate = self;
    
    [_pdfToolViewController addChildViewController:pdfListController];
    
    [_pdfToolViewController.view addSubview:pdfListController.view];
    
    [pdfListController release];
}

- (void)tappedInPDFToolbar:(UIView *)toolbar backButton:(UIButton *)button
{
    _pdfToolViewController = nil;
}

//- (void)callbackDownloadDocument:(NSString *)filePath error:(NSError *)error
//{
//
//    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
//    
//    LibraryDocument *document = [self.currentCategory.fetchedResultsController objectAtIndexPath:index];
//    
//    NSString *folder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString *fileName = nil;
//    
//    [LibraryNetRequest extractDataBodyFromZipPackage:filePath destinationPath:folder filePath:&fileName];
//    
//    if (isValid(fileName)) {
//        
//        document.filePath = fileName;
//        
//        [document.managedObjectContext save:NULL];
//        
//        [self openFile:document];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:DOCUMENTUNREADNOTIFICATION object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:MODULEUNREADNOTIFICATION object:nil];
//        
//    }
//    else {
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"文件下载失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
//        
//        [alertView show];
//        
//        [alertView release];
//    }
//}


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
    if (self.currentCategory.fetchedResultsController == controller)
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
    if (self.currentCategory.fetchedResultsController == controller)
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
    if (self.currentCategory.fetchedResultsController == controller)
    {
        [self.tableView endUpdates];
        
        [self.tableView flashScrollIndicators];
    }
    
}
#ifdef __IPHONE_6_0
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
   
    return UIInterfaceOrientationMaskPortrait;
}
#endif

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{

    return NO;
}


@end
