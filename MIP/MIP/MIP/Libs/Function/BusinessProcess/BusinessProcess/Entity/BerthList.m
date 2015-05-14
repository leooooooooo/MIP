//
//  BerthList.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/09.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BerthList.h"


@implementation BerthList

static NSFetchedResultsController *fetchCtrl = nil;

@dynamic berthId;
@dynamic berthNo;
@dynamic deptCode;
@dynamic department;

+ (NSFetchedResultsController *)sharedFetchedResultsController
{
    if (fetchCtrl == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        // Create the sort descriptors array.
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: nil];
        
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
