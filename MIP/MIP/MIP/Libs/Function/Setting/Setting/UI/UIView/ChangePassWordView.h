//
//  ChangePassWordView.h
//  Setting
//
//  Created by kangqijun on 13-11-7.
//  Copyright (c) 2013年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@class InsetTextField;

@interface ChangePassWordView : BaseView 
{
    UIView         *contentView;         //内容视图
    
    InsetTextField    *oldWordTextField;    //旧密码输入框
    InsetTextField    *newsWordTextField;   //新密码输入框
    InsetTextField    *reNewWordTextField;  //重复新密码输入框
    
    UIButton       *sureButton;          //确认修改按钮
}

@property (retain, nonatomic) UIButton       *sureButton;
@property (retain, nonatomic) UITextField    *newsWordTextField;
@property (retain, nonatomic) UITextField    *reNewWordTextField;
@property (retain, nonatomic) UITextField    *oldWordTextField;

//点击背景关闭视图
- (void)closeChangePassWordView;

@end
