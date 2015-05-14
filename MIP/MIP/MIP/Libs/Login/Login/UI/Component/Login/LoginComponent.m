/********************************************************************
 Author: li_xiangai
 Class description:LoginComponent
 *******************************************************/
#import "LoginComponent.h"

#import "LoginViewController.h"

#import "MBProgressHUD.h"

#import "LoginNetRequest.h"

#import "LoginBLL.h"

#import "Reachability.h"


@implementation LoginComponent


- (id)initWithComposite:(id)composite {
    
    self = [super initWithComposite:composite];
    
    if (self) {
        
        _loginViewController = (LoginViewController *)composite;
        _loginView = _loginViewController->_loginView;
        _loginView.m_delegate = self;
        
        _loginView.usernameTextField.delegate =self;
        _loginView.passwordTextField.delegate = self;
        
        [_loginView.loginButton addTarget:self action:@selector(loginStart) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;

}

- (void)dealloc {
    
    [_HUD release];
    _HUD = nil;
    
    _loginViewController = nil;
    _loginView = nil;
    
    [super dealloc];
}


/*********************************************************************
 Function description:检测当前网络状态
 Parameter: N/A
 Return value: BOOL
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (BOOL)chectkCurrentNetWorkStatus
{
    BOOL isConnected = NO;
    NSString *serviceIp = [baseURL substringToIndex:33];
    
    Reachability *netWork = [Reachability reachabilityWithHostName:serviceIp];
    
    switch ([netWork currentReachabilityStatus])
    {
        case NotReachable:
        {
            // 没有网络连接
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"当前网络连接失败，是否进行离线登录?"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
            [alertView show];
            [alertView release];
            
            isConnected = NO;
            isOnline = NO;
            
            break;
        }
            
        case ReachableViaWWAN:
        {
            // 使用3G网络
            isConnected = YES;
            isOnline = YES;
            
            break;
        }
            
        case ReachableViaWiFi:
        {
            // 使用WiFi网络
            isConnected = YES;
            isOnline = YES;
            
            break;
        }
            
        default:
            break;
    }
    
    return isConnected;
}

- (void) checkLaunchImage
{
    [LoginNetRequest executeAsynchronous:@selector(launchImageGet) callback:@selector(launchImageCallback:error:) backTarget:self args:nil];
}

- (void) showImage
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/launch.png",docDir];
    
    [_loginViewController showLaunchImage: [UIImage imageWithContentsOfFile:pngFilePath]];
}

- (void) launchImageCallback:(NSData *)data error: (NSError *)error
{
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [LoginNetRequest extractDataBodyFromResponsePackage:data];
        
        if (!bodyData) {
            
            NSLog(@"get launch image's url has a error");
            
            NSLog(@"\n%@", baseURL);
            
            return;
        }
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            
            if (0 == [ret intValue])
            {
                if ([LoginBLL synchroniseLaunchImage:bodyData]) {
                    [self showImage];
                }
                
                return;
            }
        }
    }
    
    return;
}

/*********************************************************************
 Function description:登录按钮点击事件
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (void)loginStart
{   
    //检查用户名，密码
   checkUserType type = [self checkUserName:_loginView.usernameTextField.text passport:_loginView.passwordTextField.text];
    
    switch (type)
    {
        case USERNAMENULL:   //用户名为空
        {
            

            dispatch_async(dispatch_get_main_queue(), ^{
            
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录错误"
                                                                    message:@"用户名为空，请输入用户名！"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                
            });
            
            [_loginView.usernameTextField becomeFirstResponder];
        
        }
            break;
        case PASSWORDNULL:  //密码为空
        {

            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录错误"
                                                                message:@"密码为空，请输入密码！"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            [_loginView.passwordTextField becomeFirstResponder];
            
        }
            break;
        case READYLOGIN:    //格式正确，登录
        {
            
            [Userinfo setUserinfo:_loginView.usernameTextField.text];
            
            /*
            Reachability 只是说检测当前网络状态被切换了 如果想检测服务器的连通性是需要写请求才可以
             所以用它来判断客户端与服务器是正常连接实不可取的。
             
            //先检测网络状态，如果未连接，则提示
            BOOL isConnect = [self chectkCurrentNetWorkStatus];
            if (isConnect == NO)
            {
                return;
            }
             */
            
            [_loginView.usernameTextField resignFirstResponder];
            [_loginView.passwordTextField resignFirstResponder];
            
            //发送请求，设置回调
            
            Userinfo *userinfo = [Userinfo shareUserinfo];
            
            userinfo.name = _loginView.usernameTextField.text;
            
            userinfo.password = _loginView.passwordTextField.text;

            if (!_HUD) {
                
                _HUD = [[MBProgressHUD alloc] initWithView:_loginView];
                [_loginView addSubview:_HUD];
                _HUD.minSize = CGSizeMake(430, 40);

                _HUD.yOffset = -90;
                
            }
           
            _HUD.labelText = @"登录中请等待...";
            [_HUD show:YES];
            
            [LoginNetRequest executeAsynchronous:@selector(login) callback:@selector(callbackLogin:error:) backTarget:self args:userinfo.password,nil];

        }
            break;
            
        default:
            break;
    }



}

/*********************************************************************
 Function description:登录请求的回调
 Parameter: data   返回数据
 Parameter: error  错误信息 
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/

-(void)callbackLogin:(NSData *)data error:(NSError*)error
{
    [_HUD hide:YES];
    
    if (data != nil)
    {
        //获取body中的数据
        NSData *bodyData = [LoginNetRequest extractDataBodyFromResponsePackage:data destinationPath:@"a" filePath:NULL];
        
        if (bodyData == nil)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"解析登录数据失败！"
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"确定", nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            _loginView.loginButton.hidden = NO;
            
            //数据解析
            [LoginBLL synchroniseUserinfo:bodyData];
            
            [self someWrongJudge];
        }
        
        isOnline = YES;
    }
    else
    {
        /*
        // 没有网络连接
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"当前网络连接失败，是否进行离线登录?"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        */
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"网络连接失败，请检查网络连接状态！"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        
        isOnline = NO;
    }
}

//错误判断
- (void)someWrongJudge
{
    Userinfo *userinfo = [Userinfo shareUserinfo];
    
    NSString *codeMsg = nil;
    
    switch (userinfo.loginCode)
    {
        case LoginStatues_success:
        {
            
            break;
        }
            
        case LoginStatues_fail:
        {
            codeMsg = @"登录失败。";
            
            break;
        }
            
        case LoginStatues_noAccount:
        {
            codeMsg = @"该用户不存在。";
            
            break;
        }
            
        case LoginStatues_passwordWrong:
        {
            codeMsg = @"密码输入错误。";
            
            break;
        }
            
        default:
            break;
    }
    
    if (codeMsg != nil)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:codeMsg
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        
        return;
    }
    
    if (userinfo.bindCode == BindStatues_bindOther) //提示绑定信息
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"用户在其他设备已被绑定，在本设备上不允许使用。"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        
        return;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *newAppVersion = [userDefaults objectForKey:kLastVersion];
    
    //判断更新
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    newAppVersion = [newAppVersion stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int curVersion = [[currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
    
    int newVersion = [[newAppVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
    
    if (newVersion <= curVersion)//服务器新版本号小于等于当前版本号，则不更新
    {
        //页面跳转
        [self loginSuccess];
    }
    else
    {
        if (userinfo.updateType == UpdateType_Force)//强制更新
        {
            [_loginView showUpdataViewWithType:UpdateType_Force];
            
        }
        else if (userinfo.updateType == UpdateType_Normal)//普通更新
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            BOOL isShow = [userDefaults boolForKey:SHOWUPDATAKEY];
            
            if (isShow == NO)//之前没提示，则要提示
            {
                [_loginView showUpdataViewWithType:userinfo.updateType];
            }
            else //如果已经提示过，那么不再提示，直接跳转页面
            {
                //页面跳转
                [self loginSuccess];
            }
        }
        else if (userinfo.updateType == UpdateType_NoUpdate)
        {
            //页面跳转
            [self loginSuccess];
        }
    }
}

- (void)noUpdateAction
{
    //页面跳转
    [self loginSuccess];
}

- (void)loginSuccess {
    
    if ([_delegate respondsToSelector:@selector(LoginComponentSuccess)]) {
        
        [_delegate LoginComponentSuccess];
    }
}

/*********************************************************************
 Function description:用户名，密码校验
 Parameter: name，passport
 Return value: int
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(int)checkUserName:(NSString *)name passport:(NSString *) passport
{
    
    //用户名，密码格式检查
    checkUserType type;
    if (name == nil || [name isEqualToString:@""])
    {
        type = USERNAMENULL;
        return type;
    }
    else if(passport ==  nil || [passport isEqualToString:@""])
    {
        type = PASSWORDNULL;
        return type;
    }
    else
    {
      type = READYLOGIN;
      return type;
    }
  
}

- (void)cancelUpdate {
    
    _waitUntilCancelUpdate = YES;
}

#pragma mark textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //将各组建和控件对应
    
    if (textField == _loginView.usernameTextField) {//如果是用户名输入框点击回车,则跳转到密码输入框
        
        [_loginView.usernameTextField resignFirstResponder];
        [_loginView.passwordTextField becomeFirstResponder];
    }
    else {//如果是密码输入框点击回车,则进行登陆操作
        
        [_loginView.usernameTextField resignFirstResponder];
        [_loginView.passwordTextField resignFirstResponder];
        
        [self loginStart];
    }
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _loginView. usernameTextField)
    {
        if (_loginView.usernameTextField.text.length == 1 && string.length == 0)
        {
            
            [_loginView.headerButton setBackgroundImage:[UIImage imageWithContentsOfFile:@"login_defaultHeader.png" imageBundle:loginBundle] forState:UIControlStateNormal] ;
            [_loginView.headerButton setBackgroundImage:[UIImage imageWithContentsOfFile:@"login_defaultHeader.png" imageBundle:loginBundle] forState:UIControlStateHighlighted]  ;
        }
        else
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            NSString *keyStr = [NSString stringWithFormat:@"%@",textField.text];
             NSString *newStr =  [keyStr stringByReplacingCharactersInRange:range
                                            withString:string];
            
            if ([userDefaults objectForKey:newStr])
            {
                NSString * str =[userDefaults objectForKey:newStr];
                
                UIImage *image = [UIImage imageWithContentsOfFile:str];
                
                if (image)
                {
                    [_loginView.headerButton setBackgroundImage:image forState:UIControlStateNormal];
                    [_loginView.headerButton setBackgroundImage:image forState:UIControlStateHighlighted];
                }

                
            }
        
        
        }
    }
    return YES;
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


#pragma mark alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex)//确定按钮
    {
        Userinfo *userinfo = [Userinfo shareUserinfo];
        
        if (userinfo.uid) {
            
            //和本地用户名，密码比较
            NSString *username = userinfo.name;
            NSString *passWord = userinfo.password;
            
            if (isValid(username) && isValid(passWord) && [username isEqualToString:_loginView.usernameTextField.text] && [passWord isEqualToString:_loginView.passwordTextField.text] )
            {
                //页面跳转
                [self loginSuccess];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录错误"
                                                                    message:@"用户名或密码错误，请重新输入！"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                
                [alertView show];
                [alertView release];
            }
        }
        else {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录错误"
                                                                message:@"用户不存在，请重新输入！"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            
            [alertView show];
            [alertView release];
        }
    }
}

@end
