//
//  FilterCompanyTableViewController.h
//  Contacts
//
//  Created by mengxianglei on 2014/05/14.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

@class FilterCompanyTableViewController;

@interface FilterCompanyTableViewController : UITableViewController
{
    NSString *m_strKey;
    
    UILabel *m_lblTableTitle;
}

- (void) searchByKey : (NSString *) sKey;

@end
