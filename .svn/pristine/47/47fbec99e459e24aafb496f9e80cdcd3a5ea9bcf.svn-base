//
//  CalenderScheduleViewController.m
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "CalenderScheduleViewController.h"
#import "SuspendController.h"
#import "ScheduleInfo.h"
#import "HistoryDataDAO.h"

@interface CalenderScheduleViewController ()
{
    SuspendController *suspendViewController;
}

@end

@implementation CalenderScheduleViewController

@synthesize selectDate;

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
    [scheduleView release];
    [historyView release];
    [scheduleTimePickerView release];
    
    [super dealloc];
}

- (void)loadView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(50, 60, 869, 680)];
    bgView.backgroundColor = [UIColor clearColor];
    self.view = bgView;
    [bgView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    KalViewController *calendarController = [[KalViewController alloc] initWithSelectedDate:[NSDate date]];
    calendarController.viewDelegate = self;
    [self addChildViewController:calendarController];
    [self.view addSubview:calendarController.view];
    [calendarController release];
    
    //历史上的今天
    historyView = [[HistoryView alloc] initWithFrame:CGRectMake(25, 410, 420, 250)];
    [self.view addSubview:historyView];
    [self selectDateWith:[NSDate date]];
    
    //日程安排
    scheduleView = [[ScheduleView alloc] initWithFrame:CGRectMake(460, 0, 400, 660)];
    scheduleView.schViewDelegate = self;
    [self.view addSubview:scheduleView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *datestring = [NSString stringWithFormat:@"%@ 00:00:00",datestr];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dayDate = [dateFormatter dateFromString:datestring];
    [dateFormatter release];
    NSLog(@"%@",dayDate);
    
    [self reflashScheduleTableView:dayDate];
    
    [scheduleView.addScheduleBtn addTarget:self action:@selector(addAScheduleEvent) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAScheduleEvent
{
    ScheduleTimePickerViewController *scheduleTimePickerViewController = [[ScheduleTimePickerViewController alloc] init];
    
    scheduleTimePickerViewController.curDate = self.selectDate;
    
    scheduleTimePickerViewController.scheduleDelegate = self;
    
    suspendViewController = [[SuspendController alloc] initWithContentViewController:scheduleTimePickerViewController];
    
    [suspendViewController show];
    
    [scheduleTimePickerViewController release];
    
    [suspendViewController release];
}

- (void)cancelToSetSchedule
{
    [suspendViewController dismiss];
    
    [scheduleView.scheduleTable deselectRowAtIndexPath:scheduleView.scheduleTable.indexPathForSelectedRow animated:YES];
}

#pragma mark KalViewControllerDelegate

-(void)selectDateWith:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *datestr = [dateFormatter stringFromDate:date];
    NSString *datestring = [NSString stringWithFormat:@"%@ 00:00:00",datestr];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dayDate = [dateFormatter dateFromString:datestring];
    [dateFormatter release];
    
    scheduleView.scheduleTable.editing = NO;
    
    unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [calendar components:units fromDate:dayDate];
    
    NSString *dateString = [NSString stringWithFormat:@"%d-%d-%d",[components year],[components month],[components day]];
    
    HistoryDataDAO *dao = [[HistoryDataDAO alloc] init];
    NSMutableArray *historyArray = [dao selectHistoryByTime:dateString];
    [dao release];
    
    [historyView reflashHistoryList:historyArray];
    
    [self reflashScheduleTableView:dayDate];
    
    self.selectDate = dayDate;
    
    scheduleView.curDate = self.selectDate;
}

#pragma mark ScheduleViewDelegate

- (void)didSelectScheduleWith:(ScheduleInfo *)schedule
{
    ScheduleTimePickerViewController *scheduleTimePickerViewController = [[ScheduleTimePickerViewController alloc] initWithSchedule:schedule];
    
    scheduleTimePickerViewController.scheduleDelegate = self;
    
    scheduleTimePickerViewController.curDate = schedule.createDate;
    
    suspendViewController = [[SuspendController alloc] initWithContentViewController:scheduleTimePickerViewController];
    
    [suspendViewController show];
    
    [scheduleTimePickerViewController release];
    
    [suspendViewController release];
}

#pragma mark ScheduleViewControllerDelegate

- (void)reflashScheduleTableView:(NSDate *)date
{
    if (suspendViewController != nil)
    {
        [suspendViewController dismiss];
        suspendViewController = nil;
    }
    
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ScheduleInfo class]) inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createDate == %@",date];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setPredicate:predicate];
    
    [request setEntity:entityDescription];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    [scheduleView reflashScheduleList:results];
}

- (void)cancelToAddASchedule
{
    [suspendViewController dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
