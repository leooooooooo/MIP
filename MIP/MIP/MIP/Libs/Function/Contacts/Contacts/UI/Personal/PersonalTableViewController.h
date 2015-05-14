//
//  PersonalTableViewController.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomRefreshTableViewController.h"

@interface PersonalTableViewController : CustomRefreshTableViewController<NSFetchedResultsControllerDelegate>
{
    CGFloat headerHeight;
    UIView *m_headerView;
    UIView *m_lineView;
    UILabel *headerLabel;
    
    NSMutableArray *perContactInfoArr;
}
@property (nonatomic, retain) NSString *selectCompanyid;
@property (nonatomic, retain) NSString *selectCompanyname;

- (void) searchByKey : (NSString *) sKey;

@end
