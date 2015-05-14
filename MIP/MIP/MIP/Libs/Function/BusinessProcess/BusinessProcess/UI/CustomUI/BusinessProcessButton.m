//
//  BusinessProcessButton.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/03.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessProcessButton.h"

//#define BtnTextColor        [UIColor colorWithRed:102/255.0 green:174/255.0 blue:245/255.0 alpha:1.0]
#define BtnTextColor        [UIColor whiteColor]

@implementation BusinessProcessButton

+ (BusinessProcessButton *) buttonWithTitle:(NSString *)buttonTitle
{
    BusinessProcessButton *btn = [BusinessProcessButton buttonWithType: UIButtonTypeCustom];
    
    [btn setBackgroundImage:[[UIImage imageNamed:@"button.png" imageBundle:businessProcessBundle] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[[UIImage imageNamed:@"button_cbg.png" imageBundle:businessProcessBundle] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
    
    [btn setTitle:buttonTitle forState: UIControlStateNormal];
    [btn setTitleColor:BtnTextColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    btn.backgroundColor = [UIColor clearColor];
    
    return btn;
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
