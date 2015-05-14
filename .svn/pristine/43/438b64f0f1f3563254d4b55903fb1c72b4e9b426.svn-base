//
//  LCLevelOneTableViewController.h
//  LCHarbour
//
//  Created by kangqijun on 14-3-25.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomRefreshTableViewController.h"

@protocol LowCLevelOneTableDelegate <NSObject>

- (void) selectedLowCPortUrl : (NSString *)url withTitle : (NSString *) title;

@end

@interface LCLevelOneTableViewController : CustomRefreshTableViewController
{
    id <LowCLevelOneTableDelegate> m_delegate;
}

@property (nonatomic, retain) id <LowCLevelOneTableDelegate> m_delegate;

@end
