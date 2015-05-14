//
//  PersonalInfoCell.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "PerContactsInfo.h"

#define TableCellHeight          (50.0)
#define TableSubCellHeight       (40.0)

@protocol PersonalCellClickDelegate <NSObject>

- (void) selectedCell : (UITableViewCell *)cell;
- (void) telBtnClickCell : (NSString *)telStr;
- (void) officeTelBtnClickCell : (NSString *)telStr;
- (void) mailBtnClickCell : (NSString *)mailStr;
- (void) moreBtnClickCell : (PerContactsInfo *)info;
@end

@interface PersonalInfoCell : UITableViewCell
{
    BOOL m_isSelected;
    
    UILabel *m_personNameLabel;
    UILabel *m_departmentNameLabel;
    UILabel *m_telNumberLabel;
    UILabel *m_officePhoneLabel;
    UILabel *m_emailAddressLabel;
    UILabel *m_moreInfoLabel;
    PerContactsInfo *m_perContactsInfo;
    
    id <PersonalCellClickDelegate> m_delegate;
}
@property (nonatomic, retain) PerContactsInfo *perContactsInfo;
@property (nonatomic, retain) NSString *personName;
@property (nonatomic, retain) NSString *departmentName;
@property (nonatomic, retain) NSString *telNumber;
@property (nonatomic, retain) NSString *officePhone;
@property (nonatomic, retain) NSString *emailAddress;

@property (nonatomic, assign) id <PersonalCellClickDelegate> delegate;

- (void) selectedCell : (BOOL) isSelected;

@end
