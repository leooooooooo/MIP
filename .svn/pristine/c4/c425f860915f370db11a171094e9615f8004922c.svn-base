//
//  ShipInfo.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/03.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ShipInfo.h"
#import "BusinessType.h"


@implementation ShipInfo

static NSFetchedResultsController *fetchCtrl = nil;

@dynamic berthid;
@dynamic berthname;
@dynamic jobcompanyid;
@dynamic jobcompanyname;
@dynamic shipid;
@dynamic shipnamecn;
@dynamic unloadcargoid;
@dynamic unloadcargoname;
@dynamic unloadweight;
@dynamic loadcargoid;
@dynamic loadcargoname;
@dynamic loadweight;
@dynamic arriveanchortime;
@dynamic shipclientid;
@dynamic shipclientname;
@dynamic leadmarkid;
@dynamic leadmarkname;
@dynamic planmarkid;
@dynamic planmarkname;
@dynamic planinporttime;
@dynamic planoutporttime;
@dynamic planmoveberthtime;
@dynamic planmoveberthno;
@dynamic createDate;
@dynamic processType;


+ (NSFetchedResultsController *)sharedFetchedResultsController
{
    if (fetchCtrl == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"arriveanchortime" ascending:NO];
        
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
