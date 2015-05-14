//
//  FullCompanyCell.m
//  Contacts
//
//  Created by mengxianglei on 14-5-14.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import "FullCompanyCell.h"

#define SelectedBgColor     [UIColor colorWithRed:221/255.0 green:243/255.0 blue:255/255.0 alpha:1.0]
#define IconImage           [UIImage imageNamed:@"lie_t.png" imageBundle:contactsBundle]

#define TextColor           [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0]
#define TextFont            [UIFont systemFontOfSize:18]

#define NOSELECT            [UIImage imageNamed:@"icon_selected_0.png" imageBundle:contactsBundle]
#define SELECTED            [UIImage imageNamed:@"icon_selected_2.png" imageBundle:contactsBundle]

@implementation FullCompanyCell
@dynamic title;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = BackGroundColor;

        m_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 265, TableCellHeight)];
        m_titleLabel.backgroundColor = [UIColor clearColor];
        m_titleLabel.font = TextFont;
        m_titleLabel.textColor = TextColor;
        [self.contentView addSubview:m_titleLabel];
        
        m_arrowView = [[UIImageView alloc] initWithImage:NOSELECT];
        m_arrowView.frame = CGRectMake(280, (TableCellHeight - 30) / 2, 30, 30);
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
        m_arrowView.image = SELECTED;
    }else{
        self.contentView.backgroundColor = BackGroundColor;
        m_arrowView.image = NOSELECT;
    }
}

@end

