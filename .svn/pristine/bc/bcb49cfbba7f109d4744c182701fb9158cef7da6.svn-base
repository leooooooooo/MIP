//
//  OperDeviceView.m
//  OperDevice
//
//  Created by wanghao on 14-3-25.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "OperDeviceView.h"

@implementation OperDeviceView

@synthesize backBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 54)];
        navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
        [self addSubview:navBarImg];
        [navBarImg release];
        
        //返回按钮
//        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backBtn setBackgroundImage:[UIImage imageNamed:@"t_back.png" imageBundle:mainBundle] forState:UIControlStateNormal];
//        backBtn.frame = CGRectMake(10, 7, 55, 35);
//        [self addSubview:backBtn];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.font = [UIFont boldSystemFontOfSize:20];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.text = @"设备运行";
        [self addSubview:titleLable];
        [titleLable release];
        
        m_contentView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height - 70)];
        m_contentView.backgroundColor = [UIColor clearColor];

        [self addSubview:m_contentView];
    }
    return self;
}

- (void) setContentView:(UIView *)contentView
{
    [m_contentView addSubview:contentView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [m_contentView release];
    [super dealloc];
}

@end
