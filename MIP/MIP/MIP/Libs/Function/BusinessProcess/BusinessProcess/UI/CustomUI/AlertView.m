//
//  AlertView.m
//  GACloud
//
//  Created by lixiangai on 14-4-14.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "AlertView.h"

#define ScreenWidth             [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight            [[UIScreen mainScreen] bounds].size.height

#define BgFrameWidth            ((ScreenWidth > ScreenHeight)? ScreenWidth : ScreenHeight)
#define BgFrameHeight           ((ScreenWidth > ScreenHeight)? ScreenHeight : ScreenWidth) - 20

#define PopFrameTopShadow       7
#define PopFrameBottomShadow    17

#define BaseOriginY             (35.0)

@implementation AlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //全屏背景按钮
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.backgroundColor = [UIColor blackColor];
        bgButton.alpha = 0.6;
        [bgButton setFrame:CGRectMake(0, 20, BgFrameWidth, BgFrameHeight)];
//        [bgButton addTarget:self action:@selector(keyboardWillHidden) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake((BgFrameWidth - 320) / 2, 35, 320, 250 + PopFrameTopShadow + PopFrameBottomShadow)];
        [self addSubview:contentView];
        
        bgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"pot_box.png" imageBundle:settingBundle] resizableImageWithCapInsets:UIEdgeInsetsMake(50, 0, 30, 0) resizingMode:UIImageResizingModeStretch]];
        bgView.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
        [contentView addSubview:bgView];
        [bgView release];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, PopFrameTopShadow, contentView.frame.size.width, 40)];
        titleLab.text = @"提示";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont boldSystemFontOfSize:22];
        titleLab.backgroundColor = [UIColor clearColor];
        [contentView addSubview:titleLab];
        
        whiteView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 55, contentView.frame.size.width - 35, contentView.frame.size.height - 82)];
        whiteView.backgroundColor = [UIColor clearColor];
        whiteView.contentSize = CGSizeMake(contentView.frame.size.width - 35, 420);
        [contentView addSubview:whiteView];
        
        messageLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, whiteView.frame.size.width, 140)];
        messageLab.font = [UIFont systemFontOfSize:20];
        messageLab.textColor = [UIColor blackColor];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.backgroundColor = [UIColor clearColor];
        messageLab.numberOfLines = 0;
        [whiteView addSubview:messageLab];
        
        sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [sureButton setFrame:CGRectMake(75, 150, 130, 35)];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [sureButton addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:sureButton];
        
        [whiteView release];
        
        [contentView release];
   }
    return self;
}

- (id) initWithTitle:(NSString *)title andMessage : (NSString *)message
{
    self = [self initWithFrame:CGRectMake(0, 0, BgFrameWidth, BgFrameHeight)];
    
    if (self) {
        if (message == nil) {
            titleLab.text = @"提示";
            messageLab.text = title;
        }
        else if (title == nil)
        {
            titleLab.text = @"提示";
            messageLab.text = message;
        }
        else {
            titleLab.text = title;
            messageLab.text = message;
        }
        
        CGSize labSize = [messageLab.text sizeWithFont:messageLab.font constrainedToSize:messageLab.frame.size lineBreakMode:messageLab.lineBreakMode];
        CGFloat originHeight = messageLab.frame.size.height - labSize.height;
        
        CGRect tmpFrame = contentView.frame;
        tmpFrame.size.height -= originHeight;
        tmpFrame.origin.y += (originHeight / 2);
        contentView.frame = tmpFrame;
        
        tmpFrame = bgView.frame;
        tmpFrame.size.height -= originHeight;
        bgView.frame = tmpFrame;
        
        tmpFrame = messageLab.frame;
        tmpFrame.size.height -= originHeight;
        messageLab.frame = tmpFrame;
        
        tmpFrame = sureButton.frame;
        tmpFrame.origin.y -= originHeight;
        sureButton.frame = tmpFrame;
    }
    
    return self;
}

- (void)dealloc
{
    [titleLab release];
    [messageLab release];
    
    [super dealloc];
}

- (void) addToView : (UIView *)view
{
    [view.superview.window.rootViewController.view addSubview:self];
}

- (void) cancelBtnClick
{
    [self removeFromSuperview];
}

@end
