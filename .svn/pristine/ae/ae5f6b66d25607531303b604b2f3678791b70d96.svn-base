//
//  DataManager.h
//  MIP
//
//  Created by Sea on 13-9-17.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSManagedObjectContext *)managedObjectContext;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (DataManager *)shareDataManager;

+ (void)releaseDataManager;
-(NSManagedObjectContext*)newManageContext;
@end
