//
//  MyAppListViewController.h
//  MyAppCenter
//
//  Created by mengxianglei on 2014/04/15.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAppCenterView.h"

@class ApplicationType;

@interface MyAppListViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate,UITextFieldDelegate>
{
    MyAppCenterView *m_appCenterView;
    ApplicationType *m_appType;
    UIButton        *backSearchBtn; //退出搜索按钮
    UITextField     *searchTextField;
}
@property (nonatomic, retain) ApplicationType *appType;
@property (nonatomic, retain) UITableView *m_tableView;
@property (nonatomic, retain) NSArray *m_appList;

@end
