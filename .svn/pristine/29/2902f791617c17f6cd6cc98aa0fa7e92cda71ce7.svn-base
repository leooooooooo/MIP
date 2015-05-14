//
//  ProcessBaseViewController.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ProcessBaseViewController.h"
#import "ProcessBaseView.h"
#import "AlertView.h"
@interface ProcessBaseViewController () <ProcessBaseViewDelegate>
{
    ProcessBaseView *m_baseView;
    
    id<ProcessBaseControllerDelegate> m_delegate;
}

@end

@implementation ProcessBaseViewController

@synthesize shipId = m_shipId;

@synthesize delegate = m_delegate;

@dynamic contentView, title;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    CGRect rect=[[UIScreen mainScreen] bounds];
    m_baseView = [[ProcessBaseView alloc] initWithFrame:CGRectMake(0, 0, rect.size.height, rect.size.width-20)];
    
    m_baseView.delegate = self;
    
    self.view = m_baseView;
}

- (void)closeBtnClick
{
//    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController popViewControllerAnimated:YES];
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(refreshTable)]) {
        [m_delegate refreshTable];
    }
}

- (UIView *)contentView
{
    return m_baseView.contentView;
}

- (void)setTitle:(NSString *)title
{
    m_baseView.title = title;
}

- (NSString *)title
{
    return m_baseView.title;
}

- (void) showAlert : (NSString *)title withMsg: (NSString *)message
{
//    UIAlertView *tmpAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:Nil otherButtonTitles:@"确认", nil];
//    [tmpAlert show];
//    [tmpAlert release];

    AlertView *alert=[[AlertView alloc] initWithTitle:title andMessage:message];
    
    [alert addToView:self.view];
    
    [alert release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
