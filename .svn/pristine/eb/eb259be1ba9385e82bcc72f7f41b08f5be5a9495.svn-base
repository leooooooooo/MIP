//
//  SafePortViewController.m
//  Main
//
//  Created by kangqijun on 14-4-26.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "SafePortViewController.h"
#import "SafePortCell.h"
#import "MainNetRequest.h"

@interface SafePortViewController ()
{
    UITableView *SafePortTable;
}

@property (retain, nonatomic) NSArray *dataArr;

@end

@implementation SafePortViewController

@synthesize dataArr;

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
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 70, SCREEN_HEIGHT)];//减去的15个像素为左边的阴影
    
    self.view = tmpView;
    
    [tmpView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 54)];
    navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
    [self.view addSubview:navBarImg];
    [navBarImg release];
    
    Module *module = [[Userinfo shareUserinfo] getModuleWithIdentifier:kSafePortModuleIdentifier];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = module.name;
    [self.view addSubview:titleLable];
    [titleLable release];
    
    SafePortTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 125)];
    SafePortTable.dataSource = self;
    SafePortTable.delegate = self;
    SafePortTable.rowHeight = 50.0;
    SafePortTable.backgroundColor = [UIColor whiteColor];
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        SafePortTable.separatorInset = UIEdgeInsetsZero;
    }
#endif
    [self.view addSubview:SafePortTable];
    [SafePortTable release];
    
    [self requestSafePortList];
}

- (void)requestSafePortList
{
    Module *module = [[Userinfo shareUserinfo] getModuleWithIdentifier:kSafePortModuleIdentifier];
    
    [MainNetRequest executeAsynchronous:@selector(getNextModuleList) callback:@selector(callBackRequestSafePortList:error:) backTarget:self args:module.unionId,@"0",nil];
}

-(void)callBackRequestSafePortList:(NSData *)data error:(NSError*)error
{
    NSData *bodyData = [MainNetRequest extractDataBodyFromResponsePackage:data];
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        
        if (isValid(bizdata))
        {
            self.dataArr = [bizdata objectForKey:@"data"];
            
            [SafePortTable reloadData];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SafePortCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[SafePortCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.imageView.image = [UIImage imageNamed:@"list_icon.png" imageBundle:newsCenterBundle];
        
        UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selectBG.png" imageBundle:mainBundle]];
        cell.selectedBackgroundView = selectedBackgroundView;
        [selectedBackgroundView release];
        
        UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png" imageBundle:mainBundle]];
        accessoryView.frame = CGRectMake(0, 0, 10, 13);
        cell.accessoryView = accessoryView;
        [accessoryView release];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dic objectForKey:@"funcname"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *safePortUrlStr = @"https://itunes.apple.com/cn/app/ivms-5060/id585140123?mt=8";
    NSURL *safePortUrl = [NSURL URLWithString:safePortUrlStr];
    [[UIApplication sharedApplication] openURL:safePortUrl];
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"无此应用，请先去“我的应用”中安装此应用。"
//                                                       delegate:nil
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:@"确定", nil];
//    [alertView show];
//    [alertView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
