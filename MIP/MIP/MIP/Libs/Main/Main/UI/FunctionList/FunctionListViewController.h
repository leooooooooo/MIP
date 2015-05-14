//
//  FunctionListViewController.h
//  MIP_iPhone_LYG
//
//  Created by kangqijun on 14-4-10.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBaseViewController.h"
#import "FunctionModuleViewController.h"

@interface FunctionListViewController : TabBaseViewController <UITableViewDataSource,UITableViewDelegate,FunctionModuleViewControllerDelegate>
{
    FunctionModuleViewController *functionModuleViewController;
}

@end
