//
//  PersonalInfoCardView.m
//  Contacts
//
//  Created by mengxianglei on 14-5-13.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import "PersonalInfoCardView.h"

#define FrameWidth              frame.size.width
#define FrameHeight             frame.size.height

#define TitleTextFrame          CGRectMake(65, 0, 190, 50)
#define TitleTextColor          [UIColor whiteColor]
#define TitleTextFont           [UIFont boldSystemFontOfSize:22]

#define TitleBgViewFrame        CGRectMake(0, 20, FrameWidth, 53.5)
#define TitleBgViewImage        [UIImage imageNamed:@"title.png" imageBundle:contactsBundle]

#define BackButtonFrame         CGRectMake(5, 5, 60, 39.5)
#define BackButtonBgImage       [UIImage imageNamed:@"t_back.png" imageBundle:contactsBundle]

#define lineHeight          (28.0)
#define lineBlockHeight     (2.0)

#define ScrollViewOriginX   (0.0)
#define ScrollViewOriginY   (100.0)

@implementation PersonalInfoCardView

@synthesize m_delegate;

@dynamic title;

@synthesize headerImageView;

@synthesize telephoneField;

@synthesize emailField;

@synthesize dutyField;

@synthesize bakTelField;

@synthesize officeTelField;

@synthesize bakOfficeTelField;

@synthesize perEmailField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        m_headerBgView = [[UIImageView alloc] initWithImage:TitleBgViewImage];
        m_headerBgView.frame = TitleBgViewFrame;
        m_headerBgView.userInteractionEnabled = YES;
        [self addSubview:m_headerBgView];
        
        m_lblTableTitle = [[UILabel alloc] initWithFrame:TitleTextFrame];
        m_lblTableTitle.font = TitleTextFont;
        m_lblTableTitle.textColor = TitleTextColor;
        m_lblTableTitle.textAlignment = NSTextAlignmentCenter;
        m_lblTableTitle.adjustsFontSizeToFitWidth = YES;
        m_lblTableTitle.minimumScaleFactor = 16.0;
        m_lblTableTitle.backgroundColor = [UIColor clearColor];
        [m_headerBgView addSubview:m_lblTableTitle];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = BackButtonFrame;
        [backBtn setBackgroundImage:BackButtonBgImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [m_headerBgView addSubview:backBtn];
        
        contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, FrameWidth, FrameHeight)];
        contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:contentView];
        
        UIImageView *contentBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FrameWidth, FrameHeight)];
        contentBgView.image = [[UIImage imageNamed:@"tc_bg.png" imageBundle:settingBundle] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 0, 100, 0) resizingMode:(UIImageResizingModeStretch)];
        [contentView addSubview:contentBgView];
        [contentBgView release];
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, FrameWidth, FrameHeight - 50)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:whiteView];
        [whiteView release];
        
//        headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, 80, 80)];
//        [contentView addSubview:headerImageView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, 200, 60)];
        nameLabel.font = [UIFont systemFontOfSize:30];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        [contentView addSubview:nameLabel];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(ScrollViewOriginX, ScrollViewOriginY, contentView.frame.size.width, FrameHeight - 50)];
        scrollView.contentSize = scrollView.frame.size;
        scrollView.backgroundColor = [UIColor clearColor];
        [contentView addSubview:scrollView];
        
        CGFloat originY = 20.0;
        
        UILabel *officePhoneLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
        officePhoneLab.text = @"机构:";
        officePhoneLab.font = [UIFont boldSystemFontOfSize:16];
        officePhoneLab.textColor = [UIColor grayColor];
        officePhoneLab.textAlignment = NSTextAlignmentRight;
        officePhoneLab.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:officePhoneLab];
        [officePhoneLab release];
        
        originY += lineHeight + lineBlockHeight;
        
        UILabel *departLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
        departLab.text = @"部门:";
        departLab.font = [UIFont boldSystemFontOfSize:16];
        departLab.textColor = [UIColor grayColor];
        departLab.textAlignment = NSTextAlignmentRight;
        departLab.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:departLab];
        [departLab release];
        
        originY += lineHeight + lineBlockHeight;
        
        UILabel *dutyLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
        dutyLab.text = @"职务:";
        dutyLab.font = [UIFont boldSystemFontOfSize:16];
        dutyLab.textColor = [UIColor grayColor];
        dutyLab.textAlignment = NSTextAlignmentRight;
        dutyLab.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:dutyLab];
        [dutyLab release];
        
        originY += lineHeight + lineBlockHeight;
        
        UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
        phoneLab.text = @"工作手机:";
        phoneLab.font = [UIFont boldSystemFontOfSize:16];
        phoneLab.textColor = [UIColor grayColor];
        phoneLab.textAlignment = NSTextAlignmentRight;
        phoneLab.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:phoneLab];
        [phoneLab release];
        
        originY += lineHeight + lineBlockHeight;
        
        UILabel *bakTelLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
        bakTelLab.text = @"备用手机:";
        bakTelLab.font = [UIFont boldSystemFontOfSize:16];
        bakTelLab.textColor = [UIColor grayColor];
        bakTelLab.textAlignment = NSTextAlignmentRight;
        bakTelLab.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:bakTelLab];
        [bakTelLab release];
        
        originY += lineHeight + lineBlockHeight;
        
        UILabel *officeTelLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
        officeTelLab.text = @"办公电话:";
        officeTelLab.font = [UIFont boldSystemFontOfSize:16];
        officeTelLab.textColor = [UIColor grayColor];
        officeTelLab.textAlignment = NSTextAlignmentRight;
        officeTelLab.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:officeTelLab];
        [officeTelLab release];
        
        originY += lineHeight + lineBlockHeight;
        
        UILabel *bakOfficeTel = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
        bakOfficeTel.text = @"备用电话:";
        bakOfficeTel.font = [UIFont boldSystemFontOfSize:16];
        bakOfficeTel.textColor = [UIColor grayColor];
        bakOfficeTel.textAlignment = NSTextAlignmentRight;
        bakOfficeTel.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:bakOfficeTel];
        [bakOfficeTel release];
        
        originY += lineHeight + lineBlockHeight;
        
        UILabel *mailLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
        mailLab.text = @"集团邮箱:";
        mailLab.font = [UIFont boldSystemFontOfSize:16];
        mailLab.textColor = [UIColor grayColor];
        mailLab.textAlignment = NSTextAlignmentRight;
        mailLab.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:mailLab];
        [mailLab release];
        
        originY += lineHeight + lineBlockHeight;
        
        UILabel *perEmailLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
        perEmailLab.text = @"个人邮箱:";
        perEmailLab.font = [UIFont boldSystemFontOfSize:16];
        perEmailLab.textColor = [UIColor grayColor];
        perEmailLab.textAlignment = NSTextAlignmentRight;
        perEmailLab.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:perEmailLab];
        [perEmailLab release];
        
        originY += lineHeight + lineBlockHeight;
        
        UILabel *weiboLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - 5 - ScrollViewOriginX, originY, 85, lineHeight)];
        weiboLab.text = @"云之家微博:";
        weiboLab.font = [UIFont boldSystemFontOfSize:16];
        weiboLab.textColor = [UIColor grayColor];
        weiboLab.textAlignment = NSTextAlignmentRight;
        weiboLab.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:weiboLab];
        [weiboLab release];
        
        originY = 20.0;
        
        officTelField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        officTelField.backgroundColor = [UIColor clearColor];
        officTelField.font = [UIFont systemFontOfSize:16];
        
        officTelField.textAlignment = NSTextAlignmentLeft;
        officTelField.enabled = NO;
        officTelField.textColor = [UIColor blackColor];
        [scrollView addSubview:officTelField];
        
        originY += lineHeight + lineBlockHeight;
        
        departField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        departField.backgroundColor = [UIColor clearColor];
        departField.font = [UIFont systemFontOfSize:16];
        
        departField.textAlignment = NSTextAlignmentLeft;
        departField.enabled = NO;
        departField.textColor = [UIColor blackColor];
        [scrollView addSubview:departField];
        
        originY += lineHeight + lineBlockHeight;
        
        dutyField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        dutyField.backgroundColor = [UIColor clearColor];
        dutyField.font = [UIFont systemFontOfSize:16];
        
        dutyField.textAlignment = NSTextAlignmentLeft;
        dutyField.enabled = NO;
        dutyField.textColor = [UIColor blackColor];
        [scrollView addSubview:dutyField];
        
        originY += lineHeight + lineBlockHeight;
        
        telephoneField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        telephoneField.backgroundColor = [UIColor clearColor];
        telephoneField.font = [UIFont systemFontOfSize:16];
        
        telephoneField.textAlignment = NSTextAlignmentLeft;
        telephoneField.enabled = NO;
        telephoneField.textColor = [UIColor blackColor];
        [scrollView addSubview:telephoneField];
        
        originY += lineHeight + lineBlockHeight;
        
        bakTelField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        bakTelField.backgroundColor = [UIColor clearColor];
        bakTelField.font = [UIFont systemFontOfSize:16];
        
        bakTelField.textAlignment = NSTextAlignmentLeft;
        bakTelField.enabled = NO;
        bakTelField.textColor = [UIColor blackColor];
        [scrollView addSubview:bakTelField];
        
        originY += lineHeight + lineBlockHeight;
        
        officeTelField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        officeTelField.backgroundColor = [UIColor clearColor];
        officeTelField.font = [UIFont systemFontOfSize:16];
        
        officeTelField.textAlignment = NSTextAlignmentLeft;
        officeTelField.enabled = NO;
        officeTelField.textColor = [UIColor blackColor];
        [scrollView addSubview:officeTelField];
        
        originY += lineHeight + lineBlockHeight;
        
        bakOfficeTelField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        bakOfficeTelField.backgroundColor = [UIColor clearColor];
        bakOfficeTelField.font = [UIFont systemFontOfSize:16];
        
        bakOfficeTelField.textAlignment = NSTextAlignmentLeft;
        bakOfficeTelField.enabled = NO;
        bakOfficeTelField.textColor = [UIColor blackColor];
        [scrollView addSubview:bakOfficeTelField];
        
        originY += lineHeight + lineBlockHeight;
        
        emailField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        emailField.backgroundColor = [UIColor clearColor];
        emailField.font = [UIFont systemFontOfSize:16];
        
        emailField.textAlignment = NSTextAlignmentLeft;
        emailField.enabled = NO;
        emailField.textColor = [UIColor blackColor];
        [scrollView addSubview:emailField];
        
        originY += lineHeight + lineBlockHeight;
        
        perEmailField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        perEmailField.backgroundColor = [UIColor clearColor];
        perEmailField.font = [UIFont systemFontOfSize:16];
        
        perEmailField.textAlignment = NSTextAlignmentLeft;
        perEmailField.enabled = NO;
        perEmailField.textColor = [UIColor blackColor];
        [scrollView addSubview:perEmailField];
        
        originY += lineHeight + lineBlockHeight;
        
        weiboField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
        weiboField.backgroundColor = [UIColor clearColor];
        weiboField.font = [UIFont systemFontOfSize:16];
        
        weiboField.textAlignment = NSTextAlignmentLeft;
        weiboField.enabled = NO;
        weiboField.textColor = [UIColor blackColor];
        [scrollView addSubview:weiboField];
        
        [self bringSubviewToFront:m_headerBgView];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    m_lblTableTitle.text = title;
}

- (NSString *)title
{
    return m_lblTableTitle.text;
}

- (void)setTextForPerContactsInfo:(PerContactsInfo *) perContactsInfo
{
//    if (isValid(perContactsInfo.headpicurl) && ![perContactsInfo.headpicurl isEqualToString:@""])
//    {
//        NSData *headImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:perContactsInfo.headpicurl]];
//        UIImage *headPic = [UIImage imageWithData:headImageData];
//        headerImageView.image = headPic;
//    }else {
//        headerImageView.image = [UIImage imageNamed:@"login_defaultHeader.png" imageBundle:loginBundle];
//    }
    
    if (isValid(perContactsInfo.name))
    {
        nameLabel.text = perContactsInfo.name;
    }
    
    if (isValid(perContactsInfo.companyname))
    {
        officTelField.text = perContactsInfo.companyname;
    }
    
    if (isValid(perContactsInfo.tel))
    {
        telephoneField.text = perContactsInfo.tel;
    }
    
    if (isValid(perContactsInfo.email))
    {
        emailField.text = perContactsInfo.email;
    }
    
    if (isValid(perContactsInfo.departmentname))
    {
        departField.text = perContactsInfo.departmentname;
    }
    
    if (isValid(perContactsInfo.duty))
    {
        dutyField.text = perContactsInfo.duty;
    }
    
    if (isValid(perContactsInfo.baktel))
    {
        bakTelField.text = perContactsInfo.baktel;
    }
    
    if (isValid(perContactsInfo.officetel))
    {
        officeTelField.text = perContactsInfo.officetel;
    }
    
    if (isValid(perContactsInfo.bakofficetel))
    {
        bakOfficeTelField.text = perContactsInfo.bakofficetel;
    }
    
    if (isValid(perContactsInfo.peremail))
    {
        perEmailField.text = perContactsInfo.peremail;
    }
    
    if (isValid(perContactsInfo.markweibo))
    {
        weiboField.text = [perContactsInfo.markweibo boolValue] ? @"已开通" : @"未开通";
    }
}

- (void)dealloc
{
    [m_headerBgView release];
    
    [m_lblTableTitle release];
    
    [officTelField release];
    
    [emailField release];
    
    [telephoneField release];
    
    [departField release];
    
    [dutyField release];
    
    [bakTelField release];
    
    [officeTelField release];
    
    [bakOfficeTelField release];
    
    [perEmailField release];
    
    [weiboField release];
    
    [scrollView release];
    
    [contentView release];
    
    [super dealloc];
}

- (void) backButtonClick
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(backBtnClick)]) {
        [m_delegate backBtnClick];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
