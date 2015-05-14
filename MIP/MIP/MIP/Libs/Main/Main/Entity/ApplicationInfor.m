//
//  ApplicationInfor.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/19.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ApplicationInfor.h"
#import "ApplicationType.h"


@implementation ApplicationInfor

static NSFetchedResultsController *fetchCtrl = nil;

@dynamic appCode;
@dynamic appIcon;
@dynamic appId;
@dynamic appName;
@dynamic attachUrl;
@dynamic createTime;
@dynamic isChecked;
@dynamic sn;
@dynamic version;
@dynamic applitype;
@dynamic iconUrl;
@dynamic urlType;

+ (NSFetchedResultsController *)fetchedResultsController {
    
    if (!fetchCtrl) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([ApplicationInfor class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        [fetchRequest setFetchBatchSize:20];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isChecked == %@", [NSNumber numberWithBool:YES]];
        [fetchRequest setPredicate:predicate];
        
        NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sn" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
        
        [authorDescriptor release];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        [sortDescriptors release];
        
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

@end
