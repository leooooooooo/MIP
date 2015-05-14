//
//  ScheduleTimePickerView.m
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-4-1.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ScheduleTimePickerView.h"

@implementation ScheduleTimePickerView

@synthesize sureBtn;
@synthesize cancelBtn;
@synthesize startBtn;
@synthesize endBtn;
@synthesize datePicker;

@synthesize startTimeLab;
@synthesize endTimeLab;
@synthesize inputTextView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bgScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgScrollView];
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bgImage setImage:[UIImage imageNamed:@"addSchedule_bg.png" imageBundle:commonlyUsedToolBundle]];
        [bgScrollView addSubview:bgImage];
        [bgImage release];
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [bgButton addTarget:self action:@selector(hiddenDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [bgScrollView addSubview:bgButton];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        titleLab.text = @"添加事件";
        titleLab.font = [UIFont boldSystemFontOfSize:25];
        titleLab.textAlignment = UITextAlignmentCenter;
        [titleLab setTextColor:[UIColor whiteColor]];
        [titleLab setBackgroundColor:[UIColor clearColor]];
        [bgScrollView addSubview:titleLab];
        [titleLab release];
        
        cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(frame.size.width - 122, 530, 100, 40);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"button_blue_style1.png" imageBundle:publicResourceBundle] forState:UIControlStateNormal];
        [bgScrollView addSubview:cancelBtn];
        
        sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"button_blue_style1.png" imageBundle:publicResourceBundle] forState:UIControlStateNormal];
        sureBtn.frame = CGRectMake(10, 530, 100, 40);
        [bgScrollView addSubview:sureBtn];
        
        UILabel *startLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 100, 50)];
        startLab.text = @"开始:";
        startLab.font = [UIFont boldSystemFontOfSize:20];
        startLab.textAlignment = UITextAlignmentLeft;
        [startLab setTextColor:[UIColor colorWithHex:@"474747"]];
        [startLab setBackgroundColor:[UIColor clearColor]];
        [bgScrollView addSubview:startLab];
        [startLab release];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        [formatter release];
        
        UILabel *endLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 200, 50)];
        endLab.text = @"结束:";
        endLab.font = [UIFont boldSystemFontOfSize:20];
        endLab.textAlignment = UITextAlignmentLeft;
        [endLab setTextColor:[UIColor colorWithHex:@"474747"]];
        [endLab setBackgroundColor:[UIColor clearColor]];
        [bgScrollView addSubview:endLab];
        [endLab release];
        
        startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        startBtn.frame = CGRectMake(90, 50, 200, 50);
        startBtn.backgroundColor = [UIColor colorWithRed:49/255.0 green:140/255.0 blue:255/255.0 alpha:1.0];
        [bgScrollView addSubview:startBtn];
        
        startTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        startTimeLab.text = dateString;
        startTimeLab.font = [UIFont boldSystemFontOfSize:20];
        startTimeLab.textAlignment = UITextAlignmentCenter;
        [startTimeLab setTextColor:[UIColor blackColor]];
        [startTimeLab setBackgroundColor:[UIColor clearColor]];
        [startBtn addSubview:startTimeLab];
        
        endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        endBtn.frame = CGRectMake(90, 100, 200, 50);
        [bgScrollView addSubview:endBtn];
        
        endTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        endTimeLab.font = [UIFont boldSystemFontOfSize:20];
        endTimeLab.textAlignment = UITextAlignmentCenter;
        endTimeLab.text = @"请点击选择结束时间";
        [endTimeLab setBackgroundColor:[UIColor clearColor]];
        [endBtn addSubview:endTimeLab];
        
        inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 155, frame.size.width-34, 180)];
        inputTextView.delegate = self;
        inputTextView.font = [UIFont systemFontOfSize:20];
        inputTextView.backgroundColor = [UIColor clearColor];
        [bgScrollView addSubview:inputTextView];
        
        UIImageView *chooseBGImage = [[UIImageView alloc] initWithFrame:CGRectMake(11, 410, frame.size.width-36, 40)];
        [chooseBGImage setImage:[UIImage imageNamed:@"bg_cellBackground_style1_2.png" imageBundle:publicResourceBundle]];
        [bgScrollView addSubview:chooseBGImage];
        [chooseBGImage release];
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(15, 340, frame.size.width-40, 180)];
        [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        datePicker.minuteInterval = 5;
        datePicker.date = [NSDate date];
        [bgScrollView addSubview:datePicker];
        
    }
    return self;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [bgScrollView setContentOffset:CGPointMake(0, 80) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [bgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)hiddenDatePicker
{
    [inputTextView resignFirstResponder];
}

- (void)loadInitData:(ScheduleInfo *)scheduleInfo
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *startTime = [formatter stringFromDate:scheduleInfo.startTime];
    NSString *endTime = [formatter stringFromDate:scheduleInfo.endTime];
    [formatter release];
    
    startTimeLab.text = startTime;
    endTimeLab.text = endTime;
    
    inputTextView.text = scheduleInfo.content;
}

- (void)dealloc
{
    [inputTextView release];
    [startTimeLab release];
    [endTimeLab release];
    [datePicker release];
    [bgScrollView release];
    
    [super dealloc];
}

@end
