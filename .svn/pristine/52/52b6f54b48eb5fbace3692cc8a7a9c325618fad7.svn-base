//
//  HistoryDataDAO.m
//  MOA
//
//  Created by zhang beibei on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HistoryDataDAO.h"
#import "DataBase.h"

@implementation HistoryDataDAO

//查询给定日期的所有记录，传入标准日期2012-3-26,这里以－分隔
- (NSMutableArray*)selectHistoryByTime:(NSString*)scheduletime{
    NSArray *array=[scheduletime componentsSeparatedByString:@"-"];
//    NSString *monthString=[NSString stringWithFormat:@"%@",[scheduletime substringWithRange:NSMakeRange(4, 2)]];
//    if ([monthString hasPrefix:@"0"]) {
//        monthString=[monthString substringFromIndex:1];
//    }
//    
//    NSString *dayString=[NSString stringWithFormat:@"%@",[scheduletime substringFromIndex:6]];
//    if ([dayString hasPrefix:@"0"]) {
//        dayString=[dayString substringFromIndex:1];
//    }
    
    FMDatabase *db = [DataBase instance];
	FMResultSet *rs = nil;
	NSMutableArray *historyArray = [[[NSMutableArray alloc] init] autorelease];
    
	@try {
        NSString* selectSQL = [NSString stringWithFormat: @"select distinct * from t_history where  H_MONTH = '%@' and H_DAY = '%@' order by ORDERID;",[[array objectAtIndex:1] description],[[array objectAtIndex:2] description]];
        
		rs = [db executeQuery:selectSQL];
		while ([rs next]) {
			HistoryDataEntity *history = [[HistoryDataEntity alloc] init];
            history.uuId    = [rs stringForColumn:@"id"];
//			history.day	= [NSString stringWithFormat:@"%@%@%@",[rs stringForColumn:@"YEAR"],[rs stringForColumn:@"H_MONTH"],[rs stringForColumn:@"H_DAY"]];
			history.dayData     = [rs stringForColumn:@"H_CON"];
            //schedule.createTime	= [rs stringForColumn:@"createTime"];
			[historyArray addObject:history];
			[history release];
		}
	}
	@catch (NSException *e) {
		NSLog(@"%@", [e reason]);
	}
	@finally {
		if (rs) {
			[rs close];
		}
	}
	return historyArray;
}


@end
