//
//  NewsflashLevelOneTableViewController.h
//  Newsflash
//
//  Created by kangqijun on 14-3-17.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "CustomRefreshTableViewController.h"
@class NewsflashEntity;

@protocol NewsflashLevelOneTableViewDelegate <NSObject>

@optional
-(void)didSelectedLevelOne:(NewsflashEntity *)newsflashCategory;

@end
@interface NewsflashLevelOneTableViewController : CustomRefreshTableViewController<NSFetchedResultsControllerDelegate>{
    id<NewsflashLevelOneTableViewDelegate> _categoryDelegate;
}

@property(nonatomic,assign)id<NewsflashLevelOneTableViewDelegate> categoryDelegate;



@end
