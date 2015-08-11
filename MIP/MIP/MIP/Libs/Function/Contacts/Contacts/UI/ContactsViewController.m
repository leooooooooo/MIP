//
//  ContactsViewController.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/11.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactsNetRequest.h"
#import "ContactsView.h"
#import "PersonalTableViewController.h"
#import "ComLevelOneTableViewController.h"
#import "FilterCompanyViewController.h"
#import "FullCompanyInfo.h"


#define FullContactsFrame       CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)

@interface ContactsViewController () <ContactsViewDelegate, ContactsTabViewDelegate>
{
    PersonalTableViewController     *personalCtrl;
    ComLevelOneTableViewController  *companyCtrl;
}

@end

@implementation ContactsViewController

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
    
    m_contactsView = [[ContactsView alloc] initWithFrame:FullContactsFrame];
    m_contactsView.delegate = self;
    m_contactsView.tabDelegate = self;
    
    Userinfo *userinfo = [Userinfo shareUserinfo];
    
    selectCompanyid = userinfo.companyid;
    selectCompanyname = userinfo.company;
    
    [self tabButtonClick:0];
    
    self.view = m_contactsView;
}

- (void) dealloc
{
    [personalCtrl release];
    
    [companyCtrl release];
    
    [m_contactsView release];
    
    [super dealloc];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    m_contactsView.filterBtn.hidden = YES;
}

- (void) backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) filterCompanyClick
{
    m_contactsView.filterBtn.hidden = YES;
    FilterCompanyViewController *filterCtrl = [[FilterCompanyViewController alloc] init];
    [self.navigationController pushViewController:filterCtrl animated:YES];
    [filterCtrl release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshContractsForCom:) name:@"refreshContractsForCom" object:nil];
}

- (void) refreshContractsForCom:(NSNotification *)notifaction
{
    FullCompanyInfo *tmpInfo = [notifaction object];
    selectCompanyid = tmpInfo.companyid;
    selectCompanyname = [NSString stringWithFormat:@"%@",tmpInfo.companyname];
    [self tabButtonClick:0];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) tabButtonClick:(NSInteger)index
{
    //根据点击，在子控制器中寻找相应的画面，若找到，则将其移动到子控制器列表的末端，以帮助检索功能调用相应的方法。
    //若未找到，则新建相应的控制器并将其添加到子控制器列表的末端。
    //将相应的画面展示到界面上。
    switch (index) {
        case 0://个人通讯录
        {
            if (!personalCtrl) {
                personalCtrl = [[PersonalTableViewController alloc] initWithStyle:UITableViewStylePlain];
            }else {
                [personalCtrl removeFromParentViewController];
            }
            
            personalCtrl.selectCompanyid = selectCompanyid;
            personalCtrl.selectCompanyname = selectCompanyname;
            
            //将个人通讯录画面添加入子控制器列表
            [self addChildViewController:personalCtrl];
            
            m_contactsView.filterBtn.hidden = YES;
            //将画面表示到UI上
            [m_contactsView setSubView:personalCtrl.view];
            
            [personalCtrl searchByKey:nil];
            
        }
            break;
        case 1://企业通讯录
        {
            if (!companyCtrl) {
                companyCtrl = [[ComLevelOneTableViewController alloc] initWithStyle:UITableViewStylePlain];
            }else {
                [companyCtrl removeFromParentViewController];
            }
            
            //将企业通讯录一级画面添加入子控制器列表
            [self addChildViewController:companyCtrl];

            m_contactsView.filterBtn.hidden = YES;
            [m_contactsView setSubView:companyCtrl.view];
            
            [companyCtrl searchByKey:nil];
        }
            break;
        default:
            break;
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
