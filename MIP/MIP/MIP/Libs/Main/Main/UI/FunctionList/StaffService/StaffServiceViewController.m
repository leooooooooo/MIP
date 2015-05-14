//
//  StaffServiceViewController.m
//  Main
//
//  Created by kangqijun on 14-4-26.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "StaffServiceViewController.h"

#import "StaffServiceCell.h"

#import "MainNetRequest.h"

@interface StaffServiceViewController ()
{
    UITableView *StaffServiceTable;
}

@property (retain, nonatomic) NSArray *dataArr;

@end

@implementation StaffServiceViewController

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
    
    Module *module = [[Userinfo shareUserinfo] getModuleWithIdentifier:kStaffServiceModuleIdentifier];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = module.name;
    [self.view addSubview:titleLable];
    [titleLable release];
    
    StaffServiceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 125)];
    StaffServiceTable.dataSource = self;
    StaffServiceTable.delegate = self;
    StaffServiceTable.rowHeight = 50.0;
    StaffServiceTable.backgroundColor = [UIColor whiteColor];
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        StaffServiceTable.separatorInset = UIEdgeInsetsZero;
    }
#endif
    [self.view addSubview:StaffServiceTable];
    [StaffServiceTable release];
    
    [self requestStaffServiceList];
}

- (void)requestStaffServiceList
{
    Module *module = [[Userinfo shareUserinfo] getModuleWithIdentifier:kStaffServiceModuleIdentifier];
    
    [MainNetRequest executeAsynchronous:@selector(getNextModuleList) callback:@selector(callBackRequestStaffServiceList:error:) backTarget:self args:module.unionId,@"0",nil];
}

-(void)callBackRequestStaffServiceList:(NSData *)data error:(NSError*)error
{
    NSData *bodyData = [MainNetRequest extractDataBodyFromResponsePackage:data];
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        
        if (isValid(bizdata))
        {
            self.dataArr = [bizdata objectForKey:@"data"];
            
            [StaffServiceTable reloadData];
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
    StaffServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[StaffServiceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
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
    NSString *urlStr = nil;
    
    switch (indexPath.row) {
        case 0:
        {
            urlStr = @"https://itunes.apple.com/cn/app/du-lan-tian-xia-ji-gou-ban/id489715016?mt=8";
        }
            break;
        case 1:
        {
            urlStr = nil;
        }
            break;
        default:
            break;
    }
    
    if (isValid(urlStr)) {
        NSURL *url = [NSURL URLWithString:urlStr];
        [[UIApplication sharedApplication] openURL:url];
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"无此应用，请先去“我的应用”中安装此应用。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
