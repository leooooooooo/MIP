//
//  SignHistoryList.m
//  Main
//
//  Created by lu_sicong on 2014/03/14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "SignHistoryInfo.h"

static NSFetchedResultsController *signFetchCtrl = nil;

@implementation SignHistoryInfo

@dynamic location;
@dynamic signId;
@dynamic signTime;
@dynamic userId;

+ (NSFetchedResultsController *)signFetchedResultsController
{
    if (signFetchCtrl == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
//        Userinfo *userinfo = [Userinfo shareUserinfo];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@ && signTime like %@",userinfo.uid, tmpDateStr];
//        [fetchRequest setPredicate:predicate];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"signTime" ascending:NO];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [sortDescriptor release];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        [sortDescriptors release];
        
        // Create and initialize the fetch results controller.
        signFetchCtrl = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
        
        [fetchRequest release];
    }
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *tmpDateStr = [dateFormatter stringFromDate:[NSDate date]];
    tmpDateStr = [tmpDateStr stringByAppendingString:@"*"];
    
    Userinfo *userinfo = [Userinfo shareUserinfo];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@ && signTime like %@",userinfo.uid, tmpDateStr];
    [signFetchCtrl.fetchRequest setPredicate:predicate];

    return signFetchCtrl;
}


+ (void)releasenetworkChanneResultsController
{
    
    [signFetchCtrl release];
    signFetchCtrl = nil;
}

@end
