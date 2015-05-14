//
//  MyAppListView.m
//  Main
//
//  Created by mengxianglei on 14-4-15.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "MyAppListView.h"
#import "InsetTextField.h"

#define FrameWidth              frame.size.width
#define FrameHeight             frame.size.height
#define SideShadowWidth         5
#define LeftTitleWidth          40
#define LeftLineBaseX           9
#define BorderWidth             5
#define SearchBarHeight         50
#define LeftListWidth           240

#define BackGroundImage         [UIImage imageNamed:@"floor.png" imageBundle:myAppCenterBundle]
#define BackGroundFrame         CGRectMake(0, 0, FrameWidth, FrameHeight)

#define LeftTitleImage          [UIImage imageNamed:@"yyck.png" imageBundle:myAppCenterBundle]
#define LeftTitleFrame          CGRectMake(SideShadowWidth + 1, 30, 39, 167)

#define LeftTopLineImage        [UIImage imageNamed:@"bg_line_vertical1.png" imageBundle:myAppCenterBundle]
#define LeftTopLineFrame        CGRectMake(SideShadowWidth + LeftLineBaseX, 0, 14, 21)

#define LeftBottomLineImage     [UIImage imageNamed:@"bg_line_vertical2.png" imageBundle:myAppCenterBundle]
#define LeftBottomLineFrame     CGRectMake(SideShadowWidth + LeftLineBaseX, 208, 14, 540)

#define SearchBarViewImage      [UIImage imageNamed:@"sign_lm.png" imageBundle:myAppCenterBundle]
#define SearchBarViewFrame      CGRectMake(SideShadowWidth + LeftTitleWidth + 1, BorderWidth, FrameWidth - SideShadowWidth * 2 - LeftTitleWidth - BorderWidth - 1, 59)

#define AppTypeListViewImage    [UIImage imageNamed:@"warehouse_bg.png" imageBundle:myAppCenterBundle]
#define AppTypeListViewFrame    CGRectMake(SideShadowWidth + LeftTitleWidth + 1, SearchBarHeight + BorderWidth, LeftListWidth, 692)

#define AppListViewFrame        CGRectMake(SideShadowWidth + LeftTitleWidth + LeftListWidth + 1, SearchBarHeight + BorderWidth, 728, 692)

#define CloseButtonImage        [UIImage imageNamed:@"button_close_style1_1.png" imageBundle:myAppCenterBundle]
#define CloseButtonFrame        CGRectMake(FrameWidth - 10 - 9 - 100 - (SideShadowWidth + LeftTitleWidth + 1), 0, 100, 50)
#define CloseBtnTitleFrame      CGRectMake(50, 0, 50, 50)
#define CloseBtnTitleTextColor  [UIColor colorWithRed:145/255.0 green:167/255.0 blue:193/255.0 alpha:1.0]
#define CloseBtnTitleFont       [UIFont boldSystemFontOfSize:20]

#define SearchBarTextImage      [UIImage imageNamed:@"search_input_box.png" imageBundle:myAppCenterBundle]
#define SearchBarTextFrame      CGRectMake(207, 5, 431, 40)
#define SearchBarBtnImage       [UIImage imageNamed:@"search_button.png" imageBundle:myAppCenterBundle]
#define SearchBarBtnFrame       CGRectMake(637, 5, 90, 40)
#define SearchBarBtnTextColor   [UIColor colorWithRed:66/255.0 green:110/255.0 blue:146/255.0 alpha:1.0]
#define SearchBarTextFont       [UIFont boldSystemFontOfSize:21]


@interface MyAppListView()
{
    UIImageView *appTypeListView;               //应用分类列表视图
    
    UIView *appListView;                        //应用列表视图
}

@end

@implementation MyAppListView

@synthesize closeButton, m_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        //窗口背景设定
        UIImageView *bgView = [[UIImageView alloc] initWithImage:BackGroundImage];
        [bgView setFrame:BackGroundFrame];
        [self addSubview:bgView];
        [bgView release];
        
        UIImageView *titleView = [[UIImageView alloc] initWithImage:LeftTitleImage];
        [titleView setFrame:LeftTitleFrame];
        titleView.backgroundColor = [UIColor clearColor];
        [self addSubview:titleView];
        [titleView release];
        
        UIImageView *leftTopLineView = [[UIImageView alloc] initWithImage:LeftTopLineImage];
        [leftTopLineView setFrame:LeftTopLineFrame];
        leftTopLineView.backgroundColor = [UIColor clearColor];
        [self addSubview:leftTopLineView];
        [leftTopLineView release];
        
        UIImageView *leftBottomLineView = [[UIImageView alloc] initWithImage:LeftBottomLineImage];
        [leftBottomLineView setFrame:LeftBottomLineFrame];
        leftBottomLineView.backgroundColor = [UIColor clearColor];
        [self addSubview:leftBottomLineView];
        [leftBottomLineView release];
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithImage:SearchBarViewImage];
        [searchBarView setFrame:SearchBarViewFrame];
        searchBarView.backgroundColor = [UIColor clearColor];
        searchBarView.userInteractionEnabled = YES;
        [self addSubview:searchBarView];
        
        InsetTextField *searchBarText = [[InsetTextField alloc] initWithFrame:SearchBarTextFrame];
        searchBarText.background = [SearchBarTextImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        searchBarText.placeholder = @"请输入关键字搜索";
        searchBarText.font = SearchBarTextFont;
        searchBarText.inset = CGPointMake(23, 0);
        
        [searchBarView addSubview:searchBarText];
        [searchBarText release];
        
        UIButton *searchBarBtn = [[UIButton alloc] initWithFrame:SearchBarBtnFrame];
        [searchBarBtn setBackgroundImage:SearchBarBtnImage forState:UIControlStateNormal];
        [searchBarBtn setTitle:@"搜 索" forState:UIControlStateNormal];
        [searchBarBtn setTitleColor:SearchBarBtnTextColor forState:UIControlStateNormal];
        searchBarBtn.titleLabel.font = SearchBarTextFont;
        
        [searchBarBtn addTarget:self action:@selector(searchAppByKey)
               forControlEvents:UIControlEventTouchUpInside];
        
        [searchBarView addSubview:searchBarBtn];
        
        //TODO:searchBarBtn
        searchBarText.hidden = YES;
        searchBarBtn.hidden = YES;
        
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CloseButtonFrame;
        
        UIImageView *btnIcon = [[UIImageView alloc] initWithImage:CloseButtonImage];
        [closeButton addSubview:btnIcon];
        [btnIcon release];
        UILabel *btnTitle = [[UILabel alloc] initWithFrame:CloseBtnTitleFrame];
        btnTitle.text = @"关闭";
        btnTitle.textColor = CloseBtnTitleTextColor;
        btnTitle.font = CloseBtnTitleFont;
        btnTitle.backgroundColor = [UIColor clearColor];
        [closeButton addSubview:btnTitle];
        [btnTitle release];
        
        [closeButton addTarget:self action:@selector(closeMyAppCenterView) forControlEvents:UIControlEventTouchUpInside];
        [searchBarView addSubview:closeButton];
        
        appTypeListView = [[UIImageView alloc] initWithImage:AppTypeListViewImage];
        [appTypeListView setFrame:AppTypeListViewFrame];
        [self addSubview:appTypeListView];
        appTypeListView.userInteractionEnabled = YES;
        
        appListView = [[UIView alloc] initWithFrame:AppListViewFrame];
        [self addSubview:appListView];
        
        [self bringSubviewToFront:searchBarView];
        [searchBarView release];
        
        
    }
    return self;
}

//搜索按钮事件
- (void)searchAppByKey
{
    
}

//关闭按钮事件
- (void)closeMyAppCenterView
{
    [self removeFromSuperview];
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(closeAppCenter)])
    {
        [m_delegate closeAppCenter];
    }
}

- (void) setTypeListView : (UIView*) listView
{
    [appTypeListView addSubview:listView];
    
}

- (void) setAppListView : (UIView*) listView
{
    [appListView addSubview:listView];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

