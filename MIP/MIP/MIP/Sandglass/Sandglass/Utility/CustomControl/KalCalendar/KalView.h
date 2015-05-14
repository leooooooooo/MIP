/* 
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>
#import "CustomPopListView.h"

@class KalGridView, KalLogic, KalDate;
@protocol KalViewDelegate, KalDataSourceCallbacks;

/*
 *    KalView
 *    ------------------
 *
 *    Private interface
 *
 *  As a client of the Kal system you should not need to use this class directly
 *  (it is managed by KalViewController).
 *
 *  KalViewController uses KalView as its view.
 *  KalView defines a view hierarchy that looks like the following:
 *
 *       +-----------------------------------------+
 *       |                header view              |
 *       +-----------------------------------------+
 *       |                                         |
 *       |                                         |
 *       |                                         |
 *       |                 grid view               |
 *       |             (the calendar grid)         |
 *       |                                         |
 *       |                                         |
 *       +-----------------------------------------+
 *       |                                         |
 *       |           table view (events)           |
 *       |                                         |
 *       +-----------------------------------------+
 *
 */
int slideState;

@interface KalView : UIView
{
  UILabel *headerTitleLabel;
  KalGridView *gridView;
  UITableView *tableView;
//  UIImageView *shadowView;
  id<KalViewDelegate> delegate;
  KalLogic *logic;
  NSDictionary *schduleDictionary;
    UIView *headerView;
    UIView *contentView;
    
    CustomPopListView   *popListView;
    UIDatePicker        *datePicker;
}

@property (nonatomic, assign) id<KalViewDelegate> delegate;
@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readonly) KalDate *selectedDate;
@property (nonatomic, retain)NSDictionary *schduleDictionary;
- (id)initWithFrame:(CGRect)frame delegate:(id<KalViewDelegate>)delegate logic:(KalLogic *)logic;
- (BOOL)isSliding;
- (void)selectDate:(KalDate *)date;
- (void)markTilesForDates:(NSArray *)dates;
- (void)redrawEntireMonth;

// These 3 methods are exposed for the delegate. They should be called 
// *after* the KalLogic has moved to the month specified by the user.
- (void)slideDown;
- (void)slideUp;
-(void)slideLeft;
-(void)slideRight;
- (void)jumpToSelectedMonth;    // change months without animation (i.e. when directly switching to "Today")

//add by kangqijun 点击日期刷新Label
- (void)setDateLabelWithDate:(NSDate *)date;


@end

#pragma mark -

@class KalDate;

@protocol KalViewDelegate


- (void)didSelectDate:(KalDate *)date;
@optional
-(void)showPreviousMonthSlideDown;
-(void)showFollowingMonthSlideUp;
-(void)showPreviousMonthSlideRight;
-(void)showFollowingMonthSlideLeft;

//and by kangqijun 跳转到某日
- (void)jumpToDateWith:(NSDate *)date;

@end
