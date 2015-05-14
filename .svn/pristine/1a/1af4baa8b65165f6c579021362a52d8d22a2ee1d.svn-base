//
//  SignInViewController.m
//  MIP_iPhone_LYG
//
//  Created by kangqijun on 14-4-10.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "SignInViewController.h"
#import "SignInView.h"
#import "SignComponent.h"
#import "SignListTableViewController.h"
#import "MainNetRequest.h"
#import "MBProgressHUD.h"
#import "MainDataParser.h"

@interface SignInViewController () <SignViewDelegate>
{
    SignInView *signView;
    SignComponent *signComponent;
}

@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tabViewAppear
{
    signComponent = [[SignComponent alloc] initWithComposite:self];
    [signComponent gpsLocaiton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
//    signComponent = [[SignComponent alloc] initWithComposite:self];
//    [signComponent gpsLocaiton];
    
    signView = [[SignInView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 60)];
    signView.delegate = self;
    
    [self.view addSubview:signView];
    
    SignListTableViewController *signList = [[SignListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [signView setTableView:signList.tableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [MainNetRequest executeAsynchronous:@selector(getSignList) callback:@selector(callBackGetSignList:error:) backTarget:self args:nil];
}

-(void)callBackGetSignList:(NSData *)data error:(NSError*)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [MainNetRequest extractDataBodyFromResponsePackage:data];
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            
            if (0 == [ret intValue])
            {
                [MainDataParser parseSignList:bodyData];
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" message:@"签到信息获取失败，请检查网络或者重新操作。"];
    
    return;
    
}

-(void)callBackUpdataSignIn:(NSData *)data error:(NSError*)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [MainNetRequest extractDataBodyFromResponsePackage:data];
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            
            if (0 == [ret intValue])
            {
                [self showAlert:@"提示" message:@"签到成功。"];
                
                [MainNetRequest executeAsynchronous:@selector(getSignList) callback:@selector(callBackGetSignList:error:) backTarget:self args:nil];
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" message:@"签到失败，请检查网络或者重新操作。"];
    
    return;
    
}

- (void) showAlert : (NSString *)title message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}

- (void)signIn
{
    if (![signView.currentPosition isEqualToString:@""] && ![signView.currentPosition isEqualToString:@"未确定"]) {
        [MainNetRequest executeAsynchronous:@selector(updataSignInPlace) callback:@selector(callBackUpdataSignIn:error:) backTarget:self args:signView.currentPosition, nil];
        
        return;
    }
    
    [self showAlert:@"错误" message:@"签到失败，未能成功定位。关闭窗口以重试"];
}

- (void)setLocationPlace:(NSString *)currentPosition
{
    signView.currentPosition = currentPosition;
}

- (void)dealloc
{
    [signView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
