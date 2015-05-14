//
//  BusinessProcessCategory.h
//  BusinessProcess
//
//  Created by wanghao on 14-3-14.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusinessProcessItem;

@interface BusinessProcessCategory : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * filters;
@property (nonatomic, retain) NSNumber * flowType;
@property (nonatomic, retain) NSNumber * searchType;
@property (nonatomic, retain) NSNumber * sort;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * unreadCount;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSSet *relationshipToBusinessProcessCategory;
@end

@interface BusinessProcessCategory (CoreDataGeneratedAccessors)

- (void)addRelationshipToBusinessProcessCategoryObject:(BusinessProcessItem *)value;
- (void)removeRelationshipToBusinessProcessCategoryObject:(BusinessProcessItem *)value;
- (void)addRelationshipToBusinessProcessCategory:(NSSet *)values;
- (void)removeRelationshipToBusinessProcessCategory:(NSSet *)values;

@end
