//
//  SuspendViewController.h
//  Sandglass
//
//  Created by Sea on 13-11-11.
//
//

#import <UIKit/UIKit.h>

@protocol SuspendControllerDelegate <NSObject>

@optional

- (void)dismissAction;

@end

@interface SuspendController : NSObject {
    
    UIWindow                    *_originalWindow;
    UIWindow                    *_suspendWindow;
    
    
    UIViewController            *_suspendViewController;
    
    UIViewController            *_contentViewController;
    
    BOOL                        _isAnimating;
    
    id<SuspendControllerDelegate> suspendDelegate;
}

@property (assign, nonatomic) id<SuspendControllerDelegate> suspendDelegate;

- (id)initWithContentViewController:(UIViewController *)viewController;

- (void)show;

- (void)dismiss;

@end


@interface SuspendViewController : UIViewController

@end

@interface SuspendView : UIView

@end

@interface UIViewController (SuspendController)
//只读属性
@property (nonatomic,assign)   SuspendController *suspendController;

@end