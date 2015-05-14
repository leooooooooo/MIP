//
//  PersonalInfoCardView.h
//  Contacts
//
//  Created by mengxianglei on 14-5-13.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import "PerContactsInfo.h"

@protocol PersonalInfoCardViewDelegate <NSObject>
- (void) backBtnClick;
@end

@interface PersonalInfoCardView : UIView
{
    UIImageView    *m_headerBgView;
    
    UILabel        *m_lblTableTitle;
    
    UIImageView    *headerImageView;
    
    UILabel        *nameLabel;
        
    UITextField    *officTelField;
    
    UITextField    *telephoneField;
    
    UITextField    *emailField;
    
    UITextField    *departField;
    
    UITextField    *dutyField;
    
    UITextField    *bakTelField;
    
    UITextField    *officeTelField;
    
    UITextField    *bakOfficeTelField;
    
    UITextField    *perEmailField;
    
    UITextField    *weiboField;
    
    UIView         *contentView;
    
    UIScrollView    *scrollView;
    
    id <PersonalInfoCardViewDelegate> m_delegate;
}

@property (weak, nonatomic) id <PersonalInfoCardViewDelegate> m_delegate;

@property (retain, nonatomic) UIImageView    *headerImageView;

@property (nonatomic, retain) NSString       *title;

@property (retain, nonatomic) UITextField    *telephoneField;

@property (retain, nonatomic) UITextField    *emailField;

@property (retain, nonatomic) UITextField    *dutyField;

@property (retain, nonatomic) UITextField    *bakTelField;

@property (retain, nonatomic) UITextField    *officeTelField;

@property (retain, nonatomic) UITextField    *bakOfficeTelField;

@property (retain, nonatomic) UITextField    *perEmailField;

- (void)setTextForPerContactsInfo:(PerContactsInfo *) info;

@end
