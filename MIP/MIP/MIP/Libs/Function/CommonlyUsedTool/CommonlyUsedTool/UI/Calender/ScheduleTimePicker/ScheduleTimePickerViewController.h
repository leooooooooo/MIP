//
//  ScheduleTimePickerViewController.h
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-4-1.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleTimePickerView.h"
#import "ScheduleInfo.h"

@protocol ScheduleViewControllerDelegate <NSObject>

- (void)reflashScheduleTableView:(NSDate *)date;
- (void)cancelToAddASchedule;

@end

@interface ScheduleTimePickerViewController : UIViewController
{
    ScheduleTimePickerView *scheduleTimePickerView;
    
    id<ScheduleViewControllerDelegate> scheduleDelegate;
    
    NSDate                 *curDate;
}

@property (assign, nonatomic) id<ScheduleViewControllerDelegate> scheduleDelegate;
@property (retain, nonatomic) NSDate                 *curDate;

- (id)initWithSchedule:(ScheduleInfo *)schedule;

@end
