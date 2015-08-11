//
//  ScheduleView.m
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-4-1.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ScheduleView.h"

@implementation ScheduleView

@synthesize reflashBtn;
@synthesize addScheduleBtn;
@synthesize editScheduleBtn;
@synthesize scheduleArr;
@synthesize schViewDelegate;
@synthesize scheduleTable;
@synthesize curDate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        titleLab.text = @"日程安排";
        titleLab.font = [UIFont boldSystemFontOfSize:24];
        titleLab.textColor = [UIColor colorWithRed:119/255.0 green:148/255.0 blue:178/255.0 alpha:1.0];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLab];
        
        UIImageView *itemBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, frame.size.height - 100)];
        itemBackImageView.image = [UIImage imageNamed:@"bg.png" imageBundle:commonlyUsedToolBundle];
        [self addSubview:itemBackImageView];
        [itemBackImageView release];
        
        reflashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        reflashBtn.frame = CGRectMake(frame.size.width-64, 10, 64, 27);
        [reflashBtn setImage:[UIImage imageNamed:@"button_sx.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [self addSubview:reflashBtn];
        
        scheduleTable = [[UITableView alloc] initWithFrame:CGRectMake(2, 52, frame.size.width-4, frame.size.height - 100)];
        scheduleTable.dataSource = self;
        scheduleTable.delegate = self;
        scheduleTable.rowHeight = 50.0;
        scheduleTable.backgroundColor = [UIColor clearColor];
        [self addSubview:scheduleTable];
        
        addScheduleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addScheduleBtn.frame = CGRectMake(80, frame.size.height - 30, 63, 21);
        [addScheduleBtn setImage:[UIImage imageNamed:@"button_tianjia.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [self addSubview:addScheduleBtn];
        
        editScheduleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editScheduleBtn.frame = CGRectMake(195, frame.size.height - 30, 63, 18);
        [editScheduleBtn setImage:[UIImage imageNamed:@"button_bianji.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [editScheduleBtn addTarget:self action:@selector(editButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:editScheduleBtn];
        
    }
    return self;
}

- (void)reflashScheduleList:(NSArray *)arr
{
    self.scheduleArr = arr;
    [scheduleTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [scheduleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    cell.tag = [indexPath row];
    
    ScheduleInfo *schedule = [scheduleArr objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = schedule.content;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:schedule.startTime];
    [formatter release];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"创建时间: %@",dateString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScheduleInfo *schedule = [scheduleArr objectAtIndex:[indexPath row]];
    
    if (schViewDelegate)
    {
        [schViewDelegate didSelectScheduleWith:schedule];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        ScheduleInfo *schedule = [scheduleArr objectAtIndex:[indexPath row]];
        
        NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
        [context deleteObject:schedule];
        
        NSError *saveError = nil;
        [context save:&saveError];
        
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ScheduleInfo class]) inManagedObjectContext:context];
        
        
        //先查询用户的公文流转栏目列表的历史记录
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createDate == %@",self.curDate];
        
        [request setEntity:entityDescription];
        
        [request setPredicate:predicate];
        
        NSError *error = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&error];
        
        self.scheduleArr = results;
        
        [scheduleTable reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)editButtonEvent
{
    if (scheduleTable.editing)
    {
        [scheduleTable setEditing:NO animated:YES];
    }
    else
    {
        [scheduleTable setEditing:YES animated:YES];
    }
    
}

- (void)dealloc
{
    [scheduleArr release];
    [scheduleTable release];
    
    [super dealloc];
}

@end
