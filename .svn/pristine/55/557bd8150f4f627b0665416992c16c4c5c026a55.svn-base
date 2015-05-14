//
//  NewsflashLevelOneViewController.m
//  Newsflash
//
//  Created by kangqijun on 14-3-17.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "NewsflashLevelOneViewController.h"
#import "NewsflashContentViewController.h"

@interface NewsflashLevelOneViewController ()
{
    NewsflashContentViewController *_contentViewController;
    NewsflashEntity *selectNews;
}
@end

@implementation NewsflashLevelOneViewController
- (void) dealloc {
    
    [_levelOneView release];
    _levelOneView = nil;
    
    [super dealloc];
}

// This is where subclasses should create their custom view hierarchy if they aren't using a nib. Should never be called directly.
- (void)loadView
{
    _levelOneView = [[NewsflashLevelOneView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 70, SCREEN_HEIGHT)];//减去的15个像素为左边的阴影
    
    self.view = _levelOneView;
    
    _categoryTableViewController = [[NewsflashLevelOneTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    _categoryTableViewController.categoryDelegate = self;
    
    [self addChildViewController:_categoryTableViewController];
    [self.view addSubview:_categoryTableViewController.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)didSelectedLevelOne:(NewsflashEntity *)newsflashEntity{
    if (newsflashEntity.url && newsflashEntity.url.length > 0) {
        selectNews = newsflashEntity;
        [self openContent:newsflashEntity.url withTitle:newsflashEntity.name];
        return;
    }
    
    if (!self.isNextInitialize) {
        newsflashLevelTwoViewController = [[NewsflashLevelTwoViewController alloc] init];
        [self.parentViewController.parentViewController.navigationController pushViewController:newsflashLevelTwoViewController animated:YES];
        [newsflashLevelTwoViewController release];
    }
    else {
        [newsflashLevelTwoViewController presentViewControllerAfterSwipeRight];
    }
    [newsflashLevelTwoViewController updateNewsflashEntityWithParent:newsflashEntity];
}

- (void)openContent:(NSString *)content withTitle:(NSString *)name
{
    if (!isValid(content)||[content isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"当前条目地址为空！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    _contentViewController = [[NewsflashContentViewController alloc] init];
    [self presentViewController:_contentViewController animated:YES completion:NULL];
    
    NSURL *url = [NSURL URLWithString:[content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_contentViewController.contentWebView loadRequest:[NSURLRequest requestWithURL:url]];
    _contentViewController.titleLabel.text = name;
    [_contentViewController release];
    
    selectNews.readType = [NSNumber numberWithInt:Readed];
    [selectNews.managedObjectContext save:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
