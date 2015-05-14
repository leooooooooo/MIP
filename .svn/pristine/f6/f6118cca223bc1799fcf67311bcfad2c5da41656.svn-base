//
//  ContactsView.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ContactsView.h"
#import "InsetTextField.h"

#define TabButtonFrame          CGRectMake(75, 5, 170, 39.5)

@implementation ContactsView

@synthesize tabDelegate = m_tabDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        ContactsTabButton *contactsTypeBtn = [[ContactsTabButton alloc] initWithFrame:TabButtonFrame];
        contactsTypeBtn.delegate = self;
        [m_headerBgView addSubview:contactsTypeBtn];
        [contactsTypeBtn release];
    }
    return self;
}

- (void) clickTagButtonWithBtnTag:(NSInteger)tagIndex
{
    if ([m_contentView.subviews count] > 0) {
        for (UIView *subView in m_contentView.subviews) {
            [subView removeFromSuperview];
        }
    }
    
    m_searchText.text = @"";
    m_searchResultView.hidden = YES;
    
    if (m_tabDelegate && [m_tabDelegate respondsToSelector:@selector(tabButtonClick:)]) {
        [m_tabDelegate tabButtonClick:tagIndex];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
