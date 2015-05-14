//
//  ProcessBaseViewController.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseViewController.h"

@protocol ProcessBaseControllerDelegate <NSObject>

- (void) refreshTable;

@end

@interface ProcessBaseViewController : BaseViewController
{
    NSString *m_shipId;
}

@property (nonatomic, readonly) UIView *contentView;

@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) NSString *shipId;

@property (nonatomic, assign) id<ProcessBaseControllerDelegate> delegate;

- (void) showAlert : (NSString *)title withMsg: (NSString *)message;

@end
