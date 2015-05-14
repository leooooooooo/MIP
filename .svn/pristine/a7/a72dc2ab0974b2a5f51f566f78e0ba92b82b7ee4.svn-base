/********************************************************************
 Author: li_xiangai
 Class description:LoginViewController
 *******************************************************/
#import "BaseViewController.h"

#import "LoginComponent.h"

#import "SMSWidgetView.h"

typedef enum
{
  USERNAMENULL,
  PASSWORDNULL,
  READYLOGIN,

}checkUserType;


@protocol LoginDelegate <NSObject>

@optional

- (void)loginSuccess;

@end


@class LoginView;
@class LoginComponent;
@class DisplayComponent;

@interface LoginViewController : UIViewController <LoginComponentDelegate,SMSWidgetViewDelegate>
{
    @public
    LoginView                   *_loginView;                    //登录视图
    
    @protected
    
    id  <LoginDelegate>         _delegate;
    
    @private
    LoginComponent              *_loginComponent;               //登录组件
    DisplayComponent            *_displayComponent;             //帮助组件
    
    SMSWidgetView               *m_smsView;
    
    NSTimer                     *timer;
}

@property (nonatomic, assign) id <LoginDelegate> delegate;

- (void) showLaunchImage:(UIImage *)image;

@end

