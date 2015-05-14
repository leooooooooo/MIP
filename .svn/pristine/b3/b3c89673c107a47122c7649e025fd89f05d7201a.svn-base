/********************************************************************
 Author: li_xiangai
 Class description:LoginView
 *******************************************************/
#import "LoginView.h"
#import "UIColor+CustomExtensions.h"


@implementation LoginView

@synthesize usernameTextField;
@synthesize passwordTextField;

@synthesize loginButton,headerButton;
@synthesize helpButton;

@synthesize usernameSwitch;

@synthesize versionLabel,newsVersionLab,checkVersionButton;
@synthesize rememberSwitch,autoSwitch;

@synthesize noUpdateButton;

@synthesize m_delegate;

@synthesize rememberBtn;
@synthesize autoLoginBtn;

/*********************************************************************
 Function description:初始化视图
 Parameter: frame
 Return value: id
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = CGRectMake(0, 20, frame.size.width, frame.size.height);
        [bgButton addTarget:self action:@selector(hiddenKeyboard:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
                
        // Initialization code
         _backImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"login_background_land.png" imageBundle:loginBundle]];
        _backImage.frame = CGRectMake(0, 20, frame.size.width, frame.size.height);
        [self addSubview:_backImage];
        
        _logoImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"logo.png" imageBundle:loginBundle]];
        _logoImage.frame = CGRectMake(29, 50, 262, 58);
        [self addSubview:_logoImage];
        
        //help Button
        helpButton = [[UIButton alloc] initWithFrame:CGRectMake(1024-150-20, 10, 150, 50)];
        [helpButton setBackgroundImage:[UIImage imageWithContentsOfFile:@"login_help.png" imageBundle:loginBundle] forState:UIControlStateNormal];
//        [self addSubview: helpButton];
        
        UIView  *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 320, 270)];
        contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:contentView];
        [contentView release];
        
        //头像
        headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [headerButton setFrame:CGRectMake(297, 242, 80, 80)];
        [self addSubview: headerButton];
        headerButton.hidden = YES;
        
         //username
        UIImageView *usernameBackimage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"input.png" imageBundle:loginBundle]];
        [usernameBackimage setFrame:CGRectMake(15, 41, 290, 36)];
        [contentView addSubview:usernameBackimage];
        [usernameBackimage release];
        
        UIImageView *accountimage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"login_username.png" imageBundle:loginBundle]];
        [accountimage setFrame:CGRectMake(14, 43, 30, 30)];
        [contentView addSubview:accountimage];
        [accountimage release];
        
        usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 37, 234, 40)];
        usernameTextField.placeholder = @"输入用户名";
        usernameTextField.font = [UIFont systemFontOfSize:18];
        [usernameTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        usernameTextField.clearButtonMode = UITextFieldViewModeNever;
        usernameTextField.backgroundColor = [UIColor clearColor];
        [contentView addSubview:usernameTextField];
        
        //password  backimage
        UIImageView *passwordBackimage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"input.png" imageBundle:loginBundle]];
        [passwordBackimage setFrame:CGRectMake(15, 92, 290, 36)];
        [contentView addSubview:passwordBackimage];
        [passwordBackimage release];
        
        UIImageView *passwordImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"login_passcode.png" imageBundle:loginBundle]];
        [passwordImage setFrame:CGRectMake(14, 95, 30, 30)];
        [contentView addSubview:passwordImage];
        [passwordImage release];
        
        //密码输入框
        passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 90, 234, 40)];
        passwordTextField.placeholder = @"输入密码";
        passwordTextField.secureTextEntry = YES;
        passwordTextField.font = [UIFont systemFontOfSize:18];
        [passwordTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        passwordTextField.returnKeyType = UIReturnKeyGo;
        passwordTextField.backgroundColor = [UIColor clearColor];
        [contentView addSubview: passwordTextField];
        
        
        UILabel *nameSwitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 150, 150, 29)];
        nameSwitchLabel.text = @"记住用户名/密码";
        nameSwitchLabel.font = [UIFont systemFontOfSize:14];
        [nameSwitchLabel setTextColor:[UIColor whiteColor]];
        [nameSwitchLabel setBackgroundColor:[UIColor clearColor]];
        [contentView addSubview:nameSwitchLabel];
        [nameSwitchLabel release];
        
        UILabel *autoLoginLab = [[UILabel alloc] initWithFrame:CGRectMake(230, 150, 150, 29)];
        autoLoginLab.text = @"自动登录";
        autoLoginLab.font = [UIFont systemFontOfSize:14];
        [autoLoginLab setTextColor:[UIColor whiteColor]];
        [autoLoginLab setBackgroundColor:[UIColor clearColor]];
        [contentView addSubview:autoLoginLab];
        [autoLoginLab release];
        
        
        rememberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rememberBtn.frame = CGRectMake(15, 150, 30, 30);
        [rememberBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        [rememberBtn addTarget:self action:@selector(rememberButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:rememberBtn];
        
        autoLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        autoLoginBtn.frame = CGRectMake(200, 150, 30, 30);
        [autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        [autoLoginBtn addTarget:self action:@selector(autoLoginButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:autoLoginBtn];
        
        //login Button
        loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setFrame:CGRectMake(15, 195, 290, 40)];
        loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setBackgroundImage:
         [UIImage imageWithContentsOfFile:@"button_login.png" imageBundle:loginBundle]
                               forState:UIControlStateNormal];
        [contentView addSubview: loginButton];        
        
        
        UILabel *copyright = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-18, 320, 40)];
        copyright.textColor = [UIColor colorWithRed:66/255.0 green:87/255.0 blue:109/255.0 alpha:1.0];
        [copyright setBackgroundColor:[UIColor clearColor]];
        copyright.font = [UIFont systemFontOfSize:14];
        copyright.textAlignment = UITextAlignmentCenter;
        copyright.numberOfLines = 2;
        copyright.text = @"Copyright  (C) 2014\n连云港港口集团通信信息工程公司";
        [self addSubview:copyright];
        [copyright release];
        
        checkVersionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkVersionButton setFrame:CGRectMake(10, frame.size.height-75, 150, 25)];
        [checkVersionButton addTarget:self action:@selector(checkNewVersion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:checkVersionButton];
        
        newsVersionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
        newsVersionLab.userInteractionEnabled = NO;
        newsVersionLab.font = [UIFont systemFontOfSize:14];
        newsVersionLab.textAlignment = UITextAlignmentLeft;
        newsVersionLab.textColor = [UIColor colorWithRed:42/255.0 green:135/255.0 blue:240/255.0 alpha:1.0];
        [newsVersionLab setBackgroundColor:[UIColor clearColor]];
        [checkVersionButton addSubview:newsVersionLab];

        
        versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height-55, 150, 25)];
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        versionLabel.text = [NSString stringWithFormat:@"版本：v%@",currentVersion];
        versionLabel.font = [UIFont systemFontOfSize:14];
        versionLabel.textAlignment = UITextAlignmentLeft;
        [versionLabel setBackgroundColor:[UIColor clearColor]];
        versionLabel.textColor = [UIColor whiteColor];
        [self addSubview:versionLabel];
                
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
        
        isButtonShow = NO;
    }
    return self;
}

- (void)changeLoginImageView:(int)imageNum
{
    NSString *imageName = [NSString stringWithFormat:@"bg_%d.png",imageNum];
    
    UIImage *image = [UIImage imageNamed:imageName imageBundle:loginBundle];
    
    _backImage.image = image;
}

/*********************************************************************
 Function description:检查最新版本事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)checkNewVersion:(id)sender
{
    isButtonShow = YES;
    
    [self showUpdataViewWithType:UpdateType_Normal];
}


/*********************************************************************
 Function description:显示版本更新提示事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)showUpdataViewWithType:(UpdateType)_type
{
    upgradeAlert = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.6;
    [upgradeAlert addSubview:bgView];
    [bgView release];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 320, 200)];
    contentView.backgroundColor = [UIColor clearColor];
    [upgradeAlert addSubview:contentView];
    [contentView release];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    bgImageView.image = [UIImage imageNamed:@"upgrade_box.png" imageBundle:loginBundle];
    [contentView addSubview:bgImageView];
    [bgImageView release];
    
    //描述信息
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, upgradeAlert.frame.size.width, 50)];
    titleLab.text = @"升级更新";
    titleLab.font = [UIFont boldSystemFontOfSize:22];
    titleLab.textAlignment = UITextAlignmentCenter;
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:titleLab];
    [titleLab release];
    
    UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, 280, 85)];
    contentTextView.editable = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *updateLog = [userDefaults objectForKey:kVersionUpdateLog];
    
    contentTextView.text = updateLog;
    contentTextView.font = [UIFont boldSystemFontOfSize:16];
    [contentTextView setTextColor:[UIColor colorWithHex:@"474747"]];
    [contentTextView setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:contentTextView];
    [contentTextView release];
    
    if (_type == UpdateType_Force) //强制更新
    {
        UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        updateButton.frame = CGRectMake(150, 135, 140, 40);
        [updateButton setTitle:@"确定" forState:UIControlStateNormal];
        [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [updateButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        [updateButton addTarget:self action:@selector(updateNewVersion:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:updateButton];
    }
    else //普通升级
    {
        UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        updateButton.frame = CGRectMake(20, 135, 130, 35);
        [updateButton setTitle:@"确定" forState:UIControlStateNormal];
        [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [updateButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        [updateButton addTarget:self action:@selector(updateNewVersion:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:updateButton];
        
        noUpdateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [noUpdateButton setTitle:@"取消" forState:UIControlStateNormal];
        [noUpdateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [noUpdateButton setBackgroundImage:[UIImage imageNamed:@"button_q.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        noUpdateButton.frame = CGRectMake(170, 135, 130, 35);
        [noUpdateButton addTarget:self action:@selector(noUpdateNewVersion:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:noUpdateButton];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:upgradeAlert];
    
    [self exChangeOut:contentView dur:0.3];
    
    [upgradeAlert release];
}


-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}

/*********************************************************************
 Function description:找回密码点击事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)showFindPasswordView
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 230)];
    
    bgImageView.image = [UIImage imageNamed:@"login_input.png" imageBundle:loginBundle];
    
//    CustomAlertView *alertView = [[CustomAlertView alloc] initWithBackgroundView:bgImageView];
    CustomNewAlertView *alertView = [[CustomNewAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    //描述信息
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, bgImageView.frame.size.width, 50)];
    titleLab.text = @"找回密码";
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    titleLab.textAlignment = UITextAlignmentCenter;
    [titleLab setTextColor:[UIColor blackColor]];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [alertView addTheview:titleLab];
    [titleLab release];
    
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 300, 100)];
    contentLab.text = @"请输入您的用户名，系统自动将新密码发送至此用户名注册时所留下的邮箱里。";
    contentLab.font = [UIFont systemFontOfSize:14];
    contentLab.numberOfLines = 2;
    contentLab.textAlignment = UITextAlignmentLeft;
    [contentLab setTextColor:[UIColor blackColor]];
    [contentLab setBackgroundColor:[UIColor clearColor]];
    [alertView addTheview:contentLab];
    [contentLab release];
    
    UIImageView *passwordBackimage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"input_gray.png" imageBundle:loginBundle]];
    [passwordBackimage setFrame:CGRectMake(50, 110, 300, 40)];
    [alertView addTheview:passwordBackimage];
    [passwordBackimage release];
    
    //用户名输入框
    UITextField *accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 110, 290, 40)];
    accountTextField.placeholder = @"请输入用户名";
    accountTextField.secureTextEntry = YES;
//    accountTextField.delegate = self;
    [accountTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    accountTextField.returnKeyType = UIReturnKeyGo;
    [alertView addTheview: accountTextField];
    [accountTextField release];
    
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    updateButton.frame = CGRectMake(80, 170, 90, 40);
    [updateButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateNewVersion:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addButton:updateButton];
    
    UIButton *noButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noButton setTitle:@"关闭" forState:UIControlStateNormal];
    noButton.frame = CGRectMake(220, 170, 90, 40);
    [noButton addTarget:self action:@selector(noUpdateNewVersion:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addButton:noButton];
    
    [alertView show];
    
    [bgImageView release];
    [alertView release];
}

/*********************************************************************
 Function description:记住密码开关事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)rememberSwitchAction
{
    if (rememberSwitch.on == NO)
    {
        [autoSwitch setOn:NO animated:YES];
    }
}

/*********************************************************************
 Function description:自动登录开关事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)autoSwitchAction
{
    if (autoSwitch.on == YES)
    {
        [rememberSwitch setOn:YES animated:YES];
    }
}

- (void)rememberButtonEvent
{
    rememberBtn.selected = !rememberBtn.selected;
    
    if (rememberBtn.selected == YES)
    {
        [rememberBtn setBackgroundImage:[UIImage imageNamed:@"select.png" imageBundle:loginBundle] forState:UIControlStateNormal];
    }
    else
    {
        [rememberBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        
        autoLoginBtn.selected = NO;
        [autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png" imageBundle:loginBundle] forState:UIControlStateNormal];
    }
}

- (void)autoLoginButtonEvent
{
    autoLoginBtn.selected = !autoLoginBtn.selected;
    
    if (autoLoginBtn.selected == YES)
    {
        [autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"select.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        
        rememberBtn.selected = YES;
        [rememberBtn setBackgroundImage:[UIImage imageNamed:@"select.png" imageBundle:loginBundle] forState:UIControlStateNormal];
    }
    else
    {
        [autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png" imageBundle:loginBundle] forState:UIControlStateNormal];        
    }
}

/*********************************************************************
 Function description:升级点击事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)updateNewVersion:(id)sender
{
    [upgradeAlert removeFromSuperview];
    
    //保存升级提示是否已经提示的标示
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:SHOWUPDATAKEY];
    [userDefaults synchronize];
    
    NSString *updateURL = [userDefaults objectForKey:kLastVersionURL];
    
    if (isValid(updateURL)) {
        
        NSURL *url = nil;
        
        float verson = [[UIDevice currentDevice].systemVersion floatValue];
        
        NSLog(@"----------------%f   %@",verson,updateURL);
        
        if (verson > 7.090000)
        {
            updateURL = [updateURL stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
            
            updateURL = [updateURL stringByReplacingOccurrencesOfString:@"8080" withString:@"8443"];
            
            NSLog(@"%@",updateURL);
            
            url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",updateURL]];
            NSLog(@"----------------%@",url);
        }
        else
        {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",updateURL]];
        }
        
        [[UIApplication sharedApplication] openURL:url];
    }
}


/*********************************************************************
 Function description:暂不升级点击事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)noUpdateNewVersion:(id)sender
{
    //保存升级提示是否已经提示的标示
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:SHOWUPDATAKEY];
    [userDefaults synchronize];
    
    //若为登录按钮点击弹出的更新提示，则点击不升级自动进入系统内；若为点击右下角新版本弹出的更新提示，则点击不升级不进入系统内
    if (isButtonShow == NO)
    {
        if (m_delegate)
        {
            [m_delegate noUpdateAction];
        }
    }
    
    [upgradeAlert removeFromSuperview];
}


/*********************************************************************
 Function description:键盘弹出事件
 Parameter: N/A
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)keyboardWillShow
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, -60, self.frame.size.width, self.frame.size.height);
    }];
}


/*********************************************************************
 Function description:键盘弹出事件
 Parameter: N/A
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)keyboardWillHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
}


/*********************************************************************
 Function description:单击背景隐藏键盘事件
 Parameter: N/A
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)hiddenKeyboard:(id)sender
{
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [self keyboardWillHidden];
}

/*********************************************************************
 Function description:销毁对象
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(void)dealloc
{
    [usernameSwitch release];
    [usernameTextField release];
    [passwordTextField release];
    [_backImage release];
    [newsVersionLab release];
    [versionLabel release];
    [helpButton release];

    [_logoImage release];

    [rememberSwitch release];
    [autoSwitch release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super dealloc];
}
@end
