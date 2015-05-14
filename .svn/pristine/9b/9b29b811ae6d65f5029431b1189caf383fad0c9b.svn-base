//
//  MyAppCenterTableViewController.h
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/12.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ApplicationType.h"

@protocol AppTypeSelectedDelegate <NSObject>

- (void) didSelectedAppType : (ApplicationType *) appType;

@end

@interface MyAppCenterTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    __weak id<AppTypeSelectedDelegate> m_delegate;
}

@property (nonatomic, weak) id<AppTypeSelectedDelegate> m_delegate;

@end
