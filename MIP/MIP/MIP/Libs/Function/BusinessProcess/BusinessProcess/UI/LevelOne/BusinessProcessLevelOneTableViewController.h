//
//  BusinessProcessLevelOneTableViewController.h
//  BusinessProcess
//
//  Created by wanghao on 14-3-12.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "CustomRefreshTableViewController.h"

@class BusinessType;

@protocol BusinessProcessLevelOneTableViewDelegate <NSObject>

@optional
- (void) selectBusinessType : (BusinessType *) type;

@end

@interface BusinessProcessLevelOneTableViewController : CustomRefreshTableViewController<NSFetchedResultsControllerDelegate>{
    __weak id<BusinessProcessLevelOneTableViewDelegate> m_delegate;
}

@property(nonatomic, weak)id<BusinessProcessLevelOneTableViewDelegate> delegate;

- (void) setUnionId : (NSString *)unionId;

@end