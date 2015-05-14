//
//  OperDeviceMenuInfo.m
//  OperDevice
//
//  Created by lu_sicong on 2014/04/25.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "OperDeviceMenuInfo.h"


@implementation OperDeviceMenuInfo

static NSFetchedResultsController *fetchCtrl = nil;

@dynamic menuId;
@dynamic menuName;
@dynamic sort;
@dynamic url;
@dynamic userId;

+ (NSFetchedResultsController *)sharedFetchedResultsController
{
    if (fetchCtrl == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        Userinfo *userinfo = [Userinfo shareUserinfo];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@",userinfo.uid];
        [fetchRequest setPredicate:predicate];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sort" ascending:YES];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [sortDescriptor release];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        [sortDescriptors release];
        
        // Create and initialize the fetch results controller.
        fetchCtrl = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
        
        [fetchRequest release];
    }
    
    return fetchCtrl;
}

+ (void)releaseFetchedResultsController
{
    
    [fetchCtrl release];
    fetchCtrl = nil;
}

@end
