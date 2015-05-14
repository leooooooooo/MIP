//
//  LowCPortContentViewController.h
//  LCHarbour
//
//  Created by lu_sicong on 2014/04/25.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LowCPortContentViewController : BaseViewController<UIWebViewDelegate>
{
    UIWebView *contentWebView;
    UILabel *titleLabel;
    UILabel *authorLabel;
    UIButton *backBtn;
}

@property(nonatomic, retain)UIButton *backBtn;
@property(nonatomic, retain)UIWebView *contentWebView;
@property(nonatomic, retain)UILabel *titleLabel;
@property(nonatomic, retain)UILabel *authorLabel;

@end