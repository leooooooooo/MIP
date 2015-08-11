//
//  HistoryView.m
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-4-1.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "HistoryView.h"
#import "HistoryDataEntity.h"

@implementation HistoryView

@synthesize reflashBtn;

@synthesize dataArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        titleLab.text = @"历史上的今天";
        titleLab.font = [UIFont boldSystemFontOfSize:24];
        titleLab.textColor = [UIColor colorWithRed:119/255.0 green:148/255.0 blue:178/255.0 alpha:1.0];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLab];
        [titleLab release];
        
        UIImageView *itemBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, frame.size.width, frame.size.height - 100)];
        itemBackImageView.image = [UIImage imageNamed:@"bg.png" imageBundle:commonlyUsedToolBundle];
        [self addSubview:itemBackImageView];
        [itemBackImageView release];
        
        reflashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        reflashBtn.frame = CGRectMake(frame.size.width-64, 10, 64, 27);
        [reflashBtn setImage:[UIImage imageNamed:@"button_sx.png" imageBundle:commonlyUsedToolBundle] forState:UIControlStateNormal];
        [self addSubview:reflashBtn];
        
        histroyTable = [[UITableView alloc] initWithFrame:CGRectMake(2, 50, frame.size.width-4, frame.size.height - 100)];
        histroyTable.dataSource = self;
        histroyTable.delegate = self;
        histroyTable.rowHeight = 50.0;
        histroyTable.backgroundColor = [UIColor clearColor];
        [self addSubview:histroyTable];
    }
    return self;
}

- (void)reflashHistoryList:(NSMutableArray *)arr
{
    self.dataArr = arr;
    
    [histroyTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = [indexPath row];
    
    HistoryDataEntity *entity = [dataArr objectAtIndex:[indexPath row]];
    
    cell.textLabel.numberOfLines = 2;
    
    cell.textLabel.text = [NSString stringWithFormat:@"● %@",entity.dayData];
    
    return cell;
}

- (void)dealloc
{
    [histroyTable release];
    [dataArr release];
    
    [super dealloc];
}

@end
