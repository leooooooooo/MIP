//
//  ComContactsInfoCell.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/25.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ComContactsInfoCell.h"

#define SelectedBgColor     [UIColor colorWithRed:221/255.0 green:243/255.0 blue:255/255.0 alpha:1.0]
#define IconImage           [UIImage imageNamed:@"lie_t.png" imageBundle:contactsBundle]

#define TextColor           [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0]
#define TextFont            [UIFont systemFontOfSize:18]

#define DefArrow            [UIImage imageNamed:@"arrow_right.png" imageBundle:contactsBundle]

@implementation ComContactsInfoCell
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
        m_arrowView.frame = CGRectMake(299, (TableCellHeight - 13) / 2, 9.5, 13);
        [self.contentView addSubview:m_arrowView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
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

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];

    // Configure the view for the selected state
    if (highlighted) {
        self.contentView.backgroundColor = SelectedBgColor;
    }else{
        self.contentView.backgroundColor = BackGroundColor;
    }
}

@end
