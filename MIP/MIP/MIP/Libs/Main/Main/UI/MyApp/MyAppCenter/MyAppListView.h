//
//  MyAppListView.h
//  Main
//
//  Created by mengxianglei on 14-4-15.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "BaseView.h"

@protocol CloseAppCenterDelegate <NSObject>

- (void) closeAppCenter;

@end

@interface MyAppListView : BaseView
{
    UIButton            *closeButton;
    
    __weak id<CloseAppCenterDelegate> m_delegate;
}

@property (retain, nonatomic) UIButton            *closeButton;

- (void) setTypeListView : (UIView*) listView;

- (void) setAppListView : (UIView*) listView;

@property (nonatomic, retain) id<CloseAppCenterDelegate> m_delegate;

@end
