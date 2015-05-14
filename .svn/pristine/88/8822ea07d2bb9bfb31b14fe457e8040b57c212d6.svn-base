//
//  FunctionModuleViewController.m
//  Main
//
//  Created by kangqijun on 14-4-14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "FunctionModuleViewController.h"
#import "NewsflashLevelOneViewController.h"
#import "NewsCenterLevelOneViewController.h"
#import "BusinessProcessLevelOneViewController.h"
#import "SafePortViewController.h"
#import "StaffServiceViewController.h"
#import "StaffSocialViewController.h"
#import "OperDeviceViewController.h"
#import "LCLevelOneViewController.h"

@interface FunctionModuleViewController ()
{
    CGPoint                     startPoint;
}

@end

@implementation FunctionModuleViewController

@synthesize moveDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width-kLeftDistanceX, [UIScreen mainScreen].bounds.size.height-60)];
    self.view = tempView;
    [tempView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 54)];
    navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
    [self.view addSubview:navBarImg];
    [navBarImg release];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchMoveFuctionView:)];
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
    
    [recognizer release];
}

- (void)loadDataWithModule:(Module *)module
{
    if ([self.childViewControllers count] != 0)
    {
        for (UIViewController *viewcontroller in self.childViewControllers)
        {
            [viewcontroller.view removeFromSuperview];
            [viewcontroller removeFromParentViewController];
        }
    }
    
    
    if ([module.funcCode isEqualToString:@"JRKB"])
    {
        NewsflashLevelOneViewController *newsflashLevelOneViewController = [[NewsflashLevelOneViewController alloc] init];
        [self addChildViewController:newsflashLevelOneViewController];
        [self.view addSubview:newsflashLevelOneViewController.view];
        [newsflashLevelOneViewController release];
    }
    else if ([module.funcCode isEqualToString:@"XWZX"])
    {
        NewsCenterLevelOneViewController *newsCenterLevelOneViewController = [[NewsCenterLevelOneViewController alloc] init];
        [self addChildViewController:newsCenterLevelOneViewController];
        [self.view addSubview:newsCenterLevelOneViewController.view];
        [newsCenterLevelOneViewController release];
    }
    else if ([module.funcCode isEqualToString:@"YWBL"])
    {
        BusinessProcessLevelOneViewController *businessProcessLevelOneViewController = [[BusinessProcessLevelOneViewController alloc] init];
        businessProcessLevelOneViewController.unionId = module.unionId;
        
        [self addChildViewController:businessProcessLevelOneViewController];
        [self.view addSubview:businessProcessLevelOneViewController.view];
        [businessProcessLevelOneViewController release];
    }
    else if ([module.funcCode isEqualToString:@"SPJK"])//平安港口
    {
        SafePortViewController *safePortViewController = [[SafePortViewController alloc] init];
        [self addChildViewController:safePortViewController];
        [self.view addSubview:safePortViewController.view];
        [safePortViewController release];
    }
    else if ([module.funcCode isEqualToString:@"SBYX"])//设备运行
    {
        OperDeviceViewController *operDeviceViewController = [[OperDeviceViewController alloc] init];
        [self addChildViewController:operDeviceViewController];
        [self.view addSubview:operDeviceViewController.view];
        [operDeviceViewController release];
    }
    else if ([module.funcCode isEqualToString:@"DTGK"])//低碳港口
    {
        LCLevelOneViewController *lcLevelOneViewController = [[LCLevelOneViewController alloc] init];
        [self addChildViewController:lcLevelOneViewController];
        [self.view addSubview:lcLevelOneViewController.view];
        [lcLevelOneViewController release];
    }
    else if ([module.funcCode isEqualToString:@"YGFW"])//员工服务
    {
        StaffServiceViewController *staffServiceViewController = [[StaffServiceViewController alloc] init];
        [self addChildViewController:staffServiceViewController];
        [self.view addSubview:staffServiceViewController.view];
        [staffServiceViewController release];
    }
    else if ([module.funcCode isEqualToString:@"YGSJ"])//员工社交
    {
        StaffSocialViewController *staffSocialViewController = [[StaffSocialViewController alloc] init];
        [self addChildViewController:staffSocialViewController];
        [self.view addSubview:staffSocialViewController.view];
        [staffSocialViewController release];
    }
}

- (void)touchMoveFuctionView:(UIGestureRecognizer *)recognizer
{
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            startPoint = [recognizer locationInView:self.view];
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint superPoint = [recognizer locationInView:self.parentViewController.view];
            CGRect rect = self.view.frame;
            rect.origin.x = superPoint.x - startPoint.x;
            self.view.frame = rect;
            
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            CGPoint superPoint = [recognizer locationInView:self.parentViewController.view];
            CGPoint endPoint = [recognizer locationInView:self.view];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect rect = self.view.frame;
                
                if (superPoint.x - endPoint.x > self.parentViewController.view.frame.size.width / 2)
                {
                    rect.origin.x = self.parentViewController.view.frame.size.width;
                    
                    if (moveDelegate)
                    {
                        [moveDelegate moveToOutside];
                    }
                }
                else
                {
                    rect.origin.x = kLeftDistanceX;
                }
                
                self.view.frame = rect;
                
            }];
            
            break;
        }
            
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
