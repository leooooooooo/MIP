//
//  BusinessType.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/02.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessType.h"
#import "ShipInfo.h"


@implementation BusinessType

static NSFetchedResultsController *fetchCtrl = nil;

@dynamic hasNew;
@dynamic title;
@dynamic type;
@dynamic ships;

+ (NSFetchedResultsController *)sharedFetchedResultsController
{
    if (fetchCtrl == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"type" ascending:YES];
        
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
