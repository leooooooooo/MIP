//
//  HistoryDataDAO.h
//  MOA
//
//  Created by zhang beibei on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DaoBase.h"
#import "HistoryDataEntity.h"

@interface HistoryDataDAO : DaoBase

- (NSMutableArray*)selectHistoryByTime:(NSString*)scheduletime;

/*
- (BOOL)saveSchedule:(Schedule*)schedule;

- (BOOL)updateSchedule:(Schedule*)schedule;

- (BOOL)deleteSchedule:(Schedule*)schedule;

- (BOOL)deleteScheduleArray:(NSArray*)array;
*/
@end
