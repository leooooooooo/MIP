//
//  ShipInfo.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/03.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusinessType;

@interface ShipInfo : NSManagedObject

@property (nonatomic, retain) NSString * berthid;
@property (nonatomic, retain) NSString * berthname;
@property (nonatomic, retain) NSString * jobcompanyid;
@property (nonatomic, retain) NSString * jobcompanyname;
@property (nonatomic, retain) NSString * shipid;
@property (nonatomic, retain) NSString * shipnamecn;
@property (nonatomic, retain) NSString * unloadcargoid;
@property (nonatomic, retain) NSString * unloadcargoname;
@property (nonatomic, retain) NSString * unloadweight;
@property (nonatomic, retain) NSString * loadcargoid;
@property (nonatomic, retain) NSString * loadcargoname;
@property (nonatomic, retain) NSString * loadweight;
@property (nonatomic, retain) NSString * arriveanchortime;
@property (nonatomic, retain) NSString * shipclientid;
@property (nonatomic, retain) NSString * shipclientname;
@property (nonatomic, retain) NSString * leadmarkid;
@property (nonatomic, retain) NSString * leadmarkname;
@property (nonatomic, retain) NSString * planmarkid;
@property (nonatomic, retain) NSString * planmarkname;
@property (nonatomic, retain) NSString * planinporttime;
@property (nonatomic, retain) NSString * planoutporttime;
@property (nonatomic, retain) NSString * planmoveberthtime;
@property (nonatomic, retain) NSString * planmoveberthno;
@property (nonatomic, retain) NSDate   * createDate;
@property (nonatomic, retain) BusinessType *processType;

+ (NSFetchedResultsController *)sharedFetchedResultsController;

+ (void)releaseFetchedResultsController;

@end
