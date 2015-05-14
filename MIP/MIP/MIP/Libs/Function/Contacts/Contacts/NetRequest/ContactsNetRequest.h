//
//  ContactsNetRequest.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/11.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "MIPNetUniformInterface.h"

@interface ContactsNetRequest : NetUniformInterface

- (void)requestForGroupContacts;

- (void)requestForPersonalContacts;

- (void)requestForFullCompany;

- (void)requestForSearchContacts;

@end
