//
//  ContactsViewController.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/11.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "BaseScrollViewController.h"

@class ContactsView;

@interface ContactsViewController : BaseScrollViewController
{
    NSString *selectCompanyid;
    NSString *selectCompanyname;
    
    ContactsView *m_contactsView;
}

@end
