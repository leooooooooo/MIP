//
//  BusinessCheckBox.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/05/22.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessCheckBox.h"

#define BorderColor          [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0]
#define CircleColor          [UIColor colorWithRed:80/255.0 green:140/255.0 blue:198/255.0 alpha:1.0]

@implementation BusinessCheckBox

@synthesize checked = m_checked;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, 105, 35);
        
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(10, (self.frame.size.height-18)/2, 18, 18)];
        
        circle.layer.borderColor = [BorderColor CGColor];
        circle.layer.borderWidth = 1;
        
        circle.layer.cornerRadius = 9.0;
        circle.userInteractionEnabled = NO;
        
        [self addSubview:circle];
        
        checkMark = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 8, 8)];
        
        checkMark.backgroundColor = CircleColor;
        
        checkMark.layer.cornerRadius = 4.0;
        
        checkMark.hidden = YES;
        
        checkMark.userInteractionEnabled = NO;
        
        [circle addSubview:checkMark];
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, self.frame.size.width-44, self.frame.size.height)];
        
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0];
        titleLab.font = [UIFont boldSystemFontOfSize:13];
        titleLab.text = @"确 认";
        
        [self addSubview:titleLab];
        [titleLab release];
        
        [self addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

+ (BusinessCheckBox *)button
{
    BusinessCheckBox *tmpButton = [BusinessCheckBox buttonWithType:UIButtonTypeCustom];
    tmpButton.checked = NO;
    
    return tmpButton;
}

- (void)setChecked:(BOOL)checked
{
    [UIView animateWithDuration:0.3 animations:^{
        checkMark.hidden = !checked;
    }];
    
    m_checked = checked;
}

- (void) clickButton
{
    self.checked = !self.checked;
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
