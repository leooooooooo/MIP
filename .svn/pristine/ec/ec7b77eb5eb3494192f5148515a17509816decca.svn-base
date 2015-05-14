//
//  TabBaseViewController.h
//  Main
//
//  Created by kangqijun on 14-4-14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol TabBaseViewControllerDelegate <NSObject>

@optional
- (void)logOut;
- (void)goToSetting;

@end

@interface TabBaseViewController :BaseViewController
{
    id<TabBaseViewControllerDelegate> tabBaseDelegate;
}

@property (assign, nonatomic) id<TabBaseViewControllerDelegate> tabBaseDelegate;

- (void)tabViewAppear;

@end
