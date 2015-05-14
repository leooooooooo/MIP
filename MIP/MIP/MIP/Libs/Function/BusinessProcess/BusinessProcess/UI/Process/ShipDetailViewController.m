//
//  ShipDetailViewController.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/09.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ShipDetailViewController.h"
#import "ShipDetailView.h"
#import "BusinessNetRequest.h"
#import "BusinessDataParser.h"
#import "MBProgressHUD.h"
#import "BusinessType.h"
#import "BusinessDefine.h"

@interface ShipDetailViewController ()
{
    ShipDetailView *m_shipDetailView;
    
    BusinessType *m_processType;
}

@end

@implementation ShipDetailViewController

@synthesize processType = m_processType;

- (id)initWithShipId: (NSString *)shipId
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.shipId = shipId;
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
    
    m_shipDetailView = [[ShipDetailView alloc] initWithFrame:self.contentView.frame];
    
    [self.contentView addSubview:m_shipDetailView];
    
    self.title = @"船舶信息";
    
    [BusinessNetRequest executeAsynchronous:@selector(requestForBerthingProcessInfoDetail)
                                   callback:@selector(berthBusinessProcessCallback:error:) backTarget:self args:m_shipId, nil];
    
    switch ([m_processType.type integerValue]) {
        case BerthingProcess:
        {
            [BusinessNetRequest executeAsynchronous:@selector(requestForBerthingProcessInfoDetail)
                                           callback:@selector(berthBusinessProcessCallback:error:) backTarget:self args:m_shipId, nil];
        }
            break;
        case JobProcess:
        {
            [BusinessNetRequest executeAsynchronous:@selector(requestForJobProcessInfoDetail)
                                           callback:@selector(berthBusinessProcessCallback:error:) backTarget:self args:m_shipId, nil];
        }
            break;
        case UnberthingProcess:
        {
            [BusinessNetRequest executeAsynchronous:@selector(requestForUnberthingProcessInfoDetail)
                                           callback:@selector(berthBusinessProcessCallback:error:) backTarget:self args:m_shipId, nil];
        }
            break;
        case OutwardProcess:
        {
            [BusinessNetRequest executeAsynchronous:@selector(requestForOutwardProcessInfoDetail)
                                           callback:@selector(berthBusinessProcessCallback:error:) backTarget:self args:m_shipId, nil];
        }
            break;
        default:
            break;
    }
    
}

- (void) berthBusinessProcessCallback : (NSData *)data error: (NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (isValid(data))
    {
        //获取body中的数据
        NSData *bodyData = [BusinessNetRequest extractDataBodyFromResponsePackage:data];
        
        NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
        
        if (isValid(bodyDictionary))
        {
            NSString *ret = [bodyDictionary objectForKey:@"ret"];
            
            if (0 == [ret intValue])
            {
                NSDictionary *resultData = [BusinessDataParser parseShipInfoDetail:bodyData];
                
                [self setShipInfoDictionary:resultData];
                
                return;
            }
        }
    }
    
    [self showAlert:@"提示" withMsg:@"船只信息获取失败，请检查网络或者重新操作。"];
    
    return;
}

- (void)setShipInfoDictionary : (NSDictionary *)dic
{
    NSArray *voyageKeys = [NSArray arrayWithObjects:
                           @"shipnamecn",
                           @"shipnameen",
                           @"linetype",
                           @"invoyage",
                           @"outvoyage",
                           @"tradename",
                           @"fromport",
                           @"toport",
                           @"etaarrivetime",
                           @"indraft",
                           @"outdraft",
                           @"fastfee",
                           nil];
    
    
    NSArray *voyageList = [self getValuesForKeys:voyageKeys fromDic:dic];
    m_shipDetailView.arrVoyage = voyageList;
    
    NSArray *summaryKeys = [NSArray arrayWithObjects:
                            @"nation",
                            @"callno",
                            @"speed",
                            @"totalton",
                            @"actualton",
                            @"loadton",
                            @"shiplength",
                            @"shipwidth",
                            @"metreton",
                            @"shiptype",
                            @"hatchcount",
                            @"maxdeep",
                            @"shipcompany",
                            @"builddate",
                            nil];
    
    NSArray *summaryList = [self getValuesForKeys:summaryKeys fromDic:dic];
    m_shipDetailView.arrSummary = summaryList;
    
}

- (NSArray *) getValuesForKeys : (NSArray *)sKeys fromDic: (NSDictionary *)dic
{
    NSMutableArray *tmpValueList = [[NSMutableArray alloc] init];
    
    for (NSString *sKey in sKeys) {
        
        NSString *tmpStr = [dic objectForKey:sKey];
        
        if (!tmpStr) {
            tmpStr = [NSString string];
        }
        
        [tmpValueList addObject: tmpStr];
    }
    
    NSArray *result = [NSArray arrayWithArray:tmpValueList];
    
    [tmpValueList release];
    
    return result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#ifdef __IPHONE_6_0
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
#endif

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
