//
//  MyAppViewController.h
//  MIP_iPhone_LYG
//
//  Created by kangqijun on 14-4-10.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBaseViewController.h"
#import "MyAppTableViewController.h"
#import "MyAppCenterViewController.h"

@interface MyAppViewController : TabBaseViewController<MyAppTableViewDelegate>
{
    MyAppCenterViewController *myAppCenterViewController;
    MyAppTableViewController *_categoryTableViewController;
}
@end
