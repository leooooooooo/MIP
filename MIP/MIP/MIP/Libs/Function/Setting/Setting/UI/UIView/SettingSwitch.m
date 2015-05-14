//
//  SettingSwitch.m
//  Setting
//
//  Created by lu_sicong on 2014/04/17.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "SettingSwitch.h"

#define SwitchBgImage   [UIImage imageNamed:@"switch_1.png" imageBundle:settingBundle]
#define SwitchOnImage   [UIImage imageNamed:@"switch_2.png" imageBundle:settingBundle]
#define SwitchOffImage  [UIImage imageNamed:@"switch_3.png" imageBundle:settingBundle]

@implementation SettingSwitch

@synthesize delegate = m_delegate;

@dynamic on;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundImage:SwitchBgImage forState:UIControlStateNormal];
        
        UIImage *btnStateOff = SwitchOffImage;
        btnStateImage = [[UIImageView alloc] initWithImage:btnStateOff];
        btnStateImage.frame = CGRectMake(-1.5, -2, btnStateOff.size.width, btnStateOff.size.height);
        
        [self addSubview:btnStateImage];
        
        [self addTarget:self action:@selector(clickSwitchButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) clickSwitchButton
{
    self.on = !isOn;
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(switchChange:)]) {
        [m_delegate switchChange:self];
    }
}

- (void) setOn : (BOOL) on
{
    isOn = on;
    if (isOn) {
        btnStateImage.image = SwitchOnImage;
    } else {
        btnStateImage.image = SwitchOffImage;
    }
}

- (BOOL) on
{
    return isOn;
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
