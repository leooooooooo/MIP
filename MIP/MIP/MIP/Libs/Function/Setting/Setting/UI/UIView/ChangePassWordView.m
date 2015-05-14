//
//  ChangePassWordView.m
//  Setting
//
//  Created by kangqijun on 13-11-7.
//  Copyright (c) 2013年 kangqijun. All rights reserved.
//

#import "ChangePassWordView.h"
#import "InsetTextField.h"

#define PopFrameTopShadow       7
#define PopFrameBottomShadow    17

@implementation ChangePassWordView



@synthesize sureButton;
@synthesize newsWordTextField;
@synthesize reNewWordTextField;
@synthesize oldWordTextField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //全屏背景按钮
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.backgroundColor = [UIColor blackColor];
        bgButton.alpha = 0.6;
//        [bgButton addTarget:self action:@selector(closeChangePassWordView) forControlEvents:UIControlEventTouchDown];
        [bgButton setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:bgButton];
        
        //内容视图
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 96.5, 320, 245 + PopFrameTopShadow + PopFrameBottomShadow)];
        contentView.backgroundColor = [UIColor clearColor];
        
        UIImageView *contentBgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"pot_box.png" imageBundle:settingBundle] resizableImageWithCapInsets:UIEdgeInsetsMake(50, 0, 30, 0) resizingMode:UIImageResizingModeStretch]];
        contentBgView.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
        [contentView addSubview:contentBgView];
        [contentBgView release];
        
        UIView *whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, contentView.frame.size.width - 40, 230)];
        whiteBgView.backgroundColor = [UIColor clearColor];
        [contentView addSubview:whiteBgView];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, PopFrameTopShadow, contentView.frame.size.width, 40)];
        titleLab.text = @"修改密码";
        titleLab.textAlignment = UITextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont boldSystemFontOfSize:22];
        titleLab.backgroundColor = [UIColor clearColor];
        [contentView addSubview:titleLab];
        [titleLab release];
        
        UILabel *oldWordLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 35)];
        oldWordLab.text = @"旧密码";
        oldWordLab.textColor = [UIColor grayColor];
        oldWordLab.font = [UIFont boldSystemFontOfSize:14];
        oldWordLab.backgroundColor = [UIColor clearColor];
        oldWordLab.textAlignment = NSTextAlignmentRight;
        [whiteBgView addSubview:oldWordLab];
        [oldWordLab release];
        
        oldWordTextField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, -0.5, 206.5, 36.5)];
        oldWordTextField.font = [UIFont systemFontOfSize:16];
        oldWordTextField.backgroundColor = [UIColor whiteColor];
        oldWordTextField.placeholder = @"旧密码";
        oldWordTextField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        oldWordTextField.secureTextEntry = YES;
        oldWordTextField.inset = CGPointMake(8, 0);
        [whiteBgView addSubview:oldWordTextField];
        
        UILabel *newWordLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 65, 35)];
        newWordLab.text = @"新密码";
        newWordLab.textColor = [UIColor grayColor];
        newWordLab.font = [UIFont boldSystemFontOfSize:14];
        newWordLab.backgroundColor = [UIColor clearColor];
        newWordLab.textAlignment = NSTextAlignmentRight;
        [whiteBgView addSubview:newWordLab];
        [newWordLab release];
        
        newsWordTextField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, 39.5, 206.5, 36.5)];
        newsWordTextField.font = [UIFont systemFontOfSize:16];
        newsWordTextField.backgroundColor = [UIColor whiteColor];
        newsWordTextField.placeholder = @"新密码（6-15个字符）";
        newsWordTextField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        newsWordTextField.secureTextEntry = YES;
        newsWordTextField.inset = CGPointMake(8, 0);
        [whiteBgView addSubview:newsWordTextField];
        
        UILabel *reNewWordLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 65, 35)];
        reNewWordLab.text = @"重复新密码";
        reNewWordLab.textColor = [UIColor grayColor];
        reNewWordLab.font = [UIFont boldSystemFontOfSize:13];
        reNewWordLab.backgroundColor = [UIColor clearColor];
        reNewWordLab.textAlignment = NSTextAlignmentRight;
        [whiteBgView addSubview:reNewWordLab];
        [reNewWordLab release];
        
        reNewWordTextField = [[InsetTextField alloc] initWithFrame:CGRectMake(70, 79.5, 206.5, 36.5)];
        reNewWordTextField.font = [UIFont systemFontOfSize:16];
        reNewWordTextField.backgroundColor = [UIColor whiteColor];
        reNewWordTextField.placeholder = @"新密码（6-15个字符）";
        reNewWordTextField.background = [UIImage imageNamed:@"input_box_1.png" imageBundle:settingBundle];
        reNewWordTextField.secureTextEntry = YES;
        reNewWordTextField.inset = CGPointMake(8, 0);
        [whiteBgView addSubview:reNewWordTextField];
        
        UIButton *noButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [noButton setTitle:@"放弃修改" forState:UIControlStateNormal];
        [noButton addTarget:self action:@selector(closeChangePassWordView) forControlEvents:UIControlEventTouchUpInside];
        [noButton setFrame:CGRectMake(5, 140, 130, 35)];
        [noButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [noButton setBackgroundImage:[UIImage imageNamed:@"button_q.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        noButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [whiteBgView addSubview:noButton];
        
        sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [sureButton setFrame:CGRectMake(145, 140, 130, 35)];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [whiteBgView addSubview:sureButton];
        
        [whiteBgView release];
        
        [self addSubview:contentView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

//点击背景关闭视图
- (void)closeChangePassWordView
{
    [oldWordTextField resignFirstResponder];
    [newsWordTextField resignFirstResponder];
    [reNewWordTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = contentView.frame;
        rect.origin.y = self.frame.size.height;
        contentView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}

//键盘显示
- (void)keyboardWillShow
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = contentView.frame;
        rect.origin.y = 20;
        contentView.frame = rect;
    }];
}

//键盘隐藏
- (void)keyboardWillHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = contentView.frame;
        rect.origin.y = 96.5;
        contentView.frame = rect;
    }];
}

- (void)dealloc
{
    [oldWordTextField release];
    [newsWordTextField release];
    [reNewWordTextField release];
    
    [contentView release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super dealloc];
}

@end
