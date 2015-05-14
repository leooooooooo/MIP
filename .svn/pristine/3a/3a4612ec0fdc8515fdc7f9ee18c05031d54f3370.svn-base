//
//  MyAppTableViewController.h
//  Main
//
//  Created by mengxianglei on 14-4-15.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "ApplicationInfor.h"

@protocol MyAppTableViewDelegate <NSObject>
@optional
-(void)didSelectedApp:(ApplicationInfor *) info;
@end

@interface MyAppTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak id<MyAppTableViewDelegate> _categoryDelegate;
}
@property (nonatomic, retain) NSMutableArray *m_appList;
@property(nonatomic,weak)id<MyAppTableViewDelegate> _categoryDelegate;
@end
