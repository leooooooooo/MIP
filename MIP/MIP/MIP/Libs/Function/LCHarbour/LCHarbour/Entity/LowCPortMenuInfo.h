//
//  LowCPortMenuInfo.h
//  LCHarbour
//
//  Created by lu_sicong on 2014/04/25.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LowCPortMenuInfo : NSManagedObject

@property (nonatomic, retain) NSString * menuId;
@property (nonatomic, retain) NSString * menuName;
@property (nonatomic, retain) NSString * sort;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * userId;

+ (NSFetchedResultsController *)sharedFetchedResultsController;

+ (void)releaseFetchedResultsController;

@end