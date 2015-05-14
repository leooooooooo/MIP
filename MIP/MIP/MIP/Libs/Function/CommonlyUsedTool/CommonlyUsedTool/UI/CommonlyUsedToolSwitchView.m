//
//  CommonlyUsedToolSwitchView.m
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "CommonlyUsedToolSwitchView.h"

#define WEBSITEBUTTON_TAG       1
#define NOTEBUTTON_TAG          2
#define CALENDERBUTTON_TAG      3
@implementation CommonlyUsedToolSwitchView
@synthesize webSiteButton,noteButton,calenderButton;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_y_bg.png" imageBundle:commonlyUsedToolBundle]];
        
        backImageView.frame = CGRectMake(0, 0, 151, 140);
        
        [self addSubview:backImageView];
        [backImageView release];
        
        webSiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [webSiteButton setImage:[UIImage imageNamed:@"icon_w_1.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [webSiteButton setImage:[UIImage imageNamed:@"icon_w_1.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateHighlighted];
        webSiteButton.frame = CGRectMake(23, 92, 42, 37);
        webSiteButton.tag = WEBSITEBUTTON_TAG;
        [webSiteButton addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:webSiteButton];
        
        noteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [noteButton setImage:[UIImage imageNamed:@"icon_j_2.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        noteButton.tag = NOTEBUTTON_TAG;
        [noteButton addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [noteButton setImage:[UIImage imageNamed:@"icon_j_1.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateHighlighted];
        noteButton.frame = CGRectMake(52, 49, 41, 29);
        [self addSubview:noteButton];
        
        calenderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [calenderButton setImage:[UIImage imageNamed:@"icon_r_2.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [calenderButton setImage:[UIImage imageNamed:@"icon_r_1.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateHighlighted];
        calenderButton.tag = CALENDERBUTTON_TAG;
        [calenderButton addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        calenderButton.frame = CGRectMake(105, 19, 30, 31);
        [self addSubview:calenderButton];
        
    }
    return self;
}

- (void)functionButtonClick:(id)sender{
    if (sender == webSiteButton) {
        [webSiteButton setImage:[UIImage imageNamed:@"icon_w_1.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"icon_j_2.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [calenderButton setImage:[UIImage imageNamed:@"icon_r_2.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
    }else if(sender == noteButton){
        [webSiteButton setImage:[UIImage imageNamed:@"icon_w_2.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"icon_j_1.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [calenderButton setImage:[UIImage imageNamed:@"icon_r_2.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
    }else if(sender == calenderButton){
        [webSiteButton setImage:[UIImage imageNamed:@"icon_w_2.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"icon_j_2.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [calenderButton setImage:[UIImage imageNamed:@"icon_r_1.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
    }
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
