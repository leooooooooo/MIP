//
//  CommonlyUsedToolViewController.m
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "CommonlyUsedToolViewController.h"


@interface CommonlyUsedToolViewController ()

@end

@implementation CommonlyUsedToolViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)loadView
{
    _commonlyUsedToolView = [[CommonlyUsedToolView alloc] initWithFrame:CGRectMake(82, 0, 947, 748)];//减去的15个像素为左边的阴影
    [_commonlyUsedToolView.closeBtn addTarget:self action:@selector(closeDocTwoLevelData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = _commonlyUsedToolView;
    [_commonlyUsedToolView release];
    
    webController = [[WebSiteViewController alloc] init];
    [self.view addSubview:webController.view];
    [self addChildViewController:webController];
    [webController release];
    
    noteController = [[NoteViewController alloc] init];
    [self.view addSubview:noteController.view];
    noteController.view.hidden = YES;
    [self addChildViewController:noteController];
    [noteController release];
    
    calenderController = [[CalenderScheduleViewController alloc] init];
    calenderController.view.hidden = YES;
    [self.view addSubview:calenderController.view];
    [self addChildViewController:calenderController];
    [calenderController release];
    
    _commonlyUsedToolSwitchView = [[CommonlyUsedToolSwitchView alloc] initWithFrame:CGRectMake(638+131, 608,151, 140)];
    [self.view addSubview:_commonlyUsedToolSwitchView];
    [_commonlyUsedToolSwitchView release];
    
    UIButton *webSiteButton = _commonlyUsedToolSwitchView.webSiteButton;
    UIButton *noteButton = _commonlyUsedToolSwitchView.noteButton;
    UIButton *calenderButton = _commonlyUsedToolSwitchView.calenderButton;
    
    [webSiteButton addTarget:self action:@selector(webSiteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [noteButton addTarget:self action:@selector(noteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [calenderButton addTarget:self action:@selector(calenderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

//关闭
- (void)closeDocTwoLevelData:(id)sender
{
    [self.navScrollController popViewControllerAnimated:YES];
}

//点击网址
- (void)webSiteButtonClick:(id)sender{
    DLog(@"点击网址");
    _commonlyUsedToolView.titleLab.text = @"常用网站";
    
    calenderController.view.hidden = YES;
    noteController.view.hidden = YES;
    webController.view.hidden = NO;
    [self.view bringSubviewToFront:webController.view];
    [self.view bringSubviewToFront:_commonlyUsedToolSwitchView];
}

//点击记事本
- (void)noteButtonClick:(id)sender{
    DLog(@"点击记事本");
    _commonlyUsedToolView.titleLab.text = @"个人记事本";
    
    calenderController.view.hidden = YES;
    webController.view.hidden = YES;
    noteController.view.hidden = NO;
    [self.view bringSubviewToFront:noteController.view];
    [self.view bringSubviewToFront:_commonlyUsedToolSwitchView];
}

//点击日历
- (void)calenderButtonClick:(id)sender{
    DLog(@"点击日历");
    _commonlyUsedToolView.titleLab.text = @"日历日程";
    
    calenderController.view.hidden = NO;
    noteController.view.hidden = YES;
    webController.view.hidden = YES;
    [self.view bringSubviewToFront:calenderController.view];
    [self.view bringSubviewToFront:_commonlyUsedToolSwitchView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
