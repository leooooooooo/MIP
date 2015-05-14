//
//  BusinessDatePickerView.h
//  BusinessProcess
//
//  Created by mengxianglei on 14-5-22.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BusinessDatePickerViewDelegate <NSObject>

- (void) sureBtnClick:(NSDate *)date;
- (void) cancelBtnClick;

@end

@interface BusinessDatePickerView : UIView
{
    UIDatePicker *datePicker;
    __weak id<BusinessDatePickerViewDelegate> m_delegate;
}

@property (nonatomic, weak) id<BusinessDatePickerViewDelegate> delegate;

-(void) setSelectDate:(NSDate *)date;
-(void) setDateModelDateAndTime;
-(void) setDateModel:(UIDatePickerMode)datePickerMode;


@end
