//
//  PerContactsInfo.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "PerContactsInfo.h"


@implementation PerContactsInfo

static NSFetchedResultsController *fetchCtrl = nil;

@dynamic companyid;
@dynamic companyname;
@dynamic name;
@dynamic tel;
@dynamic email;
@dynamic userid;
@dynamic departmentid;
@dynamic departmentname;
@dynamic duty;
@dynamic baktel;
@dynamic officetel;
@dynamic bakofficetel;
@dynamic peremail;
@dynamic headpicurl;
@dynamic markweibo;
@dynamic num;

+ (NSFetchedResultsController *)sharedFetchedResultsController
{
    if (fetchCtrl == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        Userinfo *userinfo = [Userinfo shareUserinfo];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"companyid == %@",userinfo.companyid];
        [fetchRequest setPredicate:predicate];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"num" ascending:YES];
        
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
