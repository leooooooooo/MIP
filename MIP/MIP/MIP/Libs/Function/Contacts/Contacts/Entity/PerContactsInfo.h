//
//  PerContactsInfo.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PerContactsInfo : NSManagedObject

@property (nonatomic, retain) NSString * companyid;
@property (nonatomic, retain) NSString * companyname;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * departmentid;
@property (nonatomic, retain) NSString * departmentname;
@property (nonatomic, retain) NSString * duty;
@property (nonatomic, retain) NSString * baktel;
@property (nonatomic, retain) NSString * officetel;
@property (nonatomic, retain) NSString * bakofficetel;
@property (nonatomic, retain) NSString * peremail;
@property (nonatomic, retain) NSString * headpicurl;
@property (nonatomic, retain) NSString * markweibo;
@property (nonatomic, retain) NSNumber * num;

+ (NSFetchedResultsController *)sharedFetchedResultsController;

+ (void)releaseFetchedResultsController;

@end
