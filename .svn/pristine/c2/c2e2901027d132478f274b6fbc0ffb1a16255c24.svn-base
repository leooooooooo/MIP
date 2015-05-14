//
//  FilterCompanyViewController.m
//  Contacts
//
//  Created by mengxianglei on 14-5-14.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import "FilterCompanyViewController.h"
#import "FilterCompanyTableViewController.h"

@implementation FilterCompanyViewController

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
}

- (void)loadView
{
    [super loadView];
    
    m_filterCompanyView = [[FilterCompanyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    m_filterCompanyView.title = @"企业列表";
    m_filterCompanyView.delegate = self;
    
    self.view = m_filterCompanyView;
    
    filterCompanyCtrl = [[FilterCompanyTableViewController alloc] initWithStyle:UITableViewStylePlain];

    //将筛选通讯录画面添加入子控制器列表
    [self addChildViewController:filterCompanyCtrl];
    
    m_filterCompanyView.filterBtn.hidden = YES;
    //将画面表示到UI上
    [m_filterCompanyView setSubView:filterCompanyCtrl.view];
    
    [filterCompanyCtrl searchByKey:nil];
}

- (void) search:(NSString *)key
{
    if ([self.childViewControllers count] > 0) {
        id tmpViewCtrl = [self.childViewControllers lastObject];
        if ([tmpViewCtrl respondsToSelector:@selector(searchByKey:)]) {
            [tmpViewCtrl searchByKey : key];
        }
    }
}

- (void) backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) dealloc
{
    [filterCompanyCtrl release];
    [m_filterCompanyView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
