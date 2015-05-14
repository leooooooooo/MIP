//
//  CommonlyUsedToolParser.m
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-27.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "CommonlyUsedToolParser.h"

#import "WebSiteEntity.h"

#import "NoteEntity.h"

@implementation CommonlyUsedToolParser
+(BOOL)isExsitWebSiteCategory:(NSString *)categoryName{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([WebSiteCategory class]) inManagedObjectContext:context];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && name == %@",[Userinfo shareUserinfo].uid,categoryName];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (isValid(results) && !error) {
        
        if (results.count == 1) {
            
            return YES;
        }
        else {
            
            return NO;
        }
    }
    
    return NO;
}
+(BOOL)saveWebSiteCategory:(NSString *)categoryName{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([WebSiteCategory class]) inManagedObjectContext:context];
    
    WebSiteCategory *category = [[WebSiteCategory alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    category.name = categoryName;
    category.userid = [Userinfo shareUserinfo].uid;
    NSError *saveError = nil;
    [context save:&saveError];
        
    if (saveError) {
        return NO;
    }
    else {
        
        return YES;
    }
}

+(BOOL)isExsitWebSiteEntityWithName:(NSString *)entityName inCategory:(WebSiteCategory *)category{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([WebSiteEntity class]) inManagedObjectContext:context];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@ && category.userid == %@ && name == %@",category,[Userinfo shareUserinfo].uid,entityName];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (isValid(results) && !error) {
        
        if (results.count == 1) {
            
            return YES;
        }
        else {
            
            return NO;
        }
    }
    
    return NO;
}
+(BOOL)saveWebSiteEntityWithName:(NSString *)entityName andValue:(NSString *)entityValue inCategory:(WebSiteCategory *)category{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([WebSiteEntity class]) inManagedObjectContext:context];
    
    WebSiteEntity *entity = [[WebSiteEntity alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    entity.name = entityName;
    entity.url  = entityValue;
    entity.category = category;
    
    [category addRelationshipToCategoryObject:entity];
    
    [entity release];
    
    
    NSError *saveError = nil;
    [context save:&saveError];
    
    if (saveError) {
        return NO;
    }
    else {
        
        return YES;
    }
}


+(BOOL)isExsitNoteCategory:(NSString *)categoryName{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NoteCategory class]) inManagedObjectContext:context];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && name == %@",[Userinfo shareUserinfo].uid,categoryName];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (isValid(results) && !error) {
        
        if (results.count == 1) {
            
            return YES;
        }
        else {
            
            return NO;
        }
    }
    
    return NO;
}

+(BOOL)saveNoteCategory:(NSString *)categoryName{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NoteCategory class]) inManagedObjectContext:context];
    
    WebSiteCategory *category = [[WebSiteCategory alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    category.name = categoryName;
    category.userid = [Userinfo shareUserinfo].uid;
    NSError *saveError = nil;
    [context save:&saveError];
    
    if (saveError) {
        return NO;
    }
    else {
        
        return YES;
    }
}

+(BOOL)isExsitNoteEntityWithName:(NSString *)entityName inCategory:(NoteCategory *)category{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NoteEntity class]) inManagedObjectContext:context];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@ && category.userid == %@ && name == %@",category,[Userinfo shareUserinfo].uid,entityName];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (isValid(results) && !error) {
        
        if (results.count == 1) {
            
            return YES;
        }
        else {
            
            return NO;
        }
    }
    
    return NO;
}
+(BOOL)saveNoteEntityWithName:(NSString *)entityName inCategory:(NoteCategory *)category{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NoteEntity class]) inManagedObjectContext:context];
    
    NoteEntity *entity = [[NoteEntity alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    entity.name = entityName;
    entity.category = category;
    
    [category addRelationshipToCategoryObject:entity];
    
    [entity release];
    
    
    NSError *saveError = nil;
    [context save:&saveError];
    
    if (saveError) {
        return NO;
    }
    else {
        
        return YES;
    }
}


@end
