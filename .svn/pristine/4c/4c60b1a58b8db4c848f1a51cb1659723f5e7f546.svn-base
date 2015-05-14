//
//  FunctionModuleViewController.h
//  Main
//
//  Created by kangqijun on 14-4-14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#define kLeftDistanceX     70

@protocol FunctionModuleViewControllerDelegate <NSObject>

- (void)moveToOutside;

@end

@interface FunctionModuleViewController : BaseViewController <UIGestureRecognizerDelegate>
{
    id<FunctionModuleViewControllerDelegate> moveDelegate;
}

@property (assign, nonatomic) id<FunctionModuleViewControllerDelegate> moveDelegate;

- (void)loadDataWithModule:(Module *)module;

@end
