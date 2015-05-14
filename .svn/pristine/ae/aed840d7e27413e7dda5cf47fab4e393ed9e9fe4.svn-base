//
//  KTabBarController.m
//  GACloud
//
//  Created by kangqijun on 14-3-7.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "KTabBarController.h"
#import "TabBaseViewController.h"

@interface KTabBarController ()
{
    NSMutableArray           *navTagArr;
    NSArray                  *imageNameArr;
    NSArray                  *imageNameHLArr;
    NSMutableArray           *itemViewArr;
}

@property (retain, nonatomic) NSMutableArray *navTagArr;

@end

@implementation KTabBarController

@synthesize tabDelegate;
@synthesize viewControllers;
@synthesize tabBarView;

@synthesize navTagArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [tabBarView release];
    [navTagArr release];
    [imageNameArr release];
    [itemViewArr release];
    [imageNameHLArr release];
    [viewControllers release];
    [super dealloc];
}

- (void)loadView
{
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=7.0)
    {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
        self.view = tempView;
        [tempView release];
    }
    else
    {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        self.view = tempView;
        [tempView release];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 80, [UIScreen mainScreen].bounds.size.width, 60)];
    tabBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tabBarView];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tabBarView.frame.size.width, 60)];
    bgImageView.image = [UIImage imageNamed:@"bg_tab.png" imageBundle:mainBundle];
    [tabBarView addSubview:bgImageView];
    [bgImageView release];
    
    NSArray *itemName = [NSArray arrayWithObjects:@"功能列表",@"签到",@"我的应用",@"最新消息", nil];
    imageNameArr = [[NSArray alloc] initWithObjects:@"icon_gnlb.png",@"icon_qd.png",@"icon_wdyy.png",@"icon_zxxx.png",nil];
    imageNameHLArr = [[NSArray alloc] initWithObjects:@"icon_gnlb_1.png",@"icon_qd_1.png",@"icon_wdyy_1.png",@"icon_zxxx_1.png",nil];
    itemViewArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<4; i++)
    {
        TabBarItemView *itemView = [[TabBarItemView alloc] initWithFrame:CGRectMake(i*80,0, 80, 60)];
        itemView.bgImageView.image = [UIImage imageNamed:[imageNameArr objectAtIndex:i] imageBundle:mainBundle];
        itemView.nameLab.text = [itemName objectAtIndex:i];
        itemView.itemButton.tag = i;
        [itemView.itemButton addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [tabBarView addSubview:itemView];
        [itemViewArr addObject:itemView];
        [itemView release];
    }
    
}

- (void)selectItem:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    [self chooseItemWith:btn.tag];
}

- (void)chooseItemWith:(int)_index
{
    for (int i=0; i<4; i++)
    {
        TabBarItemView *itemView = [itemViewArr objectAtIndex:i];
        itemView.bgImageView.image = [UIImage imageNamed:[imageNameArr objectAtIndex:i] imageBundle:mainBundle];
    }
    
    TabBarItemView *selectItemView = [itemViewArr objectAtIndex:_index];
    selectItemView.bgImageView.image = [UIImage imageNamed:[imageNameHLArr objectAtIndex:_index] imageBundle:mainBundle];
    
    NSString *navTagStr =[NSString stringWithFormat:@"%d",_index];
    
    TabBaseViewController *controller = [self.viewControllers objectAtIndex:_index];
    
    [controller tabViewAppear];
    
    //如果视图已经加过，则将页面放在视图最顶层
    if ([navTagArr containsObject:navTagStr])//视图已经加过
    {
        //将已经加过视图置为最顶层
        [self.view bringSubviewToFront:controller.view];
    }
    else
    {
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        
        [navTagArr addObject:navTagStr];
    }
    
    //将tabBar置为最顶层
    [self.view bringSubviewToFront:tabBarView];
    
    if (tabDelegate)
    {
        [tabDelegate selectTabBarAtIndex:_index];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
