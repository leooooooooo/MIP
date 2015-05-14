//
//  FunctionListViewController.m
//  MIP_iPhone_LYG
//
//  Created by kangqijun on 14-4-10.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "FunctionListViewController.h"
#import "FunctionListCell.h"
#import "ShadowView.h"
#import "NewsCenterLevelOneViewController.h"
#import "KTabBarController.h"

@interface FunctionListViewController ()
{
    NSArray       *moduleArray;
    ShadowView    *shadowView;
}

@end

@implementation FunctionListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tabViewDidDisappear
{
//    if ([[Userinfo shareUserinfo].moduleArray count] > 0)
//    {
//        Module *entity = [[Userinfo shareUserinfo].moduleArray objectAtIndex:0];
//        [(NewsCenterLevelOneViewController *)entity.viewController releaseFetchedDelegate];
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    UITableView *functionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 125)];
    functionTable.dataSource = self;
    functionTable.delegate = self;
    functionTable.rowHeight = 50.0;
    functionTable.backgroundColor = [UIColor whiteColor];
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        functionTable.separatorInset = UIEdgeInsetsZero;
    }
#endif
    [self.view addSubview:functionTable];
    [functionTable release];
    
    shadowView = [[ShadowView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0.0;
    shadowView.userInteractionEnabled = YES;
    [self.view addSubview:shadowView];
    
    functionModuleViewController = [[FunctionModuleViewController alloc] init];
    functionModuleViewController.moveDelegate = self;
    [self addChildViewController:functionModuleViewController];
    [self.view addSubview:functionModuleViewController.view];
    [functionModuleViewController release];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[Userinfo shareUserinfo].moduleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FunctionListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[FunctionListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Module *entity = [[Userinfo shareUserinfo].moduleArray objectAtIndex:indexPath.row];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:entity.backgroundImage];
    
    cell.backgroundView = imageView;
    
    [imageView release];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selectBG.png" imageBundle:mainBundle]];
    
    cell.selectedBackgroundView = imageView;
    
    [imageView release];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png" imageBundle:mainBundle]];
    
    cell.accessoryView = imageView;
    
    [imageView release];
    
    cell.imageView.image = entity.iconImage;
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    cell.textLabel.text = entity.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Module *entity = [[Userinfo shareUserinfo].moduleArray objectAtIndex:indexPath.row];
    
    if (entity.hasChildren == NO)
    {
        if (!entity.viewController)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能模块初始化失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            
            [alertView show];
            
            [alertView release];
        }
        else
        {
            [UIView animateWithDuration:0.2 animations:^{
                
                CGRect rect = functionModuleViewController.view.frame;
                
                if (rect.origin.x != self.view.frame.size.width)
                {
                    rect.origin.x = self.view.frame.size.width;
                    
                    shadowView.alpha = 0.0;
                }
                
                functionModuleViewController.view.frame = rect;
                
            }];
            
            
            [self.navigationController pushViewController:(UIViewController *)entity.viewController animated:YES];
        }
        
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect rect = functionModuleViewController.view.frame;
            
            if (rect.origin.x == self.view.frame.size.width)
            {
                rect.origin.x = kLeftDistanceX;
                
                shadowView.alpha = 0.6;
            }
            else
            {
                rect.origin.x = self.view.frame.size.width;
                
                shadowView.alpha = 0.0;
            }
            
            functionModuleViewController.view.frame = rect;
            
            [functionModuleViewController loadDataWithModule:entity];
            
        } completion:^(BOOL finished)
         {
             if (finished)
             {
                 [UIView animateWithDuration:0.2 animations:^{
                     
                     CGRect rect = functionModuleViewController.view.frame;
                     
                     if (rect.origin.x == self.view.frame.size.width)
                     {
                         rect.origin.x = kLeftDistanceX;
                         
                         shadowView.alpha = 0.6;
                         
                         functionModuleViewController.view.frame = rect;
                     }
                     
                 }];
                 
             }
         }];
    }
}

#pragma mark FunctionModuleViewControllerDelegate

- (void)moveToOutside
{
    [UIView animateWithDuration:0.2 animations:^{
        
        shadowView.alpha = 0.0;
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
