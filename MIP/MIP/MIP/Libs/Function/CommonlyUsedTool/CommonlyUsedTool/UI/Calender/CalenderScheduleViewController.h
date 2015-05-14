//
//  CalenderScheduleViewController.h
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KalViewController.h"
#import "ScheduleView.h"
#import "HistoryView.h"
#import "ScheduleTimePickerView.h"
#import "ScheduleTimePickerViewController.h"

@interface CalenderScheduleViewController : UIViewController <KalViewControlleDelegate,ScheduleViewControllerDelegate,ScheduleViewDelegate>
{
    ScheduleView             *scheduleView;
    HistoryView              *historyView;
    ScheduleTimePickerView   *scheduleTimePickerView;
    NSDate                   *selectDate;
}

@property (retain, nonatomic) NSDate                   *selectDate;

@end
