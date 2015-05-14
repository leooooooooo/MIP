//
//  FilterCompanyView.m
//  Contacts
//
//  Created by mengxianglei on 14-5-14.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "FilterCompanyView.h"

@implementation FilterCompanyView

#define TitleTextFrame          CGRectMake(65, 0, 190, 50)
#define TitleTextColor          [UIColor whiteColor]
#define TitleTextFont           [UIFont boldSystemFontOfSize:22]

@dynamic title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        m_lblTableTitle = [[UILabel alloc] initWithFrame:TitleTextFrame];
        m_lblTableTitle.font = TitleTextFont;
        m_lblTableTitle.textColor = TitleTextColor;
        m_lblTableTitle.textAlignment = NSTextAlignmentCenter;
        m_lblTableTitle.adjustsFontSizeToFitWidth = YES;
        m_lblTableTitle.minimumScaleFactor = 16.0;
        m_lblTableTitle.backgroundColor = [UIColor clearColor];
        [m_headerBgView addSubview:m_lblTableTitle];
    }
    return self;
}

- (void)dealloc
{
    [m_lblTableTitle release];
    [super dealloc];
}

-(void)setTitle:(NSString *)title
{
    m_lblTableTitle.text = title;
}

- (NSString *)title
{
    return m_lblTableTitle.text;
}

@end
