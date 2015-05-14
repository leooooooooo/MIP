//
//  NewsflashLevelTwoView.m
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "NewsflashLevelTwoView.h"

@implementation NewsflashLevelTwoView
@synthesize backBtn;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 54)];
        navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
        [self addSubview:navBarImg];
        [navBarImg release];
        
        //返回按钮
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"t_back.png" imageBundle:mainBundle] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(10, 27, 55, 35);
        [self addSubview:backBtn];
        
        titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, 50)];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.font = [UIFont boldSystemFontOfSize:20];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLable];
        [titleLable release];
    }
    return self;
}

- (void)setTitleLabelText:(NSString *)text
{
    titleLable.text = text;
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
