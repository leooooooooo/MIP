//
//  BusinessLevelTwoView.h
//  BusinessProcess
//
//  Created by wanghao on 14-3-12.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

@protocol BusinessProcessViewDelegate <NSObject>

- (void) closeBtnClick;

- (void) tabButtonClick: (NSInteger) index;

- (void) search: (NSDictionary *) dic;

- (void) showAlert:(NSString *)title withMsg : (NSString *)message;

@end


@interface BusinessProcessLevelTwoView : UIView
{
    UIView *m_titleView;
    
    UIView *m_tableTitleView;
    
    UIView *m_tableContentView;
    
    UILabel *tabNameLbl;

    __weak id <BusinessProcessViewDelegate> m_delegate;
    
    UITapGestureRecognizer *keyboardTap;
}

@property (nonatomic, weak) id <BusinessProcessViewDelegate> delegate;

@property (nonatomic, retain) NSArray *jobComNameList;
@property (nonatomic, retain) NSArray *jobComIdList;
@property (nonatomic, retain) UIButton *m_beginTime;
@property (nonatomic, retain) UIButton *m_endTime;


- (void) setProcessType:(NSInteger)processType andProcessTypeName : (NSString *) processTypeName;

- (void) setTableTitleView : (UIView *)view;

- (void) setTableContentView : (UIView *)view;

- (CGRect) tableViewFrame;

@end
