//
//  ScheduleTimePickerView.h
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-4-1.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleInfo.h"

@interface ScheduleTimePickerView : UIView <UITextViewDelegate>
{
    UIButton   *sureBtn;
    UIButton   *cancelBtn;
    UIButton   *startBtn;
    UIButton   *endBtn;
    UIDatePicker *datePicker;
    
    UITextView  *inputTextView;
    UILabel     *startTimeLab;
    UILabel     *endTimeLab;
    
    UIScrollView   *bgScrollView;
}

@property (retain,nonatomic) UIButton   *sureBtn;
@property (retain,nonatomic) UIButton   *cancelBtn;
@property (retain,nonatomic) UIButton   *startBtn;
@property (retain,nonatomic) UIButton   *endBtn;
@property (retain,nonatomic) UIDatePicker *datePicker;

@property (retain,nonatomic) UITextView  *inputTextView;
@property (retain,nonatomic) UILabel     *startTimeLab;
@property (retain,nonatomic) UILabel     *endTimeLab;

- (void)loadInitData:(ScheduleInfo *)scheduleInfo;

@end
