//
//  SettingViewController.h
//  Setting
//
//  Created by kangqijun on 13-11-7.
//  Copyright (c) 2013年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseScrollViewController.h"
#import "SettingView.h"

@interface SettingViewController : BaseScrollViewController <SettingViewDelegate>
{
    id <SettingViewDelegate>               delegate;
}

@property (nonatomic ,assign)    id<SettingViewDelegate>   delegate;

- (void)setPersonInfoHeaderImage:(UIImage *)image;

@end
