/********************************************************************
 Author: li_xiangai
 Class description:LoginComponent
 *******************************************************/

#import "BaseComponent.h"
#import "LoginView.h"

@protocol LoginComponentDelegate <NSObject>

@optional

- (void)LoginComponentSuccess;

@end

@class LoginView;
@class LoginViewController;

@class MBProgressHUD;

@interface LoginComponent : BaseComponent <UITextFieldDelegate,UIAlertViewDelegate,LoginViewDelegate>
{

    LoginViewController                 *_loginViewController;
    LoginView                           *_loginView;
    
    id  <LoginComponentDelegate>         _delegate;
    
    MBProgressHUD                       *_HUD;
    
    BOOL                                 _waitUntilCancelUpdate;
    
}

@property (nonatomic, assign) id <LoginComponentDelegate> delegate;

- (void)loginStart;

- (void)checkLaunchImage;

@end
