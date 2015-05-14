//
//  DeviceBindView.m
//  Setting
//
//  Created by lu_sicong on 2014/04/17.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "DeviceBindView.h"
#import "InsetTextField.h"

#define PopFrameTopShadow       7
#define PopFrameBottomShadow    17

@implementation DeviceBindView

@synthesize passwordTextField;

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate withIsBind : (BOOL) isBind
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.backgroundColor = [UIColor blackColor];
        bgButton.alpha = 0.6;
        [bgButton setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bgButton addTarget:self action:@selector(keyboardWillHidden) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 96.5, 320, 320 + PopFrameTopShadow + PopFrameBottomShadow)];
        [self addSubview:contentView];
        
        UIImageView *contentBgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"pot_box.png" imageBundle:settingBundle] resizableImageWithCapInsets:UIEdgeInsetsMake(50, 0, 30, 0) resizingMode:UIImageResizingModeStretch]];
        contentBgView.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
        [contentView addSubview:contentBgView];
        [contentBgView release];
        
        UIView *whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, contentView.frame.size.width - 40, 230)];
        whiteBgView.backgroundColor = [UIColor clearColor];
        [contentView addSubview:whiteBgView];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, PopFrameTopShadow, contentView.frame.size.width, 40)];
        titleLab.text = @"设备绑定";
        titleLab.textAlignment = UITextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont boldSystemFontOfSize:22];
        titleLab.backgroundColor = [UIColor clearColor];
        [contentView addSubview:titleLab];
        [titleLab release];
        
        //描述信息
        Userinfo *userinfo = [Userinfo shareUserinfo];
        
        UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, whiteBgView.frame.size.width - 10, 25)];
        userNameLab.text = [NSString stringWithFormat:@"用户名：%@",userinfo.name_zhCN];
        userNameLab.font = [UIFont boldSystemFontOfSize:12];
        userNameLab.textAlignment = UITextAlignmentLeft;
        [userNameLab setTextColor:[UIColor blackColor]];
        [userNameLab setBackgroundColor:[UIColor clearColor]];
        [whiteBgView addSubview:userNameLab];
        [userNameLab release];
        
        UILabel *deviceTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 80, 25)];
        deviceTitleLab.text = [NSString stringWithFormat:@"硬件设备号："];
        deviceTitleLab.font = [UIFont boldSystemFontOfSize:12];
        deviceTitleLab.textAlignment = UITextAlignmentLeft;
        [deviceTitleLab setTextColor:[UIColor blackColor]];
        [deviceTitleLab setBackgroundColor:[UIColor clearColor]];
        [whiteBgView addSubview:deviceTitleLab];
        [deviceTitleLab release];
        
        UILabel *deviceLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 30, whiteBgView.frame.size.width - 80 - 10, 25)];
        deviceLab.text = [NSString stringWithFormat:@"%@",userinfo.deviceId];
        deviceLab.font = [UIFont boldSystemFontOfSize:12];
        deviceLab.numberOfLines = 2;
        deviceLab.adjustsFontSizeToFitWidth = YES;
        deviceLab.textAlignment = UITextAlignmentLeft;
        [deviceLab setTextColor:[UIColor blackColor]];
        [deviceLab setBackgroundColor:[UIColor clearColor]];
        [whiteBgView addSubview:deviceLab];
        [deviceLab release];
        
        /*
         UILabel *eMailLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 45, 100, 40)];
         eMailLab.text = @"电子邮箱:";
         eMailLab.textColor = [UIColor whiteColor];
         eMailLab.font = [UIFont boldSystemFontOfSize:14];
         eMailLab.backgroundColor = [UIColor clearColor];
         [checkImageView addSubview:eMailLab];
         [eMailLab release];
         
         UITextField *eMailTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 50, 250, 30)];
         eMailTextField.backgroundColor = [UIColor whiteColor];
         eMailTextField.font = [UIFont systemFontOfSize:14];
         eMailTextField.placeholder = @"注册使用的电子邮箱";
         eMailTextField.borderStyle = UITextBorderStyleLine;
         [checkImageView addSubview:eMailTextField];
         [eMailTextField release];
         */
        
        UILabel *passwordLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, 60, 25)];
        passwordLab.text = @"登录密码：";
        passwordLab.textColor = [UIColor blackColor];
        passwordLab.font = [UIFont boldSystemFontOfSize:12];
        passwordLab.textAlignment = NSTextAlignmentLeft;
        passwordLab.backgroundColor = [UIColor clearColor];
        [whiteBgView addSubview:passwordLab];
        [passwordLab release];
        
        passwordTextField = [[InsetTextField alloc] initWithFrame:CGRectMake(65, 60, whiteBgView.frame.size.width - 65, 25)];
        passwordTextField.font = [UIFont systemFontOfSize:12];
        passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        passwordTextField.backgroundColor = [UIColor whiteColor];
        passwordTextField.placeholder = @"登录使用的密码";
        passwordTextField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        [passwordTextField becomeFirstResponder];
        passwordTextField.secureTextEntry = YES;
        passwordTextField.inset = CGPointMake(8, 0);
        [whiteBgView addSubview:passwordTextField];
        [passwordTextField release];
        
        //描述信息
        UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, whiteBgView.frame.size.width-20, 150)];
        detailLab.text = @"1.当前用户可在一台平板电脑/手机做安全绑定。绑定后此用户名只可在已绑定的平板电脑/手机上登录使用；\n2.绑定设备需要使用注册的 登录密码 做身份安全校验；\n";
        detailLab.font = [UIFont boldSystemFontOfSize:12];
        detailLab.textAlignment = UITextAlignmentLeft;
        [detailLab setTextColor:[UIColor blackColor]];
        [detailLab setBackgroundColor:[UIColor clearColor]];
        detailLab.numberOfLines = 9;
        [whiteBgView addSubview:detailLab];
        [detailLab release];
        
        NSString *type = @"";
        
        if (isBind == YES)
        {
            type = @"绑定";
        }
        else
        {
            type = @"解绑";
        }
        
        UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        updateButton.frame = CGRectMake(5, 95, 130, 35);
        [updateButton addTarget:delegate action:@selector(noBlindDevice:) forControlEvents:UIControlEventTouchUpInside];
        [updateButton setTitle:[NSString stringWithFormat:@"暂不%@",type] forState:UIControlStateNormal];
        [updateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [updateButton setBackgroundImage:[UIImage imageNamed:@"button_q.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        updateButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [whiteBgView addSubview:updateButton];
        
        UIButton *noButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [noButton setTitle:[NSString stringWithFormat:@"确认%@",type] forState:UIControlStateNormal];
        noButton.frame = CGRectMake(145, 95, 130, 35);
        [noButton addTarget:delegate action:@selector(blindDevice:) forControlEvents:UIControlEventTouchUpInside];
        [noButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [noButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        noButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [whiteBgView addSubview:noButton];
        
        [whiteBgView release];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [contentView release];
    [super dealloc];
}

//键盘显示
- (void)keyboardWillShow
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = contentView.frame;
        rect.origin.y = 20;
        contentView.frame = rect;
    }];
}

//键盘隐藏
- (void)keyboardWillHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = contentView.frame;
        rect.origin.y = 96.5;
        contentView.frame = rect;
    }];
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
