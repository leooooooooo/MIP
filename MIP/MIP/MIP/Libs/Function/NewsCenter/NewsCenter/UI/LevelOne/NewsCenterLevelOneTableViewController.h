//
//  NewsCenterLevelOneTableViewController.h
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import "CustomRefreshTableViewController.h"
@class NewsCenterCategory;

@protocol NewsCenterLevelOneTableViewDelegate <NSObject>

@optional
-(void)didSelectedLevelOne:(NewsCenterCategory *)newsCenterCategory;

@end

@interface NewsCenterLevelOneTableViewController : CustomRefreshTableViewController<NSFetchedResultsControllerDelegate>{
    id<NewsCenterLevelOneTableViewDelegate> _categoryDelegate;
}

@property(nonatomic,assign)id<NewsCenterLevelOneTableViewDelegate> categoryDelegate;

- (void)releaseTableFetchedDelegate;

@end
