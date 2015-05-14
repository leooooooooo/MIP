//
//  CustomRefreshTableViewController.h

//  使用说明:下拉刷新的UITableViewController模板
//  提供功能:下拉刷新
//  刷新触发函数:- (void)refreshTableHeaderDidTriggerRefresh:(CustomRefreshControl*)view为CustomRefreshControlDelegate的代理方法之一
//  当数据加载结束时需使用- (void)doneLoadingHeaderTableViewData此方法将UITableView复位
//  Created by  on 13-3-22.
//  Copyright (c) 2013年 navy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomRefreshControl.h"

@interface CustomRefreshTableViewController : UITableViewController <CustomRefreshControlDelegate> {
    
    CustomRefreshControl        *_customRefreshControl;
    
    BOOL                         _isAllowAutoFooterLoading;
}


//下拉更新结束后，调用，用于scrollView复位
- (void)doneLoadingHeaderTableViewData;

//自动加载完毕后,tableView复位
- (void)doneLoadingAutoFooterTableViewData;

@end
