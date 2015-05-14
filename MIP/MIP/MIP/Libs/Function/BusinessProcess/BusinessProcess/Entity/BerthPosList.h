//
//  BerthPosList.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/09.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BerthPosList : NSManagedObject

@property (nonatomic, retain) NSString * position;

+ (NSFetchedResultsController *)sharedFetchedResultsController;

+ (void)releaseFetchedResultsController;

@end
