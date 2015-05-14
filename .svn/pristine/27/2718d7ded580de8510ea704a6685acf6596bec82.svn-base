//
//  ScheduleTimePickerViewController.m
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-4-1.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ScheduleTimePickerViewController.h"

@interface ScheduleTimePickerViewController ()
{
    NSDate    *startDate;
    NSDate    *endDate;
}

@property (retain, nonatomic)NSDate    *startDate;
@property (retain, nonatomic)NSDate    *endDate;
@property (retain, nonatomic)ScheduleInfo    *curSchedule;

@end

@implementation ScheduleTimePickerViewController

@synthesize startDate;
@synthesize endDate;

@synthesize scheduleDelegate;

@synthesize curSchedule;
@synthesize curDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSchedule:(ScheduleInfo *)schedule
{
    self = [super init];
    
    if (self)
    {
        if (isValid(schedule))
        {
            self.curSchedule = schedule;
        }
    }
    
    return self;
}

- (void)dealloc
{
    [scheduleTimePickerView release];
    [super dealloc];
}

- (void)loadView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(275, 100, 320, 580)];
    self.view = bgView;
    [bgView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    scheduleTimePickerView = [[ScheduleTimePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
    [scheduleTimePickerView.sureBtn addTarget:self action:@selector(sureToSetSchedule) forControlEvents:UIControlEventTouchUpInside];
    [scheduleTimePickerView.cancelBtn addTarget:self action:@selector(cancelToSetSchedule) forControlEvents:UIControlEventTouchUpInside];
    [scheduleTimePickerView.datePicker addTarget:self action:@selector(pickerchanged) forControlEvents:UIControlEventValueChanged];
    [scheduleTimePickerView.startBtn addTarget:self action:@selector(chooseStartTime) forControlEvents:UIControlEventTouchUpInside];
    [scheduleTimePickerView.endBtn addTarget:self action:@selector(chooseEndTime) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:scheduleTimePickerView];
    
    if (isValid(self.curSchedule))
    {
        [scheduleTimePickerView loadInitData:self.curSchedule];
    }
    
    self.startDate = scheduleTimePickerView.datePicker.date;
}

- (void)sureToSetSchedule
{
    if (scheduleTimePickerView.inputTextView.text == nil || [scheduleTimePickerView.inputTextView.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"记事本为空 !"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"重新输入", nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    NSTimeInterval timeGap = [self.endDate timeIntervalSinceDate:self.startDate];
    
    if (timeGap < 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"结束事件必须晚于开始时间 !"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"重新选择", nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    [self insertAScheduleInfo];
}

- (void)cancelToSetSchedule
{
    [scheduleTimePickerView.inputTextView resignFirstResponder];
    
    if (scheduleDelegate)
    {
        [scheduleDelegate cancelToAddASchedule];
    }
}

- (void)pickerchanged
{
    NSDate *pickerDate = scheduleTimePickerView.datePicker.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:pickerDate];
    [formatter release];
    
    if (scheduleTimePickerView.startBtn.selected == YES)
    {
        scheduleTimePickerView.startTimeLab.text = dateString;
        self.startDate = pickerDate;
    }
    else
    {
        scheduleTimePickerView.endTimeLab.text = dateString;
        self.endDate = pickerDate;
    }
    
}

- (void)chooseStartTime
{
    scheduleTimePickerView.startBtn.selected = YES;
    scheduleTimePickerView.endBtn.selected = NO;
    scheduleTimePickerView.startBtn.backgroundColor = [UIColor colorWithRed:49/255.0 green:140/255.0 blue:255/255.0 alpha:1.0];
    scheduleTimePickerView.endBtn.backgroundColor = [UIColor clearColor];
    
    [scheduleTimePickerView.inputTextView resignFirstResponder];
}

- (void)chooseEndTime
{
    scheduleTimePickerView.endBtn.selected = YES;
    scheduleTimePickerView.startBtn.selected = NO;
    scheduleTimePickerView.startBtn.backgroundColor = [UIColor clearColor];
    scheduleTimePickerView.endBtn.backgroundColor = [UIColor colorWithRed:49/255.0 green:140/255.0 blue:255/255.0 alpha:1.0];
    
    [scheduleTimePickerView.inputTextView resignFirstResponder];
}


- (void)insertAScheduleInfo
{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ScheduleInfo class]) inManagedObjectContext:context];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createDate == %@",self.curDate];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    ScheduleInfo *scheduleInfo = nil;
    
    if (isValid(results) && !error) {
        
        if (results.count == 1) {//如果有原来模块权限记录,则直接使用原coreData对象
            
            scheduleInfo = [[results objectAtIndex:0] retain];
        }
        else {
            //如果没有记录则新建模块记录
            scheduleInfo = [[ScheduleInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
            scheduleInfo.createDate = self.curDate;
        }
    }
    
    scheduleInfo.startTime = self.startDate;
    scheduleInfo.endTime = self.endDate;
    scheduleInfo.content = scheduleTimePickerView.inputTextView.text;
    
    [request release];
    
    BOOL result = [context save:&error];
    
    if (result && !error)
    {
        DLog(@"insert Success !");
        
        if (scheduleDelegate)
        {
            [scheduleDelegate reflashScheduleTableView:self.curDate];
        }
    }
    else
    {
        DLog(@"insert Fail ! error:%@",error);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
