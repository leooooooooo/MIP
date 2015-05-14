//
//  ProcessBaseView.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ProcessBaseView.h"

#define FrameWidth              (SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH)
#define FrameHeight             (SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_WIDTH : SCREEN_HEIGHT)

#define TitleBgHeight           44
#define NavBarHeight            20

#define LeftShadowWidth         15
#define LeftBorderWidth         13
#define ContentFrameWidth       FrameWidth
#define ContentFrameHeight      FrameHeight - TitleBgHeight + 3
#define SideBorderWidth         10

#define BackGroundColor         [UIColor whiteColor]

#define WhiteBgViewFrame        CGRectMake(0, TitleBgHeight - 3 + 20, ContentFrameWidth, ContentFrameHeight)

#define TitleBgImage            [UIImage imageNamed:@"titleBar_bg.png" imageBundle:businessProcessBundle]
#define TitleBgViewFrame        CGRectMake(0, NavBarHeight, ContentFrameWidth, TitleBgHeight)
#define TitleViewFrame          CGRectMake(0, NavBarHeight, ContentFrameWidth, TitleBgHeight)
#define TitleLabelViewFrame     CGRectMake(0, 0, ContentFrameWidth, TitleBgHeight - 3)

#define ContentViewFrame        CGRectMake(0, 0, ContentFrameWidth, ContentFrameHeight)

#define BackButtonImage         [UIImage imageNamed:@"t_back.png" imageBundle:mainBundle]
#define BackButtonFrame         CGRectMake(10, NavBarHeight+5, 40, 30)

@implementation ProcessBaseView

@synthesize delegate = m_delegate;

@synthesize contentView = m_contentView;

@dynamic title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat originY = 0;
        
        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
            originY = 20.0;
        }
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectZero];
        whiteView.frame = WhiteBgViewFrame;
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        
        UIImageView *titleBgView = [[UIImageView alloc] initWithImage:[TitleBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:(UIImageResizingModeStretch)]];
        titleBgView.frame = TitleBgViewFrame;
        [self addSubview:titleBgView];
        [titleBgView release];
        
        UIView *titleView = [[UIView alloc] initWithFrame:TitleViewFrame];
        [self addSubview:titleView];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = BackButtonFrame;
        [backButton setBackgroundImage:BackButtonImage forState:UIControlStateNormal];
        [backButton addTarget:self
                       action:@selector(closeProcessView)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        
        m_titleLabel = [[UILabel alloc] initWithFrame:TitleLabelViewFrame];
        m_titleLabel.textColor = [UIColor whiteColor];
        m_titleLabel.font = [UIFont boldSystemFontOfSize:24];
        m_titleLabel.backgroundColor = [UIColor clearColor];
        m_titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [titleView addSubview:m_titleLabel];
        
        [titleView release];
        
        m_contentView = [[UIView alloc] initWithFrame:CGRectZero];
        m_contentView.frame = ContentViewFrame;
        m_contentView.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:m_contentView];
        
        [whiteView release];

    }
    return self;
}

- (void)dealloc
{
    [m_titleLabel release];
    [m_contentView release];
    [super dealloc];
}

- (void)closeProcessView
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(closeBtnClick)]) {
        [m_delegate closeBtnClick];
    }
}

- (void)setTitle:(NSString *)title
{
    m_titleLabel.text = title;
}

- (NSString *)title
{
    return m_titleLabel.text;
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
