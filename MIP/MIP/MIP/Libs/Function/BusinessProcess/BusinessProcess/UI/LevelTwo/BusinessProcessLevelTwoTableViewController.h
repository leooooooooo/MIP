//
//  BusinessProcessLevelTwoTableViewController.h
//  BusinessProcess
//
//  Created by wanghao on 14-3-12.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomRefreshTableViewController.h"

@protocol BusinessProcessTableDelegate <NSObject>

- (void)clickBtn:(NSString *)bcNo andSerial : (NSString *)serial andAuditState : (BOOL) auditState;

- (void)clickBtn:(NSInteger)index withShipId:(NSString *)shipId andDataDic : (NSDictionary *)data;

@end

@class BusinessType;

@interface BusinessProcessLevelTwoTableViewController : CustomRefreshTableViewController
{
    id <BusinessProcessTableDelegate>  m_delegate;          //审核、明细、处理按钮事件
}

@property (nonatomic, assign) BusinessType *processType;

@property (nonatomic, assign) BOOL withShip;

@property (nonatomic, assign) id<BusinessProcessTableDelegate> delegate;

- (UIView *) getTableTitle;

- (void) search : (NSDictionary *) dic;

- (void) clearTable;

- (void) refreshTableData : (NSString *)bcno;

@end
