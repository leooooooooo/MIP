//
//  NewsCenterLevelTwoTableViewController.h
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import <UIKit/UIKit.h>

#import "CustomRefreshTableViewController.h"

#import "MBProgressHUD.h"

#import "NewsCenterCategory.h"

#import "PDFToolViewController.h"

#import "PDFListViewController.h"

#import "NewsCenterDocument.h"

#import "ContentViewController.h"

@protocol NewsCenterLevelTwoTableViewDelegate<NSObject>

@optional

- (void)playThisVeddioRecordWith:(NewsCenterDocument *)document;

- (void)tableViewDidScroll;

@end

@interface NewsCenterLevelTwoTableViewController : CustomRefreshTableViewController<NSFetchedResultsControllerDelegate,PDFListViewDelegate,ContentViewControllerDelegate,PDFToolDelegate>
{
    UIImageView                       * emptyImageView;
    UIActivityIndicatorView           *activityView;    //上拉刷新等待提示
    
    MBProgressHUD                     *hud;
    id<NewsCenterLevelTwoTableViewDelegate> _documentDelegate;
}

@property (assign, nonatomic) id<NewsCenterLevelTwoTableViewDelegate> documentDelegate;
@property (nonatomic, retain) NewsCenterCategory *currentCategory;

- (void)updateDocumentsWithCategory:(NewsCenterCategory *)category;
- (void)updateDocumentsWithCategory:(NewsCenterCategory *)category  typeID:(NSString *)aTypeID;
- (void)updateDocumentsWithCategory:(NewsCenterCategory *)category newsType:(NewsType)newsType;

- (void)changeToShowSegmentedControl;
- (void)changeToHideSegmentedControl;

@end
