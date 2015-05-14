//
//  UIButton+ImageWithLabel.m
//  GACloud
//
//  Created by mengxianglei on 14-3-20.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "UIButton+ImageWithLabel.h"

@implementation UIButton (ImageWithLabel)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    [self setImageEdgeInsets:UIEdgeInsetsMake(5,
                                              5,
                                              25,
                                              25)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(32.0,
                                              -image.size.width-5,
                                              0.0,
                                              15)];
    [self setTitle:title forState:stateType];
}
@end
