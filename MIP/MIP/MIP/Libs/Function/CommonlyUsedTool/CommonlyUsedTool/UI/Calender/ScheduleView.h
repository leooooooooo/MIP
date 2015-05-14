//
//  ScheduleView.h
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-4-1.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleInfo.h"

@protocol ScheduleViewDelegate <NSObject>

- (void)didSelectScheduleWith:(ScheduleInfo *)schedule;

@end

@interface ScheduleView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    UITableView       *scheduleTable;
    
    UIButton          *reflashBtn;
    UIButton          *addScheduleBtn;
    UIButton          *editScheduleBtn;
    
    NSArray           *scheduleArr;
    
    id<ScheduleViewDelegate> schViewDelegate;
    
    NSDate            *curDate;
}

@property (retain, nonatomic) UIButton          *reflashBtn;
@property (retain, nonatomic) UIButton          *addScheduleBtn;
@property (retain, nonatomic) UIButton          *editScheduleBtn;
@property (retain, nonatomic) NSArray           *scheduleArr;
@property (assign, nonatomic) id<ScheduleViewDelegate> schViewDelegate;
@property (assign, nonatomic) UITableView       *scheduleTable;
@property (retain, nonatomic) NSDate            *curDate;

- (void)reflashScheduleList:(NSArray *)arr;

@end
