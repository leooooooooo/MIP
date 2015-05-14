//
//  SMSWidgetView.h
//  Login
//
//  Created by kangqijun on 14-2-25.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@protocol SMSWidgetViewDelegate <NSObject>

- (void)getPhoneRandomCode;
- (void)verifyPhoneRandomCode;

@end

@interface SMSWidgetView : BaseView
{
    UITextField   *m_phoneNumField;
    UITextField   *m_verifyField;
    
    id <SMSWidgetViewDelegate> m_delegate;
}

@property (retain, nonatomic) UITextField   *m_phoneNumField;
@property (retain, nonatomic) UITextField   *m_verifyField;
@property (assign, nonatomic) id <SMSWidgetViewDelegate> m_delegate;

@end
