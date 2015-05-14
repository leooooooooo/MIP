//
//  JobProcessViewController.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ProcessBaseViewController.h"
#import "JobProcessView.h"

@interface JobProcessViewController : ProcessBaseViewController
{
    JobProcessView *m_jobProcessView;
}

@property (nonatomic, retain) NSString *strBerthName;

@property (nonatomic, retain) NSString *strBerthNo;

@end
