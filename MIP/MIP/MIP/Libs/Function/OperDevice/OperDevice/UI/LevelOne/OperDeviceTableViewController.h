//
//  OperDeviceTableViewController.h
//  OperDevice
//
//  Created by lu_sicong on 2014/04/25.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomRefreshTableViewController.h"

@protocol OperDeviceTableDelegate <NSObject>

- (void) selectedOperDeviceUrl : (NSString *)url withTitle : (NSString *) title;

@end

@interface OperDeviceTableViewController : CustomRefreshTableViewController
{
    id <OperDeviceTableDelegate> m_delegate;
}

@property (nonatomic, retain) id <OperDeviceTableDelegate> m_delegate;

@end
