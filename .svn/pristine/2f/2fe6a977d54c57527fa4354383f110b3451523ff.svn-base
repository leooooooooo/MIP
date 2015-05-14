//
//  NoteCategory.h
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-28.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSSet *relationshipToCategory;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

+ (NSFetchedResultsController *)categoryResultsController;

@end

@interface NoteCategory (CoreDataGeneratedAccessors)

- (void)addRelationshipToCategoryObject:(NSManagedObject *)value;
- (void)removeRelationshipToCategoryObject:(NSManagedObject *)value;
- (void)addRelationshipToCategory:(NSSet *)values;
- (void)removeRelationshipToCategory:(NSSet *)values;

@end
