//
//  ApplicationType.h
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/18.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ApplicationInfor;

@interface ApplicationType : NSManagedObject

@property (nonatomic, retain) NSString * appNum;
@property (nonatomic, retain) NSString * appType;
@property (nonatomic, retain) NSString * appTypeName;
@property (nonatomic, retain) NSSet *appliinfor;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end

@interface ApplicationType (CoreDataGeneratedAccessors)

- (void)addAppliinforObject:(ApplicationInfor *)value;
- (void)removeAppliinforObject:(ApplicationInfor *)value;
- (void)addAppliinfor:(NSSet *)values;
- (void)removeAppliinfor:(NSSet *)values;

+ (NSFetchedResultsController *)fetchedResultsController;
+ (void)releasenetworkChanneResultsController;

@end
