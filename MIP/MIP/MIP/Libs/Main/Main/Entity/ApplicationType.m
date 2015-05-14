//
//  ApplicationType.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/18.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ApplicationType.h"
#import "ApplicationInfor.h"


@implementation ApplicationType

static NSFetchedResultsController *fetchCtrl = nil;

@dynamic appNum;
@dynamic appType;
@dynamic appTypeName;
@dynamic appliinfor;

@synthesize fetchedResultsController;

+ (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchCtrl == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"appType" ascending:YES];
        
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


+ (void)releasenetworkChanneResultsController
{
    
    [fetchCtrl release];
    fetchCtrl = nil;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (!fetchedResultsController) {
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([ApplicationInfor class]) inManagedObjectContext:self.managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        [fetchRequest setFetchBatchSize:20];
        
        NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sn" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
        
        [authorDescriptor release];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        [sortDescriptors release];
        
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        [fetchRequest release];
    }
    
    return fetchedResultsController;
}

@end
