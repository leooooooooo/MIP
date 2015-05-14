//
//  NewsflashLevelOneViewController.h
//  Newsflash
//
//  Created by kangqijun on 14-3-17.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "BaseScrollViewController.h"

#import "NewsflashLevelOneView.h"

#import "NewsflashLevelOneTableViewController.h"

#import "NewsflashLevelTwoViewController.h"

@interface NewsflashLevelOneViewController : BaseScrollViewController<NewsflashLevelOneTableViewDelegate>
{
    NewsflashLevelOneView  *_levelOneView;
    
    NewsflashLevelOneTableViewController *_categoryTableViewController;
    
    NewsflashLevelTwoViewController      *newsflashLevelTwoViewController;
}

@end
