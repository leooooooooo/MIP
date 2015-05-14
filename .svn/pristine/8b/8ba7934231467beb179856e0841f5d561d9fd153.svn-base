//
//  SMSWidgetView.m
//  Login
//
//  Created by kangqijun on 14-2-25.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "SMSWidgetView.h"

@implementation SMSWidgetView

@synthesize m_phoneNumField,m_verifyField,m_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.alpha = 0.6;
        [self addSubview:bgView];
        [bgView release];
        
        m_phoneNumField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 140, 30)];
        m_phoneNumField.borderStyle = UITextBorderStyleLine;
        m_phoneNumField.font = [UIFont systemFontOfSize:16];
        m_phoneNumField.placeholder = @"请输入手机号码";
        [self addSubview:m_phoneNumField];
        
        m_verifyField = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 140, 30)];
        m_verifyField.borderStyle = UITextBorderStyleLine;
        m_verifyField.font = [UIFont systemFontOfSize:18];
        m_verifyField.placeholder = @"请输入验证码";
        [self addSubview:m_verifyField];
        
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [phoneBtn setFrame:CGRectMake(160, 10, 90, 30)];
        [phoneBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [phoneBtn addTarget:self action:@selector(getRandomCode) forControlEvents:UIControlEventTouchUpInside];
        phoneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [phoneBtn setTitleColor:[UIColor colorWithHex:@"5173ab"] forState:UIControlStateNormal];
        [phoneBtn setBackgroundImage:[UIImage imageWithContentsOfFile:@"login_Button.png" imageBundle:loginBundle]
                               forState:UIControlStateNormal];
        [self addSubview:phoneBtn];
        
        UIButton *verifyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [verifyBtn setFrame:CGRectMake(160, 50, 90, 30)];
        [verifyBtn setTitle:@"验证验证码" forState:UIControlStateNormal];
        [verifyBtn addTarget:self action:@selector(verifyRandomCode) forControlEvents:UIControlEventTouchUpInside];
        verifyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [verifyBtn setTitleColor:[UIColor colorWithHex:@"5173ab"] forState:UIControlStateNormal];
        [verifyBtn setBackgroundImage:[UIImage imageWithContentsOfFile:@"login_Button.png" imageBundle:loginBundle]
                            forState:UIControlStateNormal];
        [self addSubview:verifyBtn];
    }
    return self;
}

- (void)getRandomCode
{
    if (m_delegate)
    {
        [m_delegate getPhoneRandomCode];
    }
}

- (void)verifyRandomCode
{
    if (m_delegate)
    {
        [m_delegate verifyPhoneRandomCode];
    }
}

- (void)dealloc
{
    [m_phoneNumField release];
    [m_verifyField release];
    [super dealloc];
}

@end
