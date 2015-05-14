//
//  NewsflashLevelOneView.m
//  Newsflash
//
//  Created by kangqijun on 14-3-17.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "NewsflashLevelOneView.h"

@implementation NewsflashLevelOneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 54)];
        navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
        [self addSubview:navBarImg];
        [navBarImg release];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.font = [UIFont boldSystemFontOfSize:20];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.text = @"今日快报";
        [self addSubview:titleLable];
        [titleLable release];
        
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
