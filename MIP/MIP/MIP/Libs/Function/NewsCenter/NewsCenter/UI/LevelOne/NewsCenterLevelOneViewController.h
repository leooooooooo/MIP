//
//  NewCenterLevelOneViewController.h
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import "BaseScrollViewController.h"

#import "NewsCenterLevelOneView.h"

#import "NewsCenterLevelOneTableViewController.h"

#import "NewsCenterLevelTwoViewController.h"

@interface NewsCenterLevelOneViewController : BaseScrollViewController<NewsCenterLevelOneTableViewDelegate>
{
    NewsCenterLevelOneView *_levelOneView;
    
    NewsCenterLevelOneTableViewController *_categoryTableViewController;
    
    NewsCenterLevelTwoViewController  *newsCenterLevelTwoViewController;
}

- (void)releaseFetchedDelegate;

@end
