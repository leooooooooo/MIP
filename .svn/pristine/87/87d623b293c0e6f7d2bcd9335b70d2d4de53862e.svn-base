//
//  PersonalInfoCell.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "PersonalInfoCell.h"

#define BackGroundColor     [UIColor colorWithRed:244/255.0 green:249/255.0 blue:255/255.0 alpha:1.0]
#define SelectedBgColor     [UIColor colorWithRed:221/255.0 green:243/255.0 blue:255/255.0 alpha:1.0]
#define IconImage           [UIImage imageNamed:@"lie_t.png" imageBundle:contactsBundle]

#define TextColor           [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0]
#define TextFont            [UIFont systemFontOfSize:18]

#define DefArrow            [UIImage imageNamed:@"arrow_1.png" imageBundle:contactsBundle]
#define SelectedArrow       [UIImage imageNamed:@"arrow_2.png" imageBundle:contactsBundle]

#define SubCellBgColor      [UIColor colorWithRed:139/255.0 green:148/255.0 blue:156/255.0 alpha:1.0]
#define SubCellTextColor    [UIColor whiteColor]
#define SubCellTitleFont    [UIFont boldSystemFontOfSize:17]
#define SubCellTextFont     [UIFont systemFontOfSize:15]
#define SeparatorTopColor   [UIColor colorWithRed:117/255.0 green:127/255.0 blue:135/255.0 alpha:1.0]
#define SeparatorBotColor   [UIColor colorWithRed:150/255.0 green:159/255.0 blue:167/255.0 alpha:1.0]

#define TelIconImage        [UIImage imageNamed:@"icon_tl.png" imageBundle:contactsBundle]
#define OfficeTelIconImage  [UIImage imageNamed:@"icon_tp.png" imageBundle:contactsBundle]
#define MailIconImage       [UIImage imageNamed:@"icon_tm.png" imageBundle:contactsBundle]

@interface PersonalInfoCell()
{
    UIButton *m_cellButton;
    
    UIImageView *m_arrowView;
    
    UIView  *m_subContentView;
}

@end

@implementation PersonalInfoCell

@dynamic perContactsInfo, personName, departmentName, telNumber, officePhone, emailAddress;

@synthesize delegate = m_delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        m_cellButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        m_cellButton.frame = CGRectMake(0, 0, 320, TableCellHeight);
        m_cellButton.backgroundColor = BackGroundColor;
        [m_cellButton addTarget:self action:@selector(cellClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:m_cellButton];
        
        UIImage *iconImage = IconImage;
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        iconImageView.frame = CGRectMake(8, (TableCellHeight - iconImage.size.height) / 2, iconImage.size.width, iconImage.size.height);
        [m_cellButton addSubview:iconImageView];
        [iconImageView release];
        
        m_personNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 225, TableCellHeight)];
        m_personNameLabel.backgroundColor = [UIColor clearColor];
        m_personNameLabel.font = TextFont;
        m_personNameLabel.textColor = TextColor;
        [m_cellButton addSubview:m_personNameLabel];
        
        m_arrowView = [[UIImageView alloc] initWithImage:DefArrow];
        m_arrowView.frame = CGRectMake(299, (TableCellHeight - 34) / 2, 11, 34);
        [m_cellButton addSubview:m_arrowView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        m_subContentView = [[UIView alloc] initWithFrame:CGRectMake(0, TableCellHeight, 320, TableSubCellHeight * 4)];
        [self addSubview:m_subContentView];
        
        m_telNumberLabel = [[self createSubCell:@"工作手机：" andIcon:TelIconImage andFrame:CGRectMake(0, 0, 320, TableSubCellHeight)] retain];

        m_officePhoneLabel = [[self createSubCell:@"办公电话：" andIcon:OfficeTelIconImage andFrame:CGRectMake(0, 0 + TableSubCellHeight, 320, TableSubCellHeight)] retain];
        
        m_emailAddressLabel = [[self createSubCell:@"集团邮箱：" andIcon:MailIconImage andFrame:CGRectMake(0, 0 + TableSubCellHeight*2, 320, TableSubCellHeight)] retain];
        
        m_moreInfoLabel = [[self createSubCell:@">>更多" andIcon:nil andFrame:CGRectMake(0, 0 + TableSubCellHeight*3, 320, TableSubCellHeight)] retain];
        
        m_subContentView.hidden = YES;
    }
    return self;
}

- (UILabel *) createSubCell:(NSString *)title andIcon : (UIImage *)image andFrame : (CGRect)frame
{
//    UIView *subCellView = [[UIView alloc] initWithFrame:frame];
//    subCellView.backgroundColor = SubCellBgColor;
    UIButton *subCellView = [[UIButton alloc] initWithFrame:frame];
    if ([title isEqualToString:@"工作手机："]) {
        [subCellView addTarget:self action:@selector(telBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    }else if ([title isEqualToString:@"办公电话："]) {
        [subCellView addTarget:self action:@selector(officeTelBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    }else if ([title isEqualToString:@"集团邮箱："]) {
        [subCellView addTarget:self action:@selector(mailBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    }else if ([title isEqualToString:@">>更多"]) {
        [subCellView addTarget:self action:@selector(moreBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    }else {
        //nothing
    }
    
    subCellView.backgroundColor = SubCellBgColor;
    
    UIImageView *iconImage = [[UIImageView alloc] initWithImage:image];
    iconImage.frame = CGRectMake(30, (TableSubCellHeight - 34) / 2 , 34, 34);
    [subCellView addSubview:iconImage];
    [iconImage release];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 90, TableSubCellHeight)];
    titleLabel.text = title;
    titleLabel.textColor = SubCellTextColor;
    titleLabel.font = SubCellTitleFont;
    titleLabel.backgroundColor = [UIColor clearColor];
    [subCellView addSubview:titleLabel];
    [titleLabel release];
    
    UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(155, 0, 160, TableSubCellHeight)] autorelease];
    [subCellView addSubview:textLabel];
    textLabel.textColor = SubCellTextColor;
    textLabel.font = SubCellTextFont;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentLeft;
    
    UIView *topSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, TableSubCellHeight - 1, 320, 1)];
    topSeparator.backgroundColor = SeparatorTopColor;
    [subCellView addSubview:topSeparator];
    [topSeparator release];
    
    UIView *bottomSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    bottomSeparator.backgroundColor = SeparatorBotColor;
    [subCellView addSubview:bottomSeparator];
    [bottomSeparator release];
    
    [m_subContentView addSubview:subCellView];
    
    [subCellView release];
    
    return textLabel;
}

-(void)telBtnClickAction
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(telBtnClickCell:)]) {
        [m_delegate telBtnClickCell:m_telNumberLabel.text];
    }
}

-(void)officeTelBtnClickAction
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(officeTelBtnClickCell:)]) {
        [m_delegate officeTelBtnClickCell:m_officePhoneLabel.text];
    }
}

-(void)mailBtnClickAction
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(mailBtnClickCell:)]) {
        [m_delegate mailBtnClickCell:m_emailAddressLabel.text];
    }
}

-(void)moreBtnClickAction
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(moreBtnClickCell:)]) {
        [m_delegate moreBtnClickCell:m_perContactsInfo];
    }
}

- (void)dealloc
{
    [m_personNameLabel release];
    [m_arrowView release];
    [m_cellButton release];
    [m_subContentView release];
    
    [m_telNumberLabel release];
    [m_officePhoneLabel release];
    [m_emailAddressLabel release];
    [m_moreInfoLabel release];
    
    [super dealloc];
}

- (void)cellClick
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(selectedCell:)]) {
        [m_delegate selectedCell:self];
    }
}

- (void)selectedCell : (BOOL) isSelected
{
    m_isSelected = isSelected;
    m_subContentView.hidden = !m_isSelected;
    
    if (m_isSelected) {
        m_cellButton.backgroundColor = SelectedBgColor;
        [m_arrowView setImage:SelectedArrow];
    }else {
        m_cellButton.backgroundColor = BackGroundColor;
        [m_arrowView setImage:DefArrow];
    }
}

- (PerContactsInfo *)perContactsInfo
{
    return m_perContactsInfo;
}

-(void)setPerContactsInfo:(PerContactsInfo *)perContactsInfo
{
    m_perContactsInfo = perContactsInfo;
}

- (NSString *)personName
{
    return m_personNameLabel.text;
}

-(void)setPersonName:(NSString *)personName
{
    m_personNameLabel.text = personName;
}

- (NSString *)telNumber
{
    return m_telNumberLabel.text;
}

-(void)setTelNumber:(NSString *)telNumber
{
    m_telNumberLabel.text = telNumber;
}

- (NSString *)emailAddress
{
    return m_emailAddressLabel.text;
}

- (void) setEmailAddress:(NSString *)emailAddress
{
    m_emailAddressLabel.text = emailAddress;
}

- (NSString *)departmentName
{
    return m_departmentNameLabel.text;
}

- (void) setDepartmentName:(NSString *)departmentName
{
    m_departmentNameLabel.text = departmentName;
}

- (NSString *)officePhone
{
    return m_officePhoneLabel.text;
}

- (void) setOfficePhone:(NSString *)officePhone
{
    m_officePhoneLabel.text = officePhone;
}

@end
