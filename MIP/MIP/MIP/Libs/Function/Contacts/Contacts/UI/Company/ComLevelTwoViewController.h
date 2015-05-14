//
//  ComLevelTwoViewController.h
//  Contacts
//
//  Created by lu_sicong on 2014/04/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "BaseViewController.h"

@class ComLevelTwoView;

@interface ComLevelTwoViewController : BaseViewController
{
    ComLevelTwoView *m_contactsView;
}

@property (nonatomic, retain) NSString *strCompanyName;

@property (nonatomic, retain) NSMutableArray *m_searchResultList;

@property (nonatomic, retain) NSString *m_strKey;

@end
