//
//  FullCompanyInfo.h
//  Contacts
//
//  Created by mengxianglei on 14-5-14.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FullCompanyInfo : NSManagedObject

@property (nonatomic, retain) NSString * companyid;
@property (nonatomic, retain) NSString * companyname;

+ (NSFetchedResultsController *)sharedFetchedResultsController;

+ (void)releaseFetchedResultsController;
@end
