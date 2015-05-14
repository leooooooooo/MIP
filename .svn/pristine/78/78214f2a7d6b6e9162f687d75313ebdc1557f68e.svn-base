//
//  LargeCommission.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/11.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "LargeCommission.h"


@implementation LargeCommission

static NSFetchedResultsController *fetchCtrl = nil;

@dynamic bcno;
@dynamic serial;
@dynamic shipid;
@dynamic shipname;
@dynamic voyage;
@dynamic jobtypeid;
@dynamic jobtypename;
@dynamic jobcompanyid;
@dynamic jobcompanyname;
@dynamic cargoid;
@dynamic cargoname;
@dynamic weight;
@dynamic shipclientid;
@dynamic shipclientname;
@dynamic applydate;
@dynamic auditmarkid;
@dynamic auditmarkname;
@dynamic withship;
@dynamic createDate;

+ (NSFetchedResultsController *)sharedFetchedResultsController
{
    if (fetchCtrl == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"applydate" ascending:NO];
        
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
