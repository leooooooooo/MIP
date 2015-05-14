//
//  CompanyTableViewController.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComLevelTwoTableViewController;

@interface ComLevelOneTableViewController : UITableViewController
{
    NSString *m_strKey;
    
    UILabel *m_lblTableTitle;
}

- (void) searchByKey : (NSString *) sKey;

@end
