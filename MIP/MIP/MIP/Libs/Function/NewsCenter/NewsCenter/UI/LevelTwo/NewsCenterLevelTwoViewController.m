//
//  NewsCenterLevelTwoViewController.m
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import "NewsCenterLevelTwoViewController.h"

#import "NewsCenterBLL.h"

#import "PlayMovieViewController.h"

@interface NewsCenterLevelTwoViewController ()

@property(nonatomic, retain) NewsCenterCategory *currentCategory;
@end

@implementation NewsCenterLevelTwoViewController
@synthesize currentCategory;
@synthesize newsClickIndex;
@synthesize newsCenterLevelTwoView;

- (void)dealloc {
    
    newsCenterLevelTwoTableViewController.documentDelegate = nil;
    [newsCenterLevelTwoTableViewController release];
    
    [super dealloc];
}

- (id)initWithCategory:(NewsCenterCategory *)category
{
    self = [super init];
    if (self)
    {
        self.currentCategory = category;
    }
    return self;
}

- (void)loadView
{
    newsCenterLevelTwoView = [[NewsCenterLevelTwoView alloc] initWithFrame:CGRectMake(0, 0, self.parentViewController.view.frame.size.width, self.parentViewController.view.frame.size.height)];
    newsCenterLevelTwoView.m_delegate = self;
    
    [newsCenterLevelTwoView.closeBtn addTarget:self action:@selector(closeDocTwoLevelData:) forControlEvents:UIControlEventTouchUpInside];
    [newsCenterLevelTwoView.searchBtn addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [newsCenterLevelTwoView.filtrateBtn addTarget:self action:@selector(filtrateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [newsCenterLevelTwoView.backSearchBtn addTarget:self action:@selector(backSearchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [newsCenterLevelTwoView.backBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    newsCenterLevelTwoView.searchTextField.delegate = self;
    
    self.view = newsCenterLevelTwoView;
    [newsCenterLevelTwoView release];
    
    UIButton *hotNewsButton = [newsCenterLevelTwoView.segmentedControl buttonAtIndex:0];
    [hotNewsButton addTarget:self action:@selector(hotNewsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *allNewsButton = [newsCenterLevelTwoView.segmentedControl buttonAtIndex:1];
    [allNewsButton addTarget:self action:@selector(allNewsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    newsCenterLevelTwoTableViewController = [[NewsCenterLevelTwoTableViewController alloc] initWithStyle:UITableViewStylePlain];
    newsCenterLevelTwoTableViewController.currentCategory = self.currentCategory;
    
    newsCenterLevelTwoTableViewController.documentDelegate = self;
    
    newsCenterLevelTwoTableViewController.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:newsCenterLevelTwoTableViewController];
    [self.view addSubview:newsCenterLevelTwoTableViewController.view];
}

- (void)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [newsCenterLevelTwoView loadNewsWithCategory:self.currentCategory];
    
    [self updateNewsCenterDocumentWithCategory:self.currentCategory];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//搜索
- (void)searchButtonClicked:(id)sender;
{
    
    if (newsCenterLevelTwoView.searchTextField.text == nil || [newsCenterLevelTwoView.searchTextField.text isEqualToString:@""])
    {
        UIAlertView *warnAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入搜索条件！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        
        [warnAlert show];
        [warnAlert release];
        
        return;
    }
    
    self.currentCategory.keyword = newsCenterLevelTwoView.searchTextField.text;
    [newsCenterLevelTwoTableViewController updateDocumentsWithCategory:self.currentCategory];
    
    [newsCenterLevelTwoView.searchTextField resignFirstResponder];
}

//退出搜索
- (void)backSearchButtonClicked:(id)sender
{
    newsCenterLevelTwoView.searchTextField.text = @"";
    newsCenterLevelTwoTableViewController.tableView.contentOffset = CGPointMake(0, 0);
    
    self.currentCategory.keyword = newsCenterLevelTwoView.searchTextField.text;
    [newsCenterLevelTwoTableViewController updateDocumentsWithCategory:self.currentCategory];
    
    [newsCenterLevelTwoView showSearchInputView];
}

//筛选
- (void)filtrateButtonClicked:(id)sender
{
    [newsCenterLevelTwoView showFiltrateViewWith:self.currentCategory.filters];
}

//筛选弹出框
- (void)filterNewsCenterDcumentWith:(NSString *)filterkey
{
    newsCenterLevelTwoTableViewController.tableView.contentOffset = CGPointMake(0, 0);
    
    self.currentCategory.keyword = filterkey;
//    获取对应分类的ID
    NSString *typeID = [NewsCenterBLL getNewsTypeIdByName:filterkey];
    
    [newsCenterLevelTwoTableViewController updateDocumentsWithCategory:self.currentCategory  typeID:typeID];
}

//关闭
- (void)closeDocTwoLevelData:(id)sender
{
    [self.navScrollController popViewControllerAnimated:YES];
}

//搜索结果
- (void)searchNewsCenterResultCount:(int)_count
{
    if (isValid(self.currentCategory.keyword)&&![self.currentCategory.keyword isEqualToString:@""]) {
        [newsCenterLevelTwoView showSearchResultViewWithKeyword:self.currentCategory.keyword count:_count];
    }else{
        NSString *filterkey = [NewsCenterBLL getNewsTypeNameByID:self.currentCategory.typeID];
        [newsCenterLevelTwoView showSearchResultViewWithKeyword:filterkey count:_count];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateNewsCenterDocumentWithCategory:(NewsCenterCategory *)entity
{
    newsCenterLevelTwoView.searchTextField.text = @"";
    newsCenterLevelTwoTableViewController.tableView.contentOffset = CGPointMake(0, 0);
    
    self.currentCategory.keyword = newsCenterLevelTwoView.searchTextField.text;
    [newsCenterLevelTwoView showSearchInputView];
    
    self.currentCategory = entity;
    
    newsCenterLevelTwoTableViewController.tableView.contentOffset = CGPointMake(0, 0);
    
    
    
//    if ([self.currentCategory.code isEqualToString:@"XWXX"]) {
//        if (newsClickIndex == ALL_NEWS) {
//            [newsCenterLevelTwoTableViewController updateDocumentsWithCategory:entity newsType:ALL_NEWS];
//        }else{
//            [newsCenterLevelTwoTableViewController updateDocumentsWithCategory:entity newsType:HOT_NEWS];
//        }
//        
//    }else{
        [newsCenterLevelTwoTableViewController updateDocumentsWithCategory:entity newsType:OTHERS];
//    }
    
    if ([self.currentCategory.code isEqualToString:@"DZGB"])
    {
        [newsCenterLevelTwoView hiddenFiltrateView];
        
        newsCenterLevelTwoView.searchTextField.placeholder = @"请输入日期搜索";
        
    }else if([self.currentCategory.code isEqualToString:@"TZGG"]||[self.currentCategory.code isEqualToString:@"AQRB"]||[self.currentCategory.code isEqualToString:@"XMDC"]){
        [newsCenterLevelTwoView hiddenFiltrateView];
        
        newsCenterLevelTwoView.searchTextField.placeholder = @"请输入关键字搜索";
        
        newsCenterLevelTwoView.searchTextField.keyboardType = UIKeyboardTypeDefault;
    }else if([self.currentCategory.code isEqualToString:@"XWXX"]){
        if (newsClickIndex == ALL_NEWS) {
            [newsCenterLevelTwoView showFiltrateView];
             
             newsCenterLevelTwoView.searchTextField.placeholder = @"请输入关键字搜索";
             
             newsCenterLevelTwoView.searchTextField.keyboardType = UIKeyboardTypeDefault;
        }else{
            [newsCenterLevelTwoView showFiltrateView];
            
            newsCenterLevelTwoView.searchTextField.placeholder = @"请输入关键字搜索";
            
            newsCenterLevelTwoView.searchTextField.keyboardType = UIKeyboardTypeDefault;
        }
    }
}

- (void)changeToShowSegmentedControl{
    [newsCenterLevelTwoView changeToShowSegmentedControlView];
    [newsCenterLevelTwoTableViewController changeToShowSegmentedControl];
}

- (void)changeToHideSegmentedControl{
    [newsCenterLevelTwoView changeToHideSegmentedControlView];
    [newsCenterLevelTwoTableViewController changeToHideSegmentedControl];
}

- (void)hotNewsButtonClick:(id)sender{
    DLog(@"hotNews");
    self.newsClickIndex = hotNews;
    [self updateNewsCenterDocumentWithCategory:currentCategory];
}

- (void)allNewsButtonClick:(id)sender{
    DLog(@"allNews");
    self.newsClickIndex = allNews;
    [self updateNewsCenterDocumentWithCategory:currentCategory];
}

#pragma mark NewsCenterLevelTwoTableViewDelegate
- (void)playThisVeddioRecordWith:(NewsCenterDocument *)document
{
    PlayMovieViewController *movieViewController = [[PlayMovieViewController alloc] initWithDocument:document];
    [self.navigationController pushViewController:movieViewController animated:YES];
    [movieViewController release];
}

- (void)tableViewDidScroll
{
    [newsCenterLevelTwoView.searchTextField resignFirstResponder];
}

#pragma mark textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchButtonClicked:nil];
    
    return YES;
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
