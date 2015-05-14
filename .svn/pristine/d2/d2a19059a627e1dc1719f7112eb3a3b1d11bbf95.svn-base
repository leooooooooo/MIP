//
//  SettingSwitch.h
//  Setting
//
//  Created by lu_sicong on 2014/04/17.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchChangeDelegate <NSObject>

- (void) switchChange : (id)sender;

@end

@interface SettingSwitch : UIButton
{
    BOOL isOn;
    
    UIImageView *btnStateImage;
    
    id <SwitchChangeDelegate> m_delegate;
}

@property (nonatomic, assign) BOOL on;

@property (nonatomic, assign) id <SwitchChangeDelegate> delegate;

@end
