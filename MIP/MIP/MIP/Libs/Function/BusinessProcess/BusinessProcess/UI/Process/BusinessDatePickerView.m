//
//  BusinessDatePickerView.m
//  BusinessProcess
//
//  Created by mengxianglei on 14-5-22.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessDatePickerView.h"

#define kKalCalendarBundle          @"KalCalendar"

#define ScreenWidth             [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight            [[UIScreen mainScreen] bounds].size.height

#define BgFrameWidth            ((ScreenWidth > ScreenHeight)? ScreenWidth : ScreenHeight)
#define BgFrameHeight           ((ScreenWidth > ScreenHeight)? ScreenHeight : ScreenWidth) - 20

#define PopFrameTopShadow       7
#define PopFrameBottomShadow    17

#define BaseOriginY             (35.0)

@implementation BusinessDatePickerView
@synthesize delegate = m_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 250 + PopFrameTopShadow + PopFrameBottomShadow)];
        [self addSubview:contentView];
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"pot_box.png" imageBundle:settingBundle] resizableImageWithCapInsets:UIEdgeInsetsMake(50, 0, 30, 0) resizingMode:UIImageResizingModeStretch]];
        bgView.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
        [contentView addSubview:bgView];
        [bgView release];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, PopFrameTopShadow, contentView.frame.size.width, 40)];
        titleLab.text = @"选择日期";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont boldSystemFontOfSize:22];
        titleLab.backgroundColor = [UIColor clearColor];
        [contentView addSubview:titleLab];
        [titleLab release];
        
        datePicker = [[UIDatePicker alloc] init];
        datePicker.frame = CGRectMake(15, 55, contentView.frame.size.width - 30, 140);
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        datePicker.minuteInterval = 5;
        [contentView addSubview:datePicker];
        [datePicker release];
        
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [sureButton setFrame:CGRectMake(25, 205, 130, 35)];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [sureButton addTarget:self action:@selector(sureToJumpDate:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setFrame:CGRectMake(165, 205, 130, 35)];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [cancelBtn addTarget:self action:@selector(cancelToJumpDate) forControlEvents:UIControlEventTouchUpInside];
        
        [contentView addSubview:sureButton];
        
        [contentView addSubview:cancelBtn];
        
        [contentView release];
    }
    return self;
}

-(void) setSelectDate:(NSDate *)selectDate
{
    if (selectDate != nil) {
        datePicker.date = selectDate;
    } else{
        datePicker.date = [NSDate date];
    }
}

-(void) setDateModelDateAndTime
{
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    datePicker.minuteInterval = 1;
}

-(void) setDateModel:(UIDatePickerMode)datePickerMode
{
    [datePicker setDatePickerMode:datePickerMode];
    
    if (datePickerMode == UIDatePickerModeDateAndTime) {
        datePicker.minuteInterval = 1;
    }else {
        datePicker.minuteInterval = 5;
    }
}

- (void)sureToJumpDate:(id)sender
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(sureBtnClick:)]) {
        [m_delegate sureBtnClick:datePicker.date];
    }
}

- (void)cancelToJumpDate
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(cancelBtnClick)]) {
        [m_delegate cancelBtnClick];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
