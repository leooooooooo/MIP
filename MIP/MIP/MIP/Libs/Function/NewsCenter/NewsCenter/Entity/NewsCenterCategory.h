//
//  NewsCenterCategory.h
//  MIP
//
//  Created by wanghao on 14-3-14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
typedef enum{
    HOT_NEWS = 0,
    ALL_NEWS = 1,
    OTHERS   = 2,
}NewsType;

@interface NewsCenterCategory : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * filters;
@property (nonatomic, retain) NSNumber * flowType;
@property (nonatomic, retain) NSNumber * searchType;
@property (nonatomic, retain) NSNumber * sort;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * unreadCount;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSSet *relationshipToNewsCategory;

@property (nonatomic, retain) NSString              *keyword;//关键字;当前栏目搜索的关键字
@property (nonatomic, retain) NSString              *typeID;//关键字;当前栏目搜索的关键字
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, assign) NewsType  newsType;

@property (nonatomic, retain) NSString              *funcdes;//功能描述信息
+ (NSFetchedResultsController *)newsCenterCategoryResultsController;
+ (void)releaseNewsCenterCategoryResultsController;

@end


@interface NewsCenterCategory (CoreDataGeneratedAccessors)

- (void)addRelationshipToNewsCategoryObject:(NSManagedObject *)value;
- (void)removeRelationshipToNewsCategoryObject:(NSManagedObject *)value;
- (void)addRelationshipToNewsCategory:(NSSet *)values;
- (void)removeRelationshipToNewsCategory:(NSSet *)values;

@end
