//
//  OutwardProcessViewController.h
//  BusinessProcess
//
//  Created by mengxianglei on 14-5-22.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ProcessBaseViewController.h"
#import "OutwardProcessView.h"
#import "BusinessDatePickerView.h"
#import "CustomPopListView.h"

@interface OutwardProcessViewController : ProcessBaseViewController<OutwardProcessViewDelegate>
{
    OutwardProcessView *m_outwardProcessView;
    CustomPopListView *popListView;
    
    NSString *m_planEnterPortTime;
    NSString *m_planLeavePortTime;
    
    BOOL isLeadTime;
}

@property (nonatomic, retain) NSString *planEnterPortTime;
@property (nonatomic, retain) NSString *planLeavePortTime;

@end
