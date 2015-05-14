//
//  ContactsView.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ContactsTabButton.h"
#import "ContactsBaseView.h"

@protocol ContactsTabViewDelegate <NSObject>

- (void) tabButtonClick: (NSInteger) index;

@end

@interface ContactsView : ContactsBaseView<ContactsTabButtonDelegate>
{
    UILabel *headerLabel;
    id<ContactsTabViewDelegate> m_tabDelegate;
}

@property (nonatomic, assign) id<ContactsTabViewDelegate> tabDelegate;

@end
