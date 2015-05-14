//
//  CommonlyUsedToolView.m
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "CommonlyUsedToolView.h"

@implementation CommonlyUsedToolView
@synthesize closeBtn,titleLab;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"frame_text_commonlyUsedTool.png" imageBundle:commonlyUsedToolBundle]];
        titleView.frame = CGRectMake(15, 20, 35, 180);
        [self addSubview:titleView];
        [titleView release];
        
        self.backgroundImage = [UIImage imageWithContentsOfFile:@"di.png" imageBundle:commonlyUsedToolBundle];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(386, 5, 200, 50)];
        titleLab.text = @"常用网站";
        titleLab.textColor = [UIColor colorWithHex:@"487eb0"];
        titleLab.font = [UIFont boldSystemFontOfSize:24];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textAlignment = UITextAlignmentCenter;
        [self addSubview:titleLab];
        [titleLab release];
        
        lineView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_line_vertical1.png" imageBundle:publicResourceBundle]];
        
        lineView1.frame = CGRectMake(20, 0, 14, 21);
        
        [self addSubview:lineView1];
        
        [lineView1 release];
        
        
        lineView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_line_vertical2.png" imageBundle:publicResourceBundle]];
        
        lineView2.frame = CGRectMake(20, frame.size.height - 540, 14, 540);
        
        [self addSubview:lineView2];
        
        [lineView2 release];
        
        //关闭按钮
        UILabel *closeLab = [[UILabel alloc] initWithFrame:CGRectMake(850, 5, 50, 50)];
        closeLab.text = @"关闭";
        closeLab.textColor = [UIColor colorWithHex:@"487eb0"];
        closeLab.font = [UIFont boldSystemFontOfSize:20];
        closeLab.backgroundColor = [UIColor clearColor];
        [self addSubview:closeLab];
        [closeLab release];
        
        UIImageView *closeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(800, 5, 50, 50)];
        closeImageView.image = [UIImage imageNamed:@"button_close.png" imageBundle:newsCenterBundle];
        closeImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:closeImageView];
        [closeImageView release];
        
        closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(800, 5, 100, 50);
        [self addSubview:closeBtn];
    }
    return self;
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
