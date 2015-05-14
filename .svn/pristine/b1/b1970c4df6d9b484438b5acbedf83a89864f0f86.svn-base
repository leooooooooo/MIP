//
//  NewsflashLevelTwoTableViewController.h
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "CustomRefreshTableViewController.h"
#import "MBProgressHUD.h"

#import "NewsflashEntity.h"

@interface NewsflashLevelTwoTableViewController : CustomRefreshTableViewController<NSFetchedResultsControllerDelegate>
{
    UIImageView                       * emptyImageView;
    UIActivityIndicatorView           *activityView;    //上拉刷新等待提示
    
    MBProgressHUD                     *hud;
}

- (void)updateNewsflashEntityWithParentEntity:(NewsflashEntity *)entity;

@end
