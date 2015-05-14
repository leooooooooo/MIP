//
//  PersonInfo.m
//  Setting
//
//  Created by kangqijun on 14-3-13.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "PersonInfoView.h"
#import "InsetTextField.h"

#define PopFrameTopShadow       7
#define PopFrameBottomShadow    17

#define LineHeight              (30.0)
#define LineBlockHeight         (4.0)

#define BaseOriginY             (35.0)
#define TextFieldHeight         (LineHeight + 1.5)

@implementation PersonInfoView

@synthesize sureButton;

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
        //全屏背景按钮
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.backgroundColor = [UIColor blackColor];
        bgButton.alpha = 0.6;
        [bgButton setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bgButton addTarget:self action:@selector(keyboardWillHidden) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 36.5, 320, (SCREEN_HEIGHT + 475 - 568) + PopFrameTopShadow + PopFrameBottomShadow)];
        [self addSubview:contentView];
        
        UIImageView *contentBgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"pot_box.png" imageBundle:settingBundle] resizableImageWithCapInsets:UIEdgeInsetsMake(50, 0, 30, 0) resizingMode:UIImageResizingModeStretch]];
        contentBgView.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
        [contentView addSubview:contentBgView];
        [contentBgView release];
        
        whiteView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 55, contentView.frame.size.width - 35, contentView.frame.size.height - 82)];
        whiteView.backgroundColor = [UIColor clearColor];
        whiteView.contentSize = CGSizeMake(contentView.frame.size.width - 35, 420);
        [contentView addSubview:whiteView];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, PopFrameTopShadow, contentView.frame.size.width, 40)];
        titleLab.text = @"个人信息";
        titleLab.textAlignment = UITextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont boldSystemFontOfSize:22];
        titleLab.backgroundColor = [UIColor clearColor];
        [contentView addSubview:titleLab];
        [titleLab release];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 25)];
        nameLab.text = [NSString stringWithFormat:@"%@[%@]",[Userinfo shareUserinfo].name_zhCN,[Userinfo shareUserinfo].name];
        nameLab.font = [UIFont systemFontOfSize:20];
        nameLab.textColor = [UIColor blackColor];
        nameLab.textAlignment = UITextAlignmentCenter;
        nameLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:nameLab];
        [nameLab release];
        
        CGFloat originY = BaseOriginY;
        
        UILabel *officePhoneLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        officePhoneLab.text = @"机构";
        officePhoneLab.font = [UIFont boldSystemFontOfSize:16];
        officePhoneLab.textColor = [UIColor grayColor];
        officePhoneLab.textAlignment = UITextAlignmentRight;
        officePhoneLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:officePhoneLab];
        [officePhoneLab release];
        
        originY += LineHeight + LineBlockHeight;
        
        UILabel *departLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        departLab.text = @"部门";
        departLab.font = [UIFont boldSystemFontOfSize:16];
        departLab.textColor = [UIColor grayColor];
        departLab.textAlignment = UITextAlignmentRight;
        departLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:departLab];
        [departLab release];
        
        originY += LineHeight + LineBlockHeight;
        
        UILabel *dutyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        dutyLab.text = @"职务";
        dutyLab.font = [UIFont boldSystemFontOfSize:16];
        dutyLab.textColor = [UIColor grayColor];
        dutyLab.textAlignment = UITextAlignmentRight;
        dutyLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:dutyLab];
        [dutyLab release];
        
        originY += LineHeight + LineBlockHeight;
        
        UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        phoneLab.text = @"工作手机";
        phoneLab.font = [UIFont boldSystemFontOfSize:16];
        phoneLab.textColor = [UIColor grayColor];
        phoneLab.textAlignment = UITextAlignmentRight;
        phoneLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:phoneLab];
        [phoneLab release];
        
        originY += LineHeight + LineBlockHeight;
        
        UILabel *bakTelLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        bakTelLab.text = @"备用手机";
        bakTelLab.font = [UIFont boldSystemFontOfSize:16];
        bakTelLab.textColor = [UIColor grayColor];
        bakTelLab.textAlignment = UITextAlignmentRight;
        bakTelLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:bakTelLab];
        [bakTelLab release];
        
        originY += LineHeight + LineBlockHeight;
        
        UILabel *officeTelLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        officeTelLab.text = @"办公电话";
        officeTelLab.font = [UIFont boldSystemFontOfSize:16];
        officeTelLab.textColor = [UIColor grayColor];
        officeTelLab.textAlignment = UITextAlignmentRight;
        officeTelLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:officeTelLab];
        [officeTelLab release];
        
        originY += LineHeight + LineBlockHeight;
        
        UILabel *bakOfficeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        bakOfficeLab.text = @"备用电话";
        bakOfficeLab.font = [UIFont boldSystemFontOfSize:16];
        bakOfficeLab.textColor = [UIColor grayColor];
        bakOfficeLab.textAlignment = UITextAlignmentRight;
        bakOfficeLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:bakOfficeLab];
        [bakOfficeLab release];
        
        originY += LineHeight + LineBlockHeight;
        
        UILabel *mailLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        mailLab.text = @"集团邮箱";
        mailLab.font = [UIFont boldSystemFontOfSize:16];
        mailLab.textColor = [UIColor grayColor];
        mailLab.textAlignment = UITextAlignmentRight;
        mailLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:mailLab];
        [mailLab release];
        
        originY += LineHeight + LineBlockHeight;
        
        UILabel *perEmailLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        perEmailLab.text = @"个人邮箱";
        perEmailLab.font = [UIFont boldSystemFontOfSize:16];
        perEmailLab.textColor = [UIColor grayColor];
        perEmailLab.textAlignment = UITextAlignmentRight;
        perEmailLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:perEmailLab];
        [perEmailLab release];
        
        originY += LineHeight + LineBlockHeight;
        
        UILabel *weiboLab = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 65, LineHeight)];
        weiboLab.text = @"云之家";
        weiboLab.font = [UIFont boldSystemFontOfSize:16];
        weiboLab.textColor = [UIColor grayColor];
        weiboLab.textAlignment = UITextAlignmentRight;
        weiboLab.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:weiboLab];
        [weiboLab release];
        
        originY = BaseOriginY - 0.5;
        
        officTelField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        officTelField.backgroundColor = [UIColor clearColor];
        officTelField.font = [UIFont systemFontOfSize:15];
        officTelField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        officTelField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].company))
        {
            officTelField.text = [Userinfo shareUserinfo].company;
        }
        
        officTelField.textAlignment = UITextAlignmentLeft;
        officTelField.enabled = NO;
        officTelField.textColor = [UIColor blackColor];
        [whiteView addSubview:officTelField];
        
        originY += LineHeight + LineBlockHeight;
        
        departField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        departField.backgroundColor = [UIColor clearColor];
        departField.font = [UIFont systemFontOfSize:15];
        departField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        departField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].deptName))
        {
            departField.text = [Userinfo shareUserinfo].deptName;
        }
        
        departField.textAlignment = UITextAlignmentLeft;
        departField.enabled = NO;
        departField.textColor = [UIColor blackColor];
        [whiteView addSubview:departField];
        
        originY += LineHeight + LineBlockHeight;
        
        dutyField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        dutyField.backgroundColor = [UIColor clearColor];
        dutyField.font = [UIFont systemFontOfSize:15];
        dutyField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        dutyField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].duty))
        {
            dutyField.text = [Userinfo shareUserinfo].duty;
        }
        
        dutyField.textAlignment = UITextAlignmentLeft;
        dutyField.enabled = NO;
        dutyField.textColor = [UIColor blackColor];
        [whiteView addSubview:dutyField];
        
        originY += LineHeight + LineBlockHeight;
        
        telephoneField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        telephoneField.backgroundColor = [UIColor clearColor];
        telephoneField.font = [UIFont systemFontOfSize:15];
        telephoneField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        telephoneField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].telephone))
        {
            telephoneField.text = [Userinfo shareUserinfo].telephone;
        }
        
        telephoneField.textAlignment = UITextAlignmentLeft;
        telephoneField.enabled = NO;
        telephoneField.textColor = [UIColor blackColor];
        [whiteView addSubview:telephoneField];
        
        originY += LineHeight + LineBlockHeight;
        
        bakTelField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        bakTelField.backgroundColor = [UIColor clearColor];
        bakTelField.font = [UIFont systemFontOfSize:15];
        bakTelField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        bakTelField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].bakTel))
        {
            bakTelField.text = [Userinfo shareUserinfo].bakTel;
        }
        
        bakTelField.textAlignment = UITextAlignmentLeft;
        bakTelField.enabled = NO;
        bakTelField.textColor = [UIColor blackColor];
        [whiteView addSubview:bakTelField];
        
        originY += LineHeight + LineBlockHeight;
        
        officeTelField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        officeTelField.backgroundColor = [UIColor clearColor];
        officeTelField.font = [UIFont systemFontOfSize:15];
        officeTelField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        officeTelField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].officeTel))
        {
            officeTelField.text = [Userinfo shareUserinfo].officeTel;
        }
        
        officeTelField.textAlignment = UITextAlignmentLeft;
        officeTelField.enabled = NO;
        officeTelField.textColor = [UIColor blackColor];
        [whiteView addSubview:officeTelField];
        
        originY += LineHeight + LineBlockHeight;
        
        bakOfficeTelField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        bakOfficeTelField.backgroundColor = [UIColor clearColor];
        bakOfficeTelField.font = [UIFont systemFontOfSize:15];
        bakOfficeTelField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        bakOfficeTelField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].bakOfficeTel))
        {
            bakOfficeTelField.text = [Userinfo shareUserinfo].bakOfficeTel;
        }
        
        bakOfficeTelField.textAlignment = UITextAlignmentLeft;
        bakOfficeTelField.enabled = NO;
        bakOfficeTelField.textColor = [UIColor blackColor];
        [whiteView addSubview:bakOfficeTelField];
        
        originY += LineHeight + LineBlockHeight;
        
        emailField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        emailField.backgroundColor = [UIColor clearColor];
        emailField.font = [UIFont systemFontOfSize:15];
        emailField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        emailField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].email))
        {
            emailField.text = [Userinfo shareUserinfo].email;
        }
        
        emailField.textAlignment = UITextAlignmentLeft;
        emailField.enabled = NO;
        emailField.textColor = [UIColor blackColor];
        [whiteView addSubview:emailField];
        
        originY += LineHeight + LineBlockHeight;
        
        perEmailField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        perEmailField.backgroundColor = [UIColor clearColor];
        perEmailField.font = [UIFont systemFontOfSize:15];
        perEmailField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        perEmailField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].perEmail))
        {
            perEmailField.text = [Userinfo shareUserinfo].perEmail;
        }
        
        perEmailField.textAlignment = UITextAlignmentLeft;
        perEmailField.enabled = NO;
        perEmailField.textColor = [UIColor blackColor];
        [whiteView addSubview:perEmailField];
        
        originY += LineHeight + LineBlockHeight;
        
        weiboField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, originY, 206.5, TextFieldHeight)];
        weiboField.backgroundColor = [UIColor clearColor];
        weiboField.font = [UIFont systemFontOfSize:15];
        weiboField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        weiboField.inset = CGPointMake(8, 0);
        
        if (isValid([Userinfo shareUserinfo].markWeibo))
        {
            weiboField.text = [[Userinfo shareUserinfo].markWeibo boolValue]? @"已开通" : @"未开通";
        }
        
        weiboField.textAlignment = UITextAlignmentLeft;
        weiboField.enabled = NO;
        weiboField.textColor = [UIColor blackColor];
        [whiteView addSubview:weiboField];
        
        sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [sureButton setFrame:CGRectMake(5, 380, 130, 35)];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [whiteView addSubview:sureButton];
        
        UIButton *cancButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancButton setTitle:@"修改个人信息" forState:UIControlStateNormal];
        [cancButton setFrame:CGRectMake(145, 380, 130, 35)];
        [cancButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancButton setBackgroundImage:[UIImage imageNamed:@"button_q.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        [cancButton addTarget:self action:@selector(startSetting) forControlEvents:UIControlEventTouchUpInside];
        cancButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [whiteView addSubview:cancButton];
        
        [whiteView release];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(contentView.frame.size.width - 45, 9 + PopFrameTopShadow, 23, 22);
        [closeButton setBackgroundImage:[UIImage imageNamed:@"close.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeSettingView) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:closeButton];
                
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)closeSettingView
{
    [self removeFromSuperview];
}

- (void)startSetting
{
    telephoneField.enabled = YES;

    dutyField.enabled = YES;
    bakTelField.enabled = YES;
    officeTelField.enabled = YES;
    bakOfficeTelField.enabled = YES;
    perEmailField.enabled = YES;
    
    [telephoneField becomeFirstResponder];
}

- (void)keyboardWillShow
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = contentView.frame;
        rect.origin.y = 20;
        
        contentView.frame = rect;
        
        rect = whiteView.frame;
        rect.size.height -= 150;
        
        whiteView.frame = rect;
    }];
}

- (void)keyboardWillHidden
{
    telephoneField.enabled = NO;
    emailField.enabled = NO;
    
    dutyField.enabled = NO;
    bakTelField.enabled = NO;
    officeTelField.enabled = NO;
    bakOfficeTelField.enabled = NO;
    perEmailField.enabled = NO;
    
    telephoneField.borderStyle = UITextBorderStyleNone;
    emailField.borderStyle = UITextBorderStyleNone;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = contentView.frame;
        rect.origin.y = 36.5;
        contentView.frame = rect;
        
        rect = whiteView.frame;
        rect.size.height += 150;
        
        whiteView.frame = rect;
    }];
}

- (void)dealloc
{
    [headerImageView release];
    
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
    
    [contentView release];
    
    [super dealloc];
}

@end
