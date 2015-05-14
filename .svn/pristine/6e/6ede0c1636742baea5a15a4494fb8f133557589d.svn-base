/********************************************************************
 Author: li_xiangai
 Class description:LoginView
 *******************************************************/
#import "BaseView.h"

#import "CustomAlertView.h"
#import "SimpleSwitch.h"
#import "CustomNewAlertView.h"

@protocol LoginViewDelegate <NSObject>

- (void)noUpdateAction;

@end

@interface LoginView : BaseView 
{

    UIImageView         *_backImage;                         //背景图
    UIImageView         *_logoImage;                        //logo
    
    UISwitch            *usernameSwitch;                    //用户选择记住用户名的控件
    UITextField         *usernameTextField;                 //用户名输入控件
    UITextField         *passwordTextField;                 //密码输入控件
    
    UILabel             *versionLabel;                      //版本
    UILabel             *newsVersionLab;                     //最新版本
    
    UIButton            *loginButton;                       //登陆按钮控件
    UIButton            *helpButton;                        //帮助按钮控件
    UIButton            *headerButton;                      //头像按钮控件
    UIButton            *checkVersionButton;                //更新版本按钮控件
    UIButton            *codeButton;                        //找回密码按钮控件
    
    UIView              *updateView;                        //更新视图
    
    SimpleSwitch        *rememberSwitch;                    //记住用户名按钮控件
    SimpleSwitch        *autoSwitch;                        //自动登录按钮控件
    
    BOOL                isButtonShow;                       //点击更新版本按钮控件弹出提示标示
    
    id<LoginViewDelegate> m_delegate;
    
    UIButton            *rememberBtn;                       //记住密码
    UIButton            *autoLoginBtn;                      //自动登录
    UIView              *upgradeAlert;
}

@property (nonatomic, retain) UITextField *usernameTextField;
@property (nonatomic, retain) UITextField *passwordTextField;

@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIButton *helpButton;
@property (nonatomic, retain) UILabel  *versionLabel;
@property (nonatomic, retain) UILabel  *newsVersionLab;
@property (nonatomic, retain) UIButton *checkVersionButton;
@property (nonatomic, retain) UIButton *headerButton;
@property (nonatomic, retain) UIButton *noUpdateButton;

@property( nonatomic, retain) UISwitch *usernameSwitch;

@property( nonatomic, retain) SimpleSwitch        *rememberSwitch;
@property( nonatomic, retain) SimpleSwitch        *autoSwitch;

 @property( nonatomic, assign) id<LoginViewDelegate> m_delegate;

@property( nonatomic, retain) UIButton            *rememberBtn;
@property( nonatomic, retain) UIButton            *autoLoginBtn;


//显示版本更新提示
- (void)showUpdataViewWithType:(UpdateType)_type;

- (void)changeLoginImageView:(int)imageNum;

@end

