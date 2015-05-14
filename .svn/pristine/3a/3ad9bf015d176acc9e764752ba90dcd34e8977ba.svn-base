//
//  NewsflashCategory.m
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "NewsflashEntity.h"
#import "SecurityDailyInfo.h"

static NSFetchedResultsController *categoryResultsController = nil;

@implementation NewsflashEntity

@dynamic uid;
@dynamic parentuid;
@dynamic name;
@dynamic sort;
@dynamic url;
@dynamic userid;
@dynamic readType;


@synthesize fetchedResultsController;

+ (NSFetchedResultsController *)newsflashFfetchedResultsController {
    
    if (categoryResultsController == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        Userinfo *userinfo = [Userinfo shareUserinfo];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && parentuid == nil",userinfo.uid];
        [fetchRequest setPredicate:predicate];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sort" ascending:YES];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [sortDescriptor release];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        [sortDescriptors release];
        
        // Create and initialize the fetch results controller.
        categoryResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
        
        [fetchRequest release];
    }
    
    return categoryResultsController;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (!fetchedResultsController) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(SecurityDailyInfo.class) inManagedObjectContext:self.managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        [fetchRequest setFetchBatchSize:20];
        
        NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"regDate" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    
    return fetchedResultsController;
}

@end
