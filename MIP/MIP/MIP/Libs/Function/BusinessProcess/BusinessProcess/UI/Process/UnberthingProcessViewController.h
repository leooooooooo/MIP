//
//  UnberthingProcessViewController.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/05/23.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ProcessBaseViewController.h"
#import "UnberthingProcessView.h"

@interface UnberthingProcessViewController : ProcessBaseViewController
{
    UnberthingProcessView *m_unberthProcessView;
    
    NSString *planMoveBerthTime;
    NSString *planMoveBerthNo;
    
    NSString *strBerthName;
    NSString *strBerthNo;
}

@property (nonatomic, retain) NSString *planMoveBerthTime;
@property (nonatomic, retain) NSString *planMoveBerthNo;

@property (nonatomic, retain) NSString *strBerthName;
@property (nonatomic, retain) NSString *strBerthNo;

@end
