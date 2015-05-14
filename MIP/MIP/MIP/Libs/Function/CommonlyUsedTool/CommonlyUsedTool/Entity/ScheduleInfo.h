//
//  ScheduleInfo.h
//  MIP
//
//  Created by kangqijun on 14-4-2.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ScheduleInfo : NSManagedObject

@property (nonatomic, retain) NSDate   * createDate;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * endTime;

@end
