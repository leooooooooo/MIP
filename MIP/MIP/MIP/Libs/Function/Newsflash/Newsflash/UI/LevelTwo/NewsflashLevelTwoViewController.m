//
//  NewsflashLevelTwoViewController.m
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "NewsflashLevelTwoViewController.h"

@interface NewsflashLevelTwoViewController ()

@end

@implementation NewsflashLevelTwoViewController
- (void)dealloc {
    
    [newsflashLevelTwoView release];
    newsflashLevelTwoView = nil;
    
    [newsflashLevelTwoTableViewController release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        newsflashLevelTwoView = [[NewsflashLevelTwoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [newsflashLevelTwoView.backBtn addTarget:self action:@selector(closeDocTwoLevelData:) forControlEvents:UIControlEventTouchUpInside];
        self.view = newsflashLevelTwoView;
        
        newsflashLevelTwoTableViewController = [[NewsflashLevelTwoTableViewController alloc] initWithStyle:UITableViewStylePlain];
        newsflashLevelTwoTableViewController.view.backgroundColor = [UIColor whiteColor];
        [self addChildViewController:newsflashLevelTwoTableViewController];
        [self.view addSubview:newsflashLevelTwoTableViewController.view];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//关闭
- (void)closeDocTwoLevelData:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateNewsflashEntityWithParent:(NewsflashEntity *)entity
{
    [newsflashLevelTwoView setTitleLabelText:entity.name];
    newsflashLevelTwoTableViewController.tableView.contentOffset = CGPointMake(0, 0);
    [newsflashLevelTwoTableViewController updateNewsflashEntityWithParentEntity:entity];
}
@end
