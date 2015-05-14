//
//  MessageClassInfo.m
//  Main
//
//  Created by lu_sicong on 2014/05/09.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "MessageClassInfo.h"


@implementation MessageClassInfo

static NSFetchedResultsController *_fetchCtrl = nil;

@dynamic messageId;
@dynamic title;
@dynamic msgClassName;
@dynamic postTime;
@dynamic msgClassId;
@dynamic userId;

+ (NSFetchedResultsController *)sharedFetchedResultsController
{
    if (_fetchCtrl == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"msgClassName" ascending:YES];
        
        NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"postTime" ascending:NO];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, timeSortDescriptor, nil];
        
        [sortDescriptor release];
        
        [timeSortDescriptor release];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        [sortDescriptors release];
        
        // Create and initialize the fetch results controller.
        _fetchCtrl = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:@"msgClassName" cacheName:nil];
        
        [fetchRequest release];
    }
    
    Userinfo *userinfo = [Userinfo shareUserinfo];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@",userinfo.uid];
    [_fetchCtrl.fetchRequest setPredicate:predicate];
    
    return _fetchCtrl;
}


+ (void)releaseFetchedResultsController
{
    [_fetchCtrl release];
    _fetchCtrl = nil;
}

@end
