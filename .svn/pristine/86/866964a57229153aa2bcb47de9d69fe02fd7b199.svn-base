//
//  SignInView.h
//  Main
//
//  Created by lu_sicong on 2014/04/14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "BaseView.h"

@protocol SignViewDelegate <NSObject>

- (void) signIn;

@end

@interface SignInView : BaseView
{
    NSTimer *m_timer;
    
    UILabel *m_currentPosition;
    UILabel *m_currentTime;
    
    UIView *m_tableView;
    
    id <SignViewDelegate> m_delegate;
}

@property (nonatomic, retain) NSString *currentPosition;
@property (nonatomic, assign) id <SignViewDelegate> delegate;

- (void) setTableView : (UITableView *)tableView;

@end
