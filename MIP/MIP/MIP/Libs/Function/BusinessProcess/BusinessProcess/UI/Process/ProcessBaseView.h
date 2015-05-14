//
//  ProcessBaseView.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseView.h"

@protocol ProcessBaseViewDelegate <NSObject>

- (void) closeBtnClick;

@end

@interface ProcessBaseView : BaseView
{
    UILabel *m_titleLabel;
    
    UIView *m_titleView;
    
    UIView  *m_contentView;
    
    __weak id<ProcessBaseViewDelegate> m_delegate;
}

@property (nonatomic, weak) id<ProcessBaseViewDelegate> delegate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, readonly) UIView *contentView;

@end
