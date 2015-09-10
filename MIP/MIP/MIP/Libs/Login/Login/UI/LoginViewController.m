/********************************************************************
 Author: li_xiangai
 Class description:LoginViewController
 *******************************************************/

#import "LoginViewController.h"

#import "LoginView.h"

#import "LoginComponent.h"
#import "DisplayComponent.h"
#import "LoginNetRequest.h"

#import "MainViewController.h"

#define LaunchImageShowTime     5


@interface LoginViewController ()
{
    int   timeNum;
    
    UIImageView *launchImage;
}

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _loginView.rememberSwitch.on = NO;
    _loginView.usernameTextField.text = @"";
    _loginView.passwordTextField.text = @"";
    [_loginView.headerButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_loginView.headerButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    //判断是否自动登陆
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL autoLogin = [userDefaults boolForKey:AUTOLOGINKEY];
    _loginView.autoSwitch.on = autoLogin;
    _loginView.autoLoginBtn.selected = autoLogin;
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    //判断是否记住用户名
    NSString *username1 = [userDefaults objectForKey:LASTLOGINUSERNAMEKEY];
    
    if (username1 != nil)
    {
        
        if ([userDef objectForKey:username1])
        {
            NSString *str = [userDef objectForKey:username1];
            
            if (isValid(str))
            {
                UIImage *image = [UIImage imageWithContentsOfFile:str];
                
                if (image)
                {
                    [_loginView.headerButton setBackgroundImage:image forState:UIControlStateNormal];
                    [_loginView.headerButton setBackgroundImage:image forState:UIControlStateHighlighted];
                }
            }
        }
        
    }
    
    
    
    //判断是否记住用户名
    NSString *username = [userDefaults objectForKey:LASTLOGINUSERNAMEKEY];
//    NSString *password = [userDefaults objectForKey:LASTLOGINUSERPASSWORDKEY];
    
    if (isValid(username)) {
        
        //如果记住用户名,则将switch开关打开,并自动填入用户名信息到输入框
        
        [Userinfo setUserinfo:username];
                
        _loginView.rememberSwitch.on = YES;
        _loginView.rememberBtn.selected = YES;
        
        _loginView.usernameTextField.text = username;
        _loginView.passwordTextField.text = (NSString *)[userDefaults objectForKey:LASTLOGINUSERPASSWORDKEY];
    }
    else
    {
        _loginView.rememberSwitch.on = NO;
        _loginView.rememberBtn.selected = NO;
    }
    
    NSString *newAppVersion = [userDefaults objectForKey:kLastVersion];
    
    //判断最新版本和当前版本是否相同
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    newAppVersion = [newAppVersion stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (isValid(newAppVersion) && ![newAppVersion isEqualToString:@""] && ![newAppVersion isEqualToString:currentVersion])
    {
        _loginView.newsVersionLab.text = [NSString stringWithFormat:@"最新版本：v%@",newAppVersion];
        _loginView.checkVersionButton.hidden = NO;
    }
    else
    {
        _loginView.checkVersionButton.hidden = YES;
    }
    
    [self reflashRememberAutoButtonState];
    
    if (timer == nil)
    {
//        timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeLoginBackgroundImage) userInfo:nil repeats:YES];
    }
}

- (void)changeLoginBackgroundImage
{
    timeNum ++;
    
    if (timeNum > 6)
    {
        timeNum = 1;
    }
    
    [_loginView changeLoginImageView:timeNum];
}

- (void)viewWillDisappear:(BOOL)animated
{
//    [timer invalidate];
//    timer = nil;
    [super viewWillDisappear:animated];

}

- (void)reflashRememberAutoButtonState
{
    if (_loginView.autoLoginBtn.selected == YES)
    {
        [_loginView.autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"select.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        
        _loginView.rememberBtn.selected = YES;
        [_loginView.rememberBtn setBackgroundImage:[UIImage imageNamed:@"select.png" imageBundle:loginBundle] forState:UIControlStateNormal];
    }
    else
    {
        [_loginView.autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        
        if (_loginView.rememberBtn.selected == YES)
        {
            [_loginView.rememberBtn setBackgroundImage:[UIImage imageNamed:@"select.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        }
        else
        {
            [_loginView.rememberBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        }
    }
}

/*********************************************************************
 Function description: 创建视图
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (void)loadView
{
    //loginView
    _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-20)];
    _loginView.usernameTextField.keyboardType=UIKeyboardTypeASCIICapable;
    _loginView.usernameTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.view = _loginView;
   
}

/*********************************************************************
 Function description:加载视图后调用
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    timeNum = 1;
    
    //组建初始化
    _loginComponent = [[LoginComponent alloc] initWithComposite:self];
    
    _loginComponent.delegate = self;
    
    _displayComponent = [[DisplayComponent alloc] initWithComposite:self];
    
    //判断是否记住用户名
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:LASTLOGINUSERNAMEKEY];
    
    if (isValid(username)) {
        
        //如果记住用户名,则将switch开关打开,并自动填入用户名信息到输入框
        
        [Userinfo setUserinfo:username];
        
        Userinfo *userinfo = [Userinfo shareUserinfo];
        
        _loginView.rememberSwitch.on = YES;
        _loginView.rememberBtn.selected = YES;
        _loginView.usernameTextField.text = username;
        _loginView.passwordTextField.text = userinfo.password;
        _loginView.usernameTextField.keyboardType=UIKeyboardTypeASCIICapable;
        _loginView.usernameTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
        
    }
    else
    {
        _loginView.rememberSwitch.on = NO;
        _loginView.rememberBtn.selected = NO;
        
    }
    
    //判断是否自动登陆
    BOOL autoLogin = [userDefaults boolForKey:AUTOLOGINKEY];
    _loginView.autoSwitch.on = autoLogin;
    
    [self showLaunchImage];
    [NSTimer scheduledTimerWithTimeInterval:LaunchImageShowTime target:self
                                   selector:@selector(fireDelegate) userInfo:nil repeats:NO];
    
    //短信验证视图
    m_smsView = [[SMSWidgetView alloc] initWithFrame:CGRectMake(740, 240, 260, 90)];
    m_smsView.m_delegate = self;
    [self.view addSubview:m_smsView];
    m_smsView.hidden = YES;
    
    [self reflashRememberAutoButtonState];
}


- (void) fireDelegate
{
    [self hideLaunchImage];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL autoLogin = [userDefaults boolForKey:AUTOLOGINKEY];
    
    if (autoLogin)
    {
        [_loginComponent loginStart];
    }
}

#pragma mark _loginView
#pragma mark
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_loginView release];
    
    
    _loginComponent.delegate = nil;
    [_loginComponent release];
    
    [_displayComponent release];
    
    [super dealloc];
}

#pragma mark LoginComponentDelegate methods
- (void)LoginComponentSuccess {
    
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //登陆成功,如果发现用户选择了记住用户名,则将用户名记录在用户默认配置信息中
    if (_loginView.rememberBtn.selected) {
        
        [userDefaults setObject:_loginView.usernameTextField.text forKey:LASTLOGINUSERNAMEKEY];
        [userDefaults setObject:_loginView.passwordTextField.text forKey:LASTLOGINUSERPASSWORDKEY];
    }
    else {//否则删除上次登陆信息
        
        [userDefaults removeObjectForKey:LASTLOGINUSERNAMEKEY];
        [userDefaults removeObjectForKey:LASTLOGINUSERPASSWORDKEY];
    }
    
    //保存自动登录数据
    [userDefaults setBool:_loginView.autoLoginBtn.selected forKey:AUTOLOGINKEY];
    
    [userDefaults synchronize];
    
    //通知根控制器登陆成功,进行页面跳转
//    if ([_delegate respondsToSelector:@selector(loginSuccess)]) {
//        
//        [_delegate loginSuccess];
//    }
    
    //将设备token上传服务器
    /*
    if (isValid(devToken))
    {
        [LoginNetRequest executeAsynchronous:@selector(postDevToken) callback:@selector(callBackPostDevToken:error:) backTarget:self args:devToken,nil];
    }
     */
    //获取模块未读数
//    [LoginNetRequest executeAsynchronous:@selector(getModuleBadge) callback:@selector(callBackGetModuleBadge:error:) backTarget:self args:@"",nil];
    
    MainViewController *mainViewController = [[MainViewController alloc] init];
    [self.navigationController pushViewController:mainViewController animated:YES];
    [mainViewController release];
}

-(void)callBackPostDevToken:(NSData *)data error:(NSError*)error
{
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [LoginNetRequest extractDataBodyFromResponsePackage:data];
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
            
            if (0 == [ret intValue])
            {
                DLog(@"上传token成功");
            }
            else
            {
                DLog(@"上传token失败 \n %@",retMsg);
            }
        }
    }
}


-(void)callBackGetModuleBadge:(NSData *)data error:(NSError*)error
{
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [LoginNetRequest extractDataBodyFromResponsePackage:data];
        
        if (isValid(bodyData))
        {
            NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
            
            if (isValid(bodyDictionary))
            {
                NSString *ret = [bodyDictionary objectForKey:@"ret"];
                NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
                
                if (0 == [ret intValue])
                {
                    DLog(@"上传token成功");
                }
                else
                {
                    DLog(@"上传token失败 \n %@",retMsg);
                }
            }
        }
    }
}

#pragma mark SMSWidgetViewDelegate methods

- (void)getPhoneRandomCode
{
    if (isValid(m_smsView.m_phoneNumField.text))
    {
        [LoginNetRequest executeAsynchronous:@selector(getRandomCode) callback:@selector(callBackGetRandomCode:error:) backTarget:self args:m_smsView.m_phoneNumField.text,nil];
    }
}

- (void)verifyPhoneRandomCode
{
    if (isValid(m_smsView.m_phoneNumField.text) && isValid(m_smsView.m_verifyField.text))
    {
        [LoginNetRequest executeAsynchronous:@selector(verifyRandomCode) callback:@selector(callBackVerifyRandomCode:error:) backTarget:self args:m_smsView.m_phoneNumField.text,m_smsView.m_verifyField.text,nil];
    }
}

-(void)callBackGetRandomCode:(NSData *)data error:(NSError*)error
{
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [LoginNetRequest extractDataBodyFromResponsePackage:data];
        
        if (isValid(bodyData))
        {
            //NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
            //DLog(@"%@",bodyDictionary);
        }
    }
}

-(void)callBackVerifyRandomCode:(NSData *)data error:(NSError*)error
{
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [LoginNetRequest extractDataBodyFromResponsePackage:data];
        
        if (isValid(bodyData))
        {
            //NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
            //DLog(@"%@",bodyDictionary);
        }
    }
}

- (void) showLaunchImage
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *imgVerCode = [userDefault objectForKey:IMAGEVERCODE];
    
    UIImage *tmpImage = nil;
    
    if (!isValid(imgVerCode)) {
        
        tmpImage = [UIImage imageNamed:@"BackGround_640x1136"];
        
    }else {
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *pngFilePath = [NSString stringWithFormat:@"%@/launch.png",docDir];
        
        tmpImage = [UIImage imageWithContentsOfFile:pngFilePath];
        
    }
    
    launchImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self showLaunchImage:tmpImage];
    
    [self.view addSubview:launchImage];
    
    [_loginComponent checkLaunchImage];
}

- (void) showLaunchImage:(UIImage *)image
{
    launchImage.image = image;
}

- (void) hideLaunchImage
{
    [UIView animateWithDuration:0.5 animations:^{
        launchImage.alpha = 0.0;
    } completion:^(BOOL finished){
        [launchImage removeFromSuperview];
        [launchImage release];
        launchImage = nil;
    }];
    
}

@end
