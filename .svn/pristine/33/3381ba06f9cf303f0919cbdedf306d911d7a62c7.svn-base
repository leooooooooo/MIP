//
//  ComContactsInfo.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ComContactsInfo : NSManagedObject

@property (nonatomic, retain) NSString * company;               //公司名
@property (nonatomic, retain) NSString * department;            //部门名
@property (nonatomic, retain) NSString * duties;                //岗位名
@property (nonatomic, retain) NSString * tel;                   //电话
@property (nonatomic, retain) NSString * num;                   //排序

+ (NSFetchedResultsController *)sharedFetchedResultsController;

+ (void)releaseFetchedResultsController;

@end
