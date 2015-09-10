//
//  NewsCenterLevelOneTableViewController.m
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import "NewsCenterLevelOneTableViewController.h"

#import "NewsCenterLevelOneCell.h"

#import "NewsCenterCategory.h"

#import "NewsCenterNetRequest.h"
#import "NewsCenterBLL.h"


#define kNewsCenterCategoryTableViewWidth                 250
#define kNewsCenterCategoryTableViewHeight                self.parentViewController.view.frame.size.height

@interface NewsCenterLevelOneTableViewController ()
{
    //coreData数据查询控制器,负责保存新闻中心栏目列表数据及控制
    NSFetchedResultsController      *_fetchedResultsController;
}
@end

@implementation NewsCenterLevelOneTableViewController

@synthesize categoryDelegate = _categoryDelegate;

- (void)dealloc {
    
        
    [super dealloc];
}

- (void)releaseTableFetchedDelegate
{
    if (isValid(_fetchedResultsController))
    {
        _fetchedResultsController.delegate = nil;
        [_fetchedResultsController release];
        _fetchedResultsController = nil;
    }
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
    
    self.tableView.frame = CGRectMake(0, 50, kNewsCenterCategoryTableViewWidth, self.parentViewController.view.frame.size.height);
    self.tableView.rowHeight = 50;
    self.tableView.backgroundColor = [UIColor whiteColor];
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _customRefreshControl.headerView.frame = CGRectMake(0.0f, -170.0f, kNewsCenterCategoryTableViewWidth, 170.0f);
    
    CGRect rect = _customRefreshControl.headerLastUpdatedLabel.frame;
    
    rect = CGRectMake((kNewsCenterCategoryTableViewWidth-rect.size.width)/2, rect.origin.y, rect.size.width, rect.size.height);
    
    _customRefreshControl.headerLastUpdatedLabel.frame = rect;
    
    rect = _customRefreshControl.headerStatusLabel.frame;
    
    rect = CGRectMake((kNewsCenterCategoryTableViewWidth-rect.size.width)/2, rect.origin.y, rect.size.width, rect.size.height);
    
    _customRefreshControl.headerStatusLabel.frame = rect;
    
    rect = _customRefreshControl.headerActivityView.frame;
    
    _customRefreshControl.headerActivityView.frame = CGRectMake(50, rect.origin.y, rect.size.width, rect.size.height);
    
    rect = _customRefreshControl.headerArrowImage.frame;
    
    _customRefreshControl.headerArrowImage.frame = CGRectMake(50, rect.origin.y, rect.size.width, rect.size.height);
    
    _fetchedResultsController = [NewsCenterCategory newsCenterCategoryResultsController];
    
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    
    if (_fetchedResultsController && ![_fetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self updateCategoryData];
    //lixiangai unreadcount
    [self getNewsCenterNoReadCount];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewsCenterNoReadCount) name:DOCUMENTUNREADNOTIFICATION object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    
    [self.tableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
}


/*!
 @function
 @abstract      从网络请求栏目列表数据
 
 @result        无
 */
-(void)updateCategoryData{
    
    Module *module = [[Userinfo shareUserinfo] getModuleWithIdentifier:kNewsCenterModuleIdentifier];
    
    [NewsCenterNetRequest executeAsynchronous:@selector(getNewsCenterCategory) callback:@selector(callbackRequestCategory:error:) backTarget:self args:module.unionId,@"0",nil];
}

//获取模块未读数
- (void)getNewsCenterNoReadCount
{
    /*
    Module *module = [[Userinfo shareUserinfo] getModuleWithIdentifier:kNewsCenterModuleIdentifier];
    
    [NewsCenterNetRequest executeAsynchronous:@selector(getModuleBadge) callback:@selector(callbackGetModuleBadge:error:) backTarget:self args:module.unionId,module.funcCode,nil];
     */
}


/*!
 @function
 @abstract      栏目列表数据请求完毕后的回调方法
 
 @param         data                        网络请求的原始数据
 @param         error                       网络请求错误,ASI提供的error
 
 @note
 
 @result        无
 */
-(void)callbackRequestCategory:(NSData *)data error:(NSError*)error
{
    NSData *bodyData = [NewsCenterNetRequest extractDataBodyFromResponsePackage:data];
    [NewsCenterBLL getNewsCenterCategorys:bodyData];
    //处理完成后隐藏下拉页面
    [self doneLoadingHeaderTableViewData];
}


- (void)callbackGetModuleBadge:(NSData *)data error:(NSError *)error
{
    
    //处理完成后隐藏下拉页面
    [self doneLoadingHeaderTableViewData];
    
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
    return [_fetchedResultsController sections].count;
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
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
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
- (void)configureCell:(NewsCenterLevelOneCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NewsCenterCategory *entity = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = entity.title;
    
    if ([entity.code isEqualToString:@"SPXW"])
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_new_TV.png" imageBundle:newsCenterBundle];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"list_icon.png" imageBundle:newsCenterBundle];
    }
    
    //add lixiangai
    if ([entity.unreadCount integerValue])
    {
        if ([cell viewWithTag:1000])
        {
            [cell viewWithTag:1000].hidden = NO;
            UILabel *lab  = (UILabel *) [cell viewWithTag:1200];
            lab.text = entity.unreadCount;
        }
        
    }
    else
    {
        [cell viewWithTag:1000].hidden = YES;
        
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
    NewsCenterLevelOneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[NewsCenterLevelOneCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.imageView.image = [UIImage imageNamed:@"list_icon.png" imageBundle:newsCenterBundle];
        
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
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        //lixiangai 未读条数
        UIImageView *unreadImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"digital_bg.png" imageBundle:mainBundle]];
        unreadImage.frame =CGRectMake(45, 10, 30, 30);
        [cell addSubview:unreadImage];
        [unreadImage release];
        unreadImage.tag = 1000;
        unreadImage.hidden = YES;
        
        UILabel *unreadLable = [[UILabel alloc] initWithFrame:CGRectMake(2,2, 25, 25)];
        unreadLable.tag = 1200;
        [unreadImage addSubview:unreadLable];
        [unreadLable release];
        unreadLable.textColor = [UIColor whiteColor];
        unreadLable.backgroundColor = [UIColor clearColor];
        unreadLable.textAlignment = NSTextAlignmentCenter;
        unreadLable.font = [UIFont boldSystemFontOfSize:20];
        unreadLable.adjustsFontSizeToFitWidth = YES;
        unreadLable.minimumScaleFactor = 10;
        //end
        
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

/*!
 @function
 @abstract      UITableView的delegate方法
 
 @param         tableView                       被实现协议的tableView
 @param         indexPath                       当前cell的位置
 
 @note
 
 @result        无
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCenterCategory *category= [_fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([_categoryDelegate respondsToSelector:@selector(didSelectedLevelOne:)]) {
        
        [_categoryDelegate didSelectedLevelOne:category];
    }
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
    
    if (_fetchedResultsController == controller)
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
    if (_fetchedResultsController == controller)
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
    if (_fetchedResultsController == controller)
    {
        [self.tableView endUpdates];
    }
}

/*!
 @function
 @abstract      override CustomRefreshTableViewController方法 实现下拉刷新时，重新请求数据
 
 @param         view                      被实现协议的controller
 @param
 
 @note          tableView结束更新
 
 @result        无
 */
- (void)refreshTableHeaderDidTriggerRefresh:(CustomRefreshControl*)view {
    
    [self updateCategoryData];
    [self getNewsCenterNoReadCount]; //lixiangai
}

@end
