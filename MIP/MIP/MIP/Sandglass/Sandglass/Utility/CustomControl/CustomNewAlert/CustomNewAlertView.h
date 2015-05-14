//
//  CustomNewAlertView.h
//  NewAlertView
//
//  Created by wang_hao on 14-1-16.
//  Copyright (c) 2014年 wang_hao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AlertDelegate <NSObject>

- (void)clickedButtonAtIndex:(NSInteger)buttonIndex;



@end


@interface CustomNewAlertView : UIView
{
    UILabel *msgtitle;
    UILabel *messageContent;
    UIButton *btn1;
    UIButton *btn2;
    NSMutableArray *_buttons;
    UIImageView *alertImageView;
    UIView *backView;
    id<AlertDelegate> alertdelegate;
    CGRect theFrame;



}
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<AlertDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
-(void)show;
-(void)show:(UIView*)view;
-(void)dismissAlertView;
-(void)addButton:(UIButton *)btn;
-(void)addTheview:(UIView *)view;
-(void)setBackgroundIamge:(UIImage*)image;
-(void)setTitleColor:(UIColor *)color font:(UIFont *)titleFont;
-(void)setMessageColor:(UIColor *)color font:(UIFont *)messageFont;
-(void)setAlertWidth:(float)width;
-(void)setAlertHeight:(float)height;
@end
