//
//  CustomAlertView.h
//  Sandglass
//
//  Created by Sea on 13-9-30.
//


/*!
 @function
 @abstract      自定义alertView,支持设置背景图片,支持自定义UIButton
 
 @note          UIAlertView自带的delegate部分依旧可以正常使用,由于现在使用UIButton自身的事件响应系统,不再使用系统通过index的按钮排布方式
                因此下面三个代理函数无法正常使用
                - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
                - (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
                - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
                其他代理均可以正常使用
 
@result
*/

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIAlertView {
    
    NSMutableArray *_buttonArrays;
}

- (id)initWithBackgroundView:(UIView *)backgroundView;

//TODO: alertView的背景图
@property(nonatomic, retain,readonly) UIView *backgroundView;

/*!
 @function
 @abstract      向alertView添加按钮
 
 @note          按钮的布局相对于contentImageView
 @note          按钮的事件执行完毕后,alertView才会消失;如果需要异步处理,请将定义的事件使用多线程或者任务队列
 
 @result
 */
-(void) addButton:(UIButton *)btn;

@end


