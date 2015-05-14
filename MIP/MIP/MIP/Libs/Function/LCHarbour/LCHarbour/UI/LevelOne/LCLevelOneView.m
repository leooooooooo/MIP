//
//  LCLevelOneView.m
//  LCHarbour
//
//  Created by kangqijun on 14-3-25.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "LCLevelOneView.h"

@implementation LCLevelOneView

@synthesize backBtn = m_backBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 54)];

        navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
        [self addSubview:navBarImg];
        [navBarImg release];
        
        //返回按钮

//        m_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [m_backBtn setBackgroundImage:[UIImage imageNamed:@"t_back.png" imageBundle:mainBundle] forState:UIControlStateNormal];
//        m_backBtn.frame = CGRectMake(10, 7, 55, 35);
//        [self addSubview:m_backBtn];

        

        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];

        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.font = [UIFont boldSystemFontOfSize:20];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.text = @"低碳港口";
        [self addSubview:titleLable];
        [titleLable release];
        
        m_contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height - 50)];
        m_contentView.backgroundColor = [UIColor clearColor];

        [self addSubview:m_contentView];
    }
    return self;
}

- (void) setContentView:(UIView *)contentView
{
    [m_contentView addSubview:contentView];
}

- (void)dealloc
{
    [m_contentView release];
    [super dealloc];
}

@end
