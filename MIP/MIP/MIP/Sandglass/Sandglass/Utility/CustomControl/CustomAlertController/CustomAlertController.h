//
//  CustomAlertView.h
//  CustomAlertView
//
//  Created by sea on 13-12-8.
//  Copyright (c) 2013年 sea. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum {
    
    CustomAlertAnimateStyleDefault = 0 ,
    CustomAlertAnimateStyle1
    
}CustomAlertAnimateStyle;

@interface CustomAlertController : NSObject {
    
    UIWindow                                    *_originalWindow;
    Class                                       _originalWindowClass;
    
    
    UIWindow                                    *_containerWindow;
    
    UIViewController                            *_containerViewController;
}



/*!
 @function
 @abstract      设置yes后,触碰非contentView区域自动隐藏

 @result
 */
@property (nonatomic, assign) BOOL  touchDownOutsideContentWillDismiss;//default NO ;



/*!
 @function
 @abstract      设置yes后,按钮自动设置touchUpInside后,提示框视图消失的事件
 
 @note          只有放置在contentView或者contentViewController.view上的button有效果
 @note          该属性在show方法调用前设置,否则设置无效
 
 @result
 */
@property (nonatomic, assign) BOOL  touchUpInsideFromButtonWillDismiss;//default YES ;



/*!
 @function
 @abstract      设置非contentView区域的选染色
 @result
 */
@property (nonatomic, retain) UIColor *color;



/*!
 @function
 @abstract      设置非contentView区域的渲染图片
 
 @result
 */
@property (nonatomic, retain) UIImage *image;



/*!
 @function
 @abstract      设置提示框的动画风格
 
 @result
 */
@property (nonatomic, assign) CustomAlertAnimateStyle   animateStyle;



@property (nonatomic, retain) UIViewController *contentViewController;



/*!
 @function
 @abstract      设置提示框的动画风格
 
 @result
 */

- (id)initWithContentView:(UIView *)contentView;



/*!
 @function
 @abstract      设置提示框的动画风格
 
 @result
 */
- (id)initWithContentViewController:(UIViewController *)contentViewController;


/*!
 @function
 @abstract      展示提示框
 
 @result
 */

- (void)show;



/*!
 @function
 @abstract      隐藏提示框
 
 @result
 */
- (void)hide;

@end


@interface UIViewController (AlertContentViewController)

//注:该属性为只读
@property (nonatomic,assign)   CustomAlertController *alertController;

@end



@interface UIView (AlertContentView)

//注:该属性为只读
@property (nonatomic,assign)   CustomAlertController *alertController;
@end