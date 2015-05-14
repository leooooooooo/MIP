//
//  BerthingProcessViewController.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/01.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ProcessBaseViewController.h"
#import "BerthingProcessView.h"

@interface BerthingProcessViewController : ProcessBaseViewController
{
    BerthingProcessView *m_berthProcessView;
    
    NSString *m_planEnterPortTime;
    NSString *m_planLeavePortTime;
}

@property (nonatomic, retain) NSString *planEnterPortTime;
@property (nonatomic, retain) NSString *planLeavePortTime;

@end
