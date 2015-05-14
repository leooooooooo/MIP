/********************************************************************
 Author: li_xiangai
 Class description:DisplayComponent
 *******************************************************/
#import "BaseComponent.h"

@class LoginView;
@class LoginViewController;

@interface DisplayComponent : BaseComponent {
    
    LoginView                           *_loginView;
    LoginViewController                 *_loginViewController;
}




@end
