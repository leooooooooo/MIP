//
//  JobProcessView.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseView.h"

@protocol JobProcessViewDelegate <NSObject>

- (void) saveMarginValue:(NSString *)margin;

- (void) confirmAssessment : (NSString *)unloadCount andStopTime:(NSString *)stopTime;

- (void) saveUnloadStartTime : (NSString *)unloadStartTime;

- (void) saveUnloadStartTime : (NSString *)unloadStartTime withUnloadEndTime : (NSString *)unloadEndTime;

- (void) saveloadStartTime : (NSString *)loadStartTime;

- (void) saveloadStartTime : (NSString *)loadStartTime withLoadEndTime : (NSString *)loadEndTime;

- (void) saveErrorHandling;

- (void) saveNonLoadUnloadShip;

- (void) showErrorAlert : (NSString *)title;

@end

@interface JobProcessView : BaseView
{
    id<JobProcessViewDelegate> m_delegate;
}

@property (nonatomic, assign) id <JobProcessViewDelegate> delegate;

@property (nonatomic, retain) NSString *curBerth;           //当前靠停泊位
@property (nonatomic, retain) NSString *unloadMargin;       //卸货余吨

@property (nonatomic, retain) NSString *unloadCount;        //卸船数
@property (nonatomic, retain) NSString *totalStopTime;      //总停时

@property (nonatomic, retain) NSString *todayUnloadCount;   //今日卸船数
@property (nonatomic, retain) NSString *todayStopTime;      //今日停时

@property (nonatomic, retain) NSString *unloadStartTime;    //卸船开始时间
@property (nonatomic, retain) NSString *unloadEndTime;      //卸船结束时间

@property (nonatomic, retain) NSString *loadingStartTime;   //装货开始时间
@property (nonatomic, retain) NSString *loadingEndTime;     //装货结束时间



@end
