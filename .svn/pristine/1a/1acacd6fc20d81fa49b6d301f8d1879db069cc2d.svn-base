//
//  WebSiteView.m
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "WebSiteView.h"

@implementation WebSiteView
@synthesize categoryRefreshButton,itemRefreshButton,categoryAddButton,itemAddButton,categoryEditButton,itemEditButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 35)];
        categoryLabel.text = @"网站分类";
        categoryLabel.textColor = [UIColor colorWithHex:@"799dbf"];
        categoryLabel.font = [UIFont boldSystemFontOfSize:24];
        categoryLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:categoryLabel];
        [categoryLabel release];
        
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(450, 10, 100, 35)];
        itemLabel.text = @"网址";
        itemLabel.textColor = [UIColor colorWithHex:@"799dbf"];
        itemLabel.font = [UIFont boldSystemFontOfSize:24];
        itemLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:itemLabel];
        [itemLabel release];
        
        categoryRefreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        categoryRefreshButton.frame = CGRectMake(350, 14, 64, 27);
        [categoryRefreshButton setImage:[UIImage imageNamed:@"button_sx.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [self addSubview:categoryRefreshButton];
        
        itemRefreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemRefreshButton.frame = CGRectMake(775, 14, 64, 27);
        [itemRefreshButton setImage:[UIImage imageNamed:@"button_sx.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [self addSubview:itemRefreshButton];
        
        categoryAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        categoryAddButton.frame = CGRectMake(130, 630, 63, 21);
        [categoryAddButton setImage:[UIImage imageNamed:@"button_tianjia.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [self addSubview:categoryAddButton];
        
        itemAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemAddButton.frame = CGRectMake(530, 630, 63, 21);
        [itemAddButton setImage:[UIImage imageNamed:@"button_tianjia.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [self addSubview:itemAddButton];
        categoryEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
        categoryEditButton.frame = CGRectMake(245, 631, 63, 18);
        [categoryEditButton setImage:[UIImage imageNamed:@"button_bianji.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [self addSubview:categoryEditButton];
        
        itemEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemEditButton.frame = CGRectMake(645, 631, 64, 18);
        [itemEditButton setImage:[UIImage imageNamed:@"button_bianji.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [self addSubview:itemEditButton];
        
        UIImageView *categoryBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, 400, 558)];
        categoryBackImageView.image = [UIImage imageNamed:@"bg.png" imageBundle:commonlyUsedToolBundle];
        [self addSubview:categoryBackImageView];
        [categoryBackImageView release];
        
        
        UIImageView *itemBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(440, 55, 400, 558)];
        itemBackImageView.image = [UIImage imageNamed:@"bg_3.png" imageBundle:commonlyUsedToolBundle];
        [self addSubview:itemBackImageView];
        
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
