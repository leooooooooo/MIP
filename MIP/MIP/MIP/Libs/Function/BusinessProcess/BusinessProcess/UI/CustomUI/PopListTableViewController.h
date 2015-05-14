//
//  PopListTableViewController.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/09.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListBoxSelectDelegate <NSObject>

- (void) selectedWithIndex: (NSInteger) index;

@end

@interface PopListTableViewController : UITableViewController
{
    id <ListBoxSelectDelegate> m_delegate;
}

@property (nonatomic, retain) NSArray *dataArr;

@property (nonatomic, assign) CGRect tableFrame;

@property (nonatomic, assign) NSInteger maxRowCount;

@property (nonatomic, assign) id <ListBoxSelectDelegate> delegate;

@end
