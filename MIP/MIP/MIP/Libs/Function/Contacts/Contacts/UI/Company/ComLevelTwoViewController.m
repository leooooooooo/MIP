//
//  ComLevelTwoViewController.m
//  Contacts
//
//  Created by lu_sicong on 2014/04/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ComLevelTwoViewController.h"
#import "ComLevelTwoView.h"
#import "ComLevelTwoTableViewController.h"

#define FullContactsFrame       CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)

@interface ComLevelTwoViewController ()<ContactsViewDelegate>
{
    NSString *m_strCompanyName;
    
    NSMutableArray *m_searchResultList;
    
    NSString *m_strKey;
    
    ComLevelTwoTableViewController *m_subCtrl;
}

@end

@implementation ComLevelTwoViewController

@synthesize strCompanyName = m_strCompanyName, m_searchResultList, m_strKey;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    m_contactsView = [[ComLevelTwoView alloc] initWithFrame:FullContactsFrame];
    m_contactsView.delegate = self;
    m_contactsView.title = m_strCompanyName;
    
    m_subCtrl = [[ComLevelTwoTableViewController alloc] initWithStyle:UITableViewStylePlain];

    if (m_searchResultList) {
        [m_subCtrl setSearchResult:m_searchResultList withCompany:m_strCompanyName andKey:m_strKey];
    }else {
        m_subCtrl.strCompanyName = m_strCompanyName;
    }
    
    [self addChildViewController:m_subCtrl];
    
    [m_contactsView setSubView:m_subCtrl.view];
    
    self.view = m_contactsView;
}

- (void)setStrCompanyName:(NSString *)strCompanyName
{
    m_strCompanyName = strCompanyName;
    m_contactsView.title = m_strCompanyName;
}

- (void)setM_searchResultList:(NSMutableArray *)searchResultList
{
    m_searchResultList = searchResultList;
    if (m_searchResultList) {
        [m_subCtrl setSearchResult:m_searchResultList withCompany:m_strCompanyName andKey:m_strKey];
    }else {
        m_subCtrl.strCompanyName = m_strCompanyName;
    }
}

- (void)dealloc
{
    [m_subCtrl release];
    
//    [m_contactsView release];
    
    [super dealloc];
}

- (void) backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) search:(NSString *)key
{
    if (!key || key.length > 0) {
        m_subCtrl.strSubKey = key;
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入关键字！"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
