//
//  SettingViewController.m
//  Setting
//
//  Created by kangqijun on 13-11-7.
//  Copyright (c) 2013年 kangqijun. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingNetRequest.h"
#import "NSDictionary+CustomExtensions.h"

@interface SettingViewController ()
{
    SettingView     *settingView;
}

@end

@implementation SettingViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    settingView = [[SettingView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    settingView.m_delegate = self;
    self.view = settingView;
    [settingView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [settingView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setPersonInfoHeaderImage:(UIImage *)image
{
    [settingView personHeaderImage:image];
}

#pragma mark - SettingViewDelegate
- (void)changePassword:(NSMutableArray *)_arr
{
    if (isValid([Userinfo shareUserinfo].token))
    {
        [SettingNetRequest executeAsynchronous:@selector(changePassword) callback:@selector(changePasswordCallback:error:) backTarget:self args:[_arr objectAtIndex:0],[_arr objectAtIndex:1],[Userinfo shareUserinfo].token,nil];
    }
    else
    {
        [settingView showOperateFinish:@"token为空"];
    }
    
}

//检车新版本
- (void)settingCheckNewVersion
{
    
}

//清除数据
- (void)settingCleanCacheFile
{
    
}

//放弃绑定
- (void)giveUpBlind
{
    //将开关恢复原状
    [settingView.setTableView reloadData];
}

//绑定用户
- (void)settingBlindAccountWith:(BOOL)_isBlind with:(SettingSwitch *)chooseSwitch;
{
    if (settingView.passwordTextField.text == nil || [settingView.passwordTextField.text isEqualToString:@""])
    {
        [settingView showOperateFinish:@"请输入登录密码做身份验证!"];
        
        chooseSwitch.on = !_isBlind;
    }
    else
    {
        if (isValid([Userinfo shareUserinfo].token))
        {
            [SettingNetRequest executeAsynchronous:@selector(setBlindDevice) callback:@selector(blindDeviceCallback:error:) backTarget:self args:[NSString stringWithFormat:@"%d",_isBlind],settingView.passwordTextField.text,[Userinfo shareUserinfo].token, nil];
        }
        else
        {
            [settingView showOperateFinish:@"token为空"];
        }
    }
}

//自动登录
- (void)settingAutoLoginWith:(BOOL)_isAuto
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:_isAuto forKey:AUTOLOGINKEY];
    [userDefaults synchronize];
}

//修改个人信息
-(void)setPersonInfoWithTelephone:(NSString *)tel email:(NSString *)mail;
{
    if (isValid([Userinfo shareUserinfo].token))
    {
        [SettingNetRequest executeAsynchronous:@selector(changePersonInfo) callback:@selector(callbackChangePersonInfo:error:) backTarget:self args:[Userinfo shareUserinfo].token,tel,mail,nil];
    }
    else
    {
        [settingView showOperateFinish:@"token为空"];
    }
}

//修改个人详细信息
-(void)setPersonDetailInfoWithTel:(NSString *)tel duty:(NSString *)duty bakTel:(NSString *)bakTel officeTel:(NSString *)officeTel bakOfficeTel:(NSString *)bakOfficeTel perEmail:(NSString *)perEmail
{
    if (isValid([Userinfo shareUserinfo].token))
    {
        [SettingNetRequest executeAsynchronous:@selector(changePersonDetailInfo) callback:@selector(callbackChangePersonInfo:error:) backTarget:self args:[Userinfo shareUserinfo].token,[Userinfo shareUserinfo].uid,duty,tel,bakTel,officeTel,bakOfficeTel,perEmail,nil];
    }
    else
    {
        [settingView showOperateFinish:@"token为空"];
    }
}

-(void)callbackChangePersonInfo:(NSData *)data error:(NSError*)error
{
    NSString *msg = nil;
    
    NSData *bodyData = [SettingNetRequest extractDataBodyFromResponsePackage:data];
    
    if (isValid(bodyData))
    {
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary) && !error)
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            
            if (0 == [ret intValue])
            {
                msg = @"个人信息修改成功";
                
                [settingView setPersonInfoSuccess];
            }
        }
    }
    
    if (msg == nil)
    {
        msg = @"个人信息修改失败";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}

#pragma mark - NetUniformInterfaceDelegate
-(void)changePasswordCallback:(NSData *)data error:(NSError*)error
{
    NSData *bodyData = [SettingNetRequest extractDataBodyFromResponsePackage:data];
    
    if (! isValid(bodyData))
    {
        return;
    }
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
    
    if (isValid(bodyDictionary) && !error)
    {
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        NSString *codeMsg = nil;
        
        switch ([ret intValue])
        {
            case 0://修改成功
            {
                [settingView removeChangePassWordView];
                
                break;
            }
                
            case 1:
            {
                codeMsg = @"修改密码失败。";
                
                break;
            }
                
            case 2:
            {
                codeMsg = @"该用户不存在。";
                
                break;
            }
                
            case 3:
            {
                codeMsg = @"旧密码输入错误。";
                
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
            
        }
        
//        操作标识，0: 操作成功;2: 用户不存在;3: 密码错误1：失败;6: 设备已绑定
    }
}

-(void)blindDeviceCallback:(NSData *)data error:(NSError*)error
{
    NSData *bodyData = [SettingNetRequest extractDataBodyFromResponsePackage:data];
    
    if (! isValid(bodyData))
    {
        return;
    }
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
    
//    DLog(@"%@",bodyDictionary);
    
    if (isValid(bodyDictionary) && !error)
    {
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        NSString *codeMsg = nil;
        
        switch ([ret intValue])
        {
            case 0://操作成功
            {
                NSDictionary *bizData = [bodyDictionary dataForKey:@"bizdata"];
                
                NSString *token = [bizData objectForKey:@"token"];
                
                switch ([Userinfo shareUserinfo].bindCode) {
                        
                    case BindStatues_noBind:
                        
                        [Userinfo shareUserinfo].bindCode = BindStatues_isBind;
                        
                        [Userinfo shareUserinfo].token = token;
                        
                        codeMsg = @"绑定成功。";
                        
                        break;
                        
                    case BindStatues_isBind:
                        
                        [Userinfo shareUserinfo].bindCode = BindStatues_noBind;
                        
                        [Userinfo shareUserinfo].token = token;
                        
                        codeMsg = @"解绑成功。";
                        
                        break;
                        
                    default:
                        break;
                }
                
                break;
            }
                
            case 1:
            {
                codeMsg = [bodyDictionary objectForKey:@"retMsg"];
                
                codeMsg = codeMsg ? codeMsg : @"操作失败。";
                
                break;
            }
                
            case 2:
            {
                codeMsg = @"该用户不存在。";
                
                break;
            }
                
            case 3:
            {
                codeMsg = @"登录密码输入错误。";
                
                break;
            }
            
            default:
                
                break;
        }
        
        if (codeMsg != nil)
        {
            [settingView showOperateFinish:codeMsg];
            
            //将开关恢复原状
            [settingView.setTableView reloadData];
        }
        
        //        操作标识，0: 操作成功;2: 用户不存在;3: 密码错误1：失败;6: 设备已绑定
        [settingView deviceBindComplete];
    }
}

-(void)settingHeadImage
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingHeadImage)])
    {
        [delegate settingHeadImage];
    }
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
}

-(void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
