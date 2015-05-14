//
//  TimeButton.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/05/26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "TimeButton.h"
#import "BusinessDatePickerView.h"
#import "CustomPopListView.h"

#define TextFieldBgImage        [UIImage imageNamed:@"bg_input_style3.png" imageBundle:publicResourceBundle]

#define TitleTextColor  [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1.0]
#define TitleTextFont   [UIFont systemFontOfSize:14]

@interface TimeButton()<BusinessDatePickerViewDelegate>
{
    CustomPopListView *popListView;
    
    NSString *timeStr;
    
    NSString *dateFormatStr;
    
    BusinessDatePickerView *datepickerView;
    
    UIDatePickerMode datePickerMode;
}

@end

@implementation TimeButton

@synthesize time = timeStr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundImage:[TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(5,10,5,10)] forState:(UIControlStateNormal)];
        
        [self setTitleColor:TitleTextColor forState:UIControlStateNormal];
        self.titleLabel.font = TitleTextFont;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self addTarget:self action:@selector(timeClickAction:) forControlEvents:UIControlEventTouchUpInside];

        dateFormatStr = [@"yyyy-MM-dd HH:mm" retain];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:dateFormatStr];
        self.time = [dateFormatter stringFromDate:[NSDate date]];
        [dateFormatter release];
        
    }
    return self;
}

-(void)timeClickAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    // 解析时间和日期的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatStr];
    
    NSDate *selectDate = [NSDate date];
    if (btn.titleLabel.text != nil && ![btn.titleLabel.text isEqualToString:@""]) {
        selectDate = [formatter dateFromString:btn.titleLabel.text];
    }
    [formatter release];
    
    datepickerView = [[BusinessDatePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 274)];
    [datepickerView setSelectDate:selectDate];
    [datepickerView setDateModel:datePickerMode];
    datepickerView.delegate = self;
    
    if (popListView) {
        [popListView release];
        popListView = nil;
    }
    
    popListView = [[CustomPopListView alloc] initWithFrame:CGRectMake(0, 0, 568, 320)];
    [popListView loadDatePickerViewWith:datepickerView withPosionView:btn];
    
    CGRect rect = datepickerView.frame;
    rect.origin.y = rect.origin.y+2;
    datepickerView.frame = rect;
    
    [datepickerView release];
}

#pragma mark - BusinessDatePickerViewDelegate
- (void)sureBtnClick:(NSDate *)date
{
    // 设置时间和日期的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatStr];
    NSString *dateStr = [formatter stringFromDate:date];
    [formatter release];
    
    // 设置时间和日期的格式
    self.time = dateStr;
    
    [popListView removeFromSuperview];
}

- (void)cancelBtnClick
{
    [popListView removeFromSuperview];
}

- (void)setTime:(NSString *)time
{
    timeStr = [time retain];
    
    [dateFormatStr release];
    
    if (timeStr.length == 10) {
        dateFormatStr = [@"yyyy-MM-dd" retain];
        datePickerMode = UIDatePickerModeDate;
    }else {
        dateFormatStr = [@"yyyy-MM-dd HH:mm" retain];
        datePickerMode = UIDatePickerModeDateAndTime;
    }
    
    [self setTitle:timeStr forState:UIControlStateNormal];
}

- (void)dealloc
{
    [timeStr release];
    [popListView release];
    [dateFormatStr release];
    
    [super dealloc];
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
