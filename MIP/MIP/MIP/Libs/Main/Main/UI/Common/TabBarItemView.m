//
//  TabBarItemView.m
//  GACloud
//
//  Created by kangqijun on 14-3-17.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "TabBarItemView.h"

@implementation TabBarItemView

@synthesize bgImageView;
@synthesize nameLab;
@synthesize itemButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        [self addSubview:bgImageView];
                
        nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, 80, 40)];
        nameLab.textColor = [UIColor whiteColor];
        nameLab.backgroundColor = [UIColor clearColor];
        nameLab.textAlignment = UITextAlignmentCenter;
        nameLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:nameLab];
        
        itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setFrame:CGRectMake(0,0, 80, 56)];
        [self addSubview:itemButton];
    }
    return self;
}

- (void)dealloc
{
    [bgImageView release];
    [nameLab release];
    
    [super dealloc];
}

@end
