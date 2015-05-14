//
//  BerthList.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/09.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BerthList : NSManagedObject

@property (nonatomic, retain) NSString * berthId;
@property (nonatomic, retain) NSString * berthNo;
@property (nonatomic, retain) NSString * deptCode;
@property (nonatomic, retain) NSString * department;

+ (NSFetchedResultsController *)sharedFetchedResultsController;

+ (void)releaseFetchedResultsController;

@end
