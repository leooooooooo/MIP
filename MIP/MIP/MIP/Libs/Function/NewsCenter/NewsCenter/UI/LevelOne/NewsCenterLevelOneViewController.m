//
//  NewCenterLevelOneViewController.m
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import "NewsCenterLevelOneViewController.h"

@interface NewsCenterLevelOneViewController ()

@end

@implementation NewsCenterLevelOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc {
    
    [self releaseFetchedDelegate];
    [super dealloc];
}

- (void)releaseFetchedDelegate
{
    [_categoryTableViewController releaseTableFetchedDelegate];
}

// This is where subclasses should create their custom view hierarchy if they aren't using a nib. Should never be called directly.
- (void)loadView
{
    _levelOneView = [[NewsCenterLevelOneView alloc] initWithFrame:CGRectMake(0, 0, self.parentViewController.view.frame.size.width, self.parentViewController.view.frame.size.height)];//减去的15个像素为左边的阴影
    
    [_levelOneView.closeBtn addTarget:self action:@selector(closeDocTwoLevelData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = _levelOneView;
    [_levelOneView release];
}

//关闭
- (void)closeDocTwoLevelData:(id)sender
{
    [self.navScrollController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _categoryTableViewController = [[NewsCenterLevelOneTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    _categoryTableViewController.categoryDelegate = self;
    
    [self addChildViewController:_categoryTableViewController];
    [self.view addSubview:_categoryTableViewController.view];
    
    [_categoryTableViewController release];
}

-(void)didSelectedLevelOne:(NewsCenterCategory *)newsCenterCategory{
    self.leftMoveDistance = 153;//在二级栏目被呼出时,一级栏目向左移动的距离
    
    if (!self.isNextInitialize)
    {
        newsCenterLevelTwoViewController = [[NewsCenterLevelTwoViewController alloc] initWithCategory:newsCenterCategory];
        
        newsCenterLevelTwoViewController.leftMoveEndDistance = 195; //二级栏目呼出后，向左可移动的区间
        [self.navigationController pushViewController:newsCenterLevelTwoViewController animated:YES];
        [newsCenterLevelTwoViewController release];
    }
    else
    {
        [newsCenterLevelTwoViewController presentViewControllerAfterSwipeRight];
    }
    
    newsCenterLevelTwoViewController.newsCenterLevelTwoView.filtrateStr = @"";
    
    [newsCenterLevelTwoViewController changeToHideSegmentedControl];
    
//    [newsCenterLevelTwoViewController updateNewsCenterDocumentWithCategory:newsCenterCategory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
