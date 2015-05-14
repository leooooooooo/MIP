//
//  ComContactsDetailInfoCell.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/26.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ComContactsDetailInfoCell.h"

#define SubCellBgColor      [UIColor colorWithRed:139/255.0 green:148/255.0 blue:156/255.0 alpha:1.0]
#define SubCellTextColor    [UIColor whiteColor]
#define SubCellTitleFont    [UIFont boldSystemFontOfSize:17]
#define SubCellTextFont     [UIFont systemFontOfSize:15]
#define SeparatorTopColor   [UIColor colorWithRed:117/255.0 green:127/255.0 blue:135/255.0 alpha:1.0]
#define SeparatorBotColor   [UIColor colorWithRed:150/255.0 green:159/255.0 blue:167/255.0 alpha:1.0]

#define TelIconImage        [UIImage imageNamed:@"icon_tp.png" imageBundle:contactsBundle]

@implementation ComContactsDetailInfoCell
@dynamic title;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.contentView.backgroundColor = SubCellBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *iconImage = [[UIImageView alloc] initWithImage:TelIconImage];
        iconImage.frame = CGRectMake(60, (TableSubCellHeight - 34) / 2, 34, 34);
        [self.contentView addSubview:iconImage];
        [iconImage release];
        
        m_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 90, TableSubCellHeight)];
        m_titleLabel.textColor = SubCellTextColor;
        m_titleLabel.font = SubCellTitleFont;
        m_titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:m_titleLabel];
        [m_titleLabel release];
        
        UIButton *telBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, TableSubCellHeight)];
        telBtn.backgroundColor = [UIColor clearColor];
        [telBtn addTarget:self action:@selector(telBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
        
        m_telLabel = [[[UILabel alloc] initWithFrame:CGRectMake(155, 0, 160, TableSubCellHeight)] autorelease];
        m_telLabel.textColor = SubCellTextColor;
        m_telLabel.font = SubCellTextFont;
        m_telLabel.backgroundColor = [UIColor clearColor];
        m_telLabel.textAlignment = NSTextAlignmentRight;
        
        [telBtn addSubview:m_telLabel];
        [self.contentView addSubview:telBtn];
        
    }
    return self;
}

-(void)telBtnClickAction
{
//    if (m_delegate && [m_delegate respondsToSelector:@selector(telBtnClickCell:)]) {
//        [m_delegate telBtnClickCell:m_telNumberLabel.text];
//    }
    if (m_telLabel.text != nil && ![m_telLabel.text isEqualToString:@""]) {
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",m_telLabel.text]];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.contentView addSubview:callWebview];
        [callWebview release];
    }
}

- (void)dealloc
{
    [m_titleLabel release];
    
    [m_telLabel release];

    [super dealloc];
}

-(void)setTitle:(NSString *)title
{
    m_titleLabel.text = title;
}

- (NSString *)title
{
    return m_titleLabel.text;
}

-(void)setTel:(NSString *)tel
{
    m_telLabel.text = tel;
}

- (NSString *)tel
{
    return m_telLabel.text;
}

@end
