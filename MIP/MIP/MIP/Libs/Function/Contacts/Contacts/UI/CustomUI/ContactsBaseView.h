//
//  ContactsBaseView.h
//  Contacts
//
//  Created by lu_sicong on 2014/04/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "BaseView.h"

@protocol ContactsViewDelegate <NSObject>

- (void) backBtnClick;

@optional
- (void) filterCompanyClick;

- (void) search: (NSString *) key;

@end

@class InsetTextField;

@interface ContactsBaseView : BaseView<UITextFieldDelegate>
{
    UIView              *m_contentView;
    
    InsetTextField      *m_searchText;
    
    UIView              *m_searchResultView;
    UILabel             *m_searchResultText;
    
    UIImageView         *m_headerBgView;
    
    id<ContactsViewDelegate> m_delegate;
}

@property (nonatomic, weak) id<ContactsViewDelegate> delegate;
@property (nonatomic, retain)UIButton *filterBtn;

- (void) setSubView : (UIView *)subView;

@end
