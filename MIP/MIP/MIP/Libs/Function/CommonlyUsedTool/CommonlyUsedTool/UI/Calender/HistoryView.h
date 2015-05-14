//
//  HistoryView.h
//  CommonlyUsedTool
//
//  Created by kangqijun on 14-4-1.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    UIButton        *reflashBtn;
    
    UITableView     *histroyTable;
    
    NSMutableArray  *dataArr;
}

@property (retain, nonatomic) UIButton        *reflashBtn;

@property (retain, nonatomic) NSMutableArray  *dataArr;

- (void)reflashHistoryList:(NSMutableArray *)arr;

@end
