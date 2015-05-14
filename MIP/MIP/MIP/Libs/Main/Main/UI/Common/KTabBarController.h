//
//  KTabBarController.h
//  GACloud
//
//  Created by kangqijun on 14-3-7.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "KNavigationController.h"
#import "TabBarItemView.h"

@protocol KTabBarControllerDelegate <NSObject>

@optional
- (void)selectTabBarAtIndex:(int)index;

@end

@interface KTabBarController : BaseViewController
{
    id<KTabBarControllerDelegate> tabDelegate;
    NSArray                  *viewControllers;
    UIView                   *tabBarView;
}

@property (assign, nonatomic) id<KTabBarControllerDelegate> tabDelegate;
@property (retain, nonatomic) NSArray                  *viewControllers;
@property (retain, nonatomic) UIView                   *tabBarView;

- (void)chooseItemWith:(int)_index;

@end
