//
//  KNavigationController.m
//  GACloud
//
//  Created by kangqijun on 14-3-7.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "KNavigationController.h"
#import "PublicManager.h"
#import "BaseScrollViewController.h"
#import "PlayMovieViewController.h"
#import "BusinessProcessLevelTwoViewController.h"

@interface KNavigationController ()

@end

@implementation KNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationBar.hidden = YES;
}

#ifdef __IPHONE_6_0
- (BOOL)shouldAutorotate
{
    if ([[PublicManager sharedInstance].viewController isKindOfClass:[PlayMovieViewController class]])
    {
        return YES;
    }
    else if ([[PublicManager sharedInstance].viewController isKindOfClass:
              [BusinessProcessLevelTwoViewController class]])
    {
        return YES;
    }
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[PublicManager sharedInstance].viewController isKindOfClass:[PlayMovieViewController class]])
    {
        return [PublicManager sharedInstance].viewController.supportedInterfaceOrientations;
    }
    else if ([[PublicManager sharedInstance].viewController isKindOfClass:
              [BusinessProcessLevelTwoViewController class]])
    {
        return [PublicManager sharedInstance].viewController.supportedInterfaceOrientations;
    }
    return UIInterfaceOrientationMaskPortrait;
}
#endif

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if ([[PublicManager sharedInstance].viewController isKindOfClass:[PlayMovieViewController class]])
    {
        return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
    }
    else if ([[PublicManager sharedInstance].viewController isKindOfClass:
              [BusinessProcessLevelTwoViewController class]])
    {
        return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
                toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
    }
    return NO;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [PublicManager sharedInstance].viewController = (BaseScrollViewController *)viewController;
    
    if ([[PublicManager sharedInstance].viewController isKindOfClass:[PlayMovieViewController class]])
    {
        if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)])
        {
            [[UIDevice currentDevice]performSelector:@selector(setOrientation:)
                                          withObject:(id)UIDeviceOrientationLandscapeLeft];
        }
    }
    else if ([[PublicManager sharedInstance].viewController isKindOfClass:[BusinessProcessLevelTwoViewController class]])
    {
        if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)])
        {
            [[UIDevice currentDevice]performSelector:@selector(setOrientation:)
                                          withObject:(id)UIDeviceOrientationLandscapeLeft];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [PublicManager sharedInstance].viewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
