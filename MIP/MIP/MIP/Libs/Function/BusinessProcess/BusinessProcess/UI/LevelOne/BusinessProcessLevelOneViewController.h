//
//  BusinessProcessLevelOneViewController.h
//  BusinessProcess
//
//  Created by wanghao on 14-3-12.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseScrollViewController.h"

#import "BusinessProcessLevelOneView.h"

#import "BusinessProcessLevelOneTableViewController.h"

#import "BusinessProcessLevelTwoViewController.h"

@interface BusinessProcessLevelOneViewController : BaseScrollViewController<BusinessProcessLevelOneTableViewDelegate>
{
    BusinessProcessLevelOneView *_levelOneView;
    
    BusinessProcessLevelOneTableViewController *_menuTableViewController;
}

@end
