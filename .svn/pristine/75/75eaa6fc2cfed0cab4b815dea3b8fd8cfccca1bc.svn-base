//
//  OperDeviceViewController.m
//  OperDevice
//
//  Created by wanghao on 14-3-25.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "OperDeviceViewController.h"

#import "OperDeviceTableViewController.h"
#import "OperDeviceContentViewController.h"

@interface OperDeviceViewController () <OperDeviceTableDelegate>
{
    OperDeviceContentViewController           *_contentViewController;
}

@end

@implementation OperDeviceViewController

- (void)dealloc {
    
    [_operDeviceView release];
    
    [super dealloc];
}


- (void)loadView
{
    _operDeviceView = [[OperDeviceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 70, SCREEN_HEIGHT)];//减去的15个像素为左边的阴影
//    [_operDeviceView.backBtn addTarget:self action:@selector(closeDocTwoLevelData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = _operDeviceView;
    
    OperDeviceTableViewController *levelOne = [[OperDeviceTableViewController alloc] init];
    levelOne.m_delegate = self;
    
    [self addChildViewController:levelOne];
    [_operDeviceView setContentView:levelOne.view];
}

- (void)selectedOperDeviceUrl:(NSString *)url withTitle:(NSString *)title
{
    [self openContent:url withTitle:title];
}

- (void)openContent:(NSString *)content withTitle:(NSString *)name
{
    if (!isValid(content)||[content isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"当前条目地址为空！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    _contentViewController = [[OperDeviceContentViewController alloc] init];
    [self presentViewController:_contentViewController animated:YES completion:NULL];
    
    NSURL *url = [NSURL URLWithString:[content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_contentViewController.contentWebView loadRequest:[NSURLRequest requestWithURL:url]];
    _contentViewController.titleLabel.text = name;
    [_contentViewController release];
    
}

//关闭
- (void)closeDocTwoLevelData:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
