//
//  ComContactsDepartCell.m
//  Contacts
//
//  Created by lu_sicong on 2014/04/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ComContactsDepartCell.h"

#define SelectedBgColor     [UIColor colorWithRed:221/255.0 green:243/255.0 blue:255/255.0 alpha:1.0]
#define IconImage           [UIImage imageNamed:@"lie_t.png" imageBundle:contactsBundle]

#define TextColor           [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0]
#define TextFont            [UIFont systemFontOfSize:18]

#define DefArrow            [UIImage imageNamed:@"arrow_1.png" imageBundle:contactsBundle]
#define SelectedArrow       [UIImage imageNamed:@"arrow_2.png" imageBundle:contactsBundle]

@implementation ComContactsDepartCell

@synthesize isSelected = m_isSelected;

@dynamic title;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.contentView.backgroundColor = BackGroundColor;
        
        UIImage *iconImage = IconImage;
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        iconImageView.frame = CGRectMake(8, (TableCellHeight - iconImage.size.height) / 2, iconImage.size.width, iconImage.size.height);
        [self.contentView addSubview:iconImageView];
        [iconImageView release];
        
        m_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 225, TableCellHeight)];
        m_titleLabel.backgroundColor = [UIColor clearColor];
        m_titleLabel.font = TextFont;
        m_titleLabel.textColor = TextColor;
        [self.contentView addSubview:m_titleLabel];
        
        m_arrowView = [[UIImageView alloc] initWithImage:DefArrow];
        m_arrowView.frame = CGRectMake(299, (TableCellHeight - 34) / 2, 11, 34);
        [self.contentView addSubview:m_arrowView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)dealloc
{
    [m_titleLabel release];
    [m_arrowView release];
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

- (void)setIsSelected:(BOOL)isSelected
{
    m_isSelected = isSelected;
    
    if (m_isSelected) {
        self.contentView.backgroundColor = SelectedBgColor;
        [m_arrowView setImage:SelectedArrow];
    }else {
        self.contentView.backgroundColor = BackGroundColor;
        [m_arrowView setImage:DefArrow];
    }
}

@end
