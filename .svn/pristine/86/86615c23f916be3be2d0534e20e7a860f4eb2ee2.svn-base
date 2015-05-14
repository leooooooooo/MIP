//
//  RootViewController.h
//  MIP
//
//  Created by Sea on 13-9-3.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "BaseViewController.h"

#import "LoginViewController.h"
#import "MainViewController.h"

@interface RootViewController : BaseViewController <LoginDelegate, MainViewDelegate> {
    
    LoginViewController     *_loginViewController;
    
    MainViewController      *_mainViewController;
    
    UIProgressView          *proView;
    
    NSTimer                 *timer;
    
    int                     proValue;
    
    UILabel                 *contentLab;
}

- (void)checkDeviceLostState:(NSData *)data;

@end
