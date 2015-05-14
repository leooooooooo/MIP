//
//  OfficialCheckView.h
//  OfficialCheck
//
//  Created by kangqijun on 14-3-31.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "BaseView.h"
#import "MBProgressHUD.h"

@interface OfficialCheckView : BaseView <UIWebViewDelegate>
{
    UIButton               *backBtn;     //返回按钮
    UIWebView              *contentWebView;
    UIWebView              *showAffixView;
    UIButton               *closeBtn;
    UILabel                *titleLable;
    
    BOOL                   showAffix;
    BOOL                   isEmail;
    
    MBProgressHUD   *_HUD;
}

@property (nonatomic, retain) UIButton               *backBtn;
@property (nonatomic, retain) UIWebView              *contentWebView;
@property (nonatomic, retain) UIWebView              *showAffixView;
@property (nonatomic, assign) BOOL                   showAffix;
@property (nonatomic, assign) BOOL                   isEmail;

- (void)addWebView;
- (void)removeWebView;

@end
