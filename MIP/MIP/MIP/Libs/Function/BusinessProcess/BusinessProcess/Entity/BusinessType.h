//
//  BusinessType.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/02.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ShipInfo;

@interface BusinessType : NSManagedObject

@property (nonatomic, retain) NSString * hasNew;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *ships;

+ (NSFetchedResultsController *)sharedFetchedResultsController;

+ (void)releaseFetchedResultsController;

@end

@interface BusinessType (CoreDataGeneratedAccessors)

- (void)addShipsObject:(ShipInfo *)value;
- (void)removeShipsObject:(ShipInfo *)value;
- (void)addShips:(NSSet *)values;
- (void)removeShips:(NSSet *)values;

@end
