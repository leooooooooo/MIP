//
//  MyAppCenterHandle.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/19.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "MyAppCenterHandle.h"
#import "ApplicationInfor.h"
#import "ApplicationType.h"

@implementation MyAppCenterHandle

- (BOOL) setAppliMyDesktopState : (BOOL) isChecked atAppId : (NSString *)appId
{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ApplicationInfor class]) inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appId == %@",appId];
    
    [request setPredicate:predicate];
    
    ApplicationInfor *appInfo = nil;
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    BOOL result = NO;
    
    if (results && [results count] > 0) {
        
        appInfo = [[results objectAtIndex:0] retain];
        
        appInfo.isChecked = [NSNumber numberWithBool:isChecked];
        
        result = [context save:&error];
    }
    
    [request release];
    
    if (error || !result) {
        DLog(@"%@",error);
    }
    
    if (result) {
        return YES;
    }
    
    return NO;
}

@end
