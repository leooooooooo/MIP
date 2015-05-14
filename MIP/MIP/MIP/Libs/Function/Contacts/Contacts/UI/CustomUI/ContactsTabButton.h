//
//  TabButton.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactsTabButtonDelegate <NSObject>

- (void) clickTagButtonWithBtnTag:(NSInteger) tagIndex;

@end

@interface ContactsTabButton : UIImageView
{
    id              m_selectedBtn;
    
    __weak id<ContactsTabButtonDelegate> m_delegate;
}

@property (nonatomic, weak) id<ContactsTabButtonDelegate> delegate;


@end
