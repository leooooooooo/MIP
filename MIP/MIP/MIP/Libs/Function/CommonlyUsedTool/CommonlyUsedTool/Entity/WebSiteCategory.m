//
//  WebSiteCategory.m
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-26.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "WebSiteCategory.h"
#import "WebSiteEntity.h"


static NSFetchedResultsController *categoryResultsController = nil;

@implementation WebSiteCategory

@dynamic userid;
@dynamic name;
@dynamic relationshipToCategory;

@synthesize fetchedResultsController;

+ (NSFetchedResultsController *)categoryResultsController{
    if (categoryResultsController == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
        
        [fetchRequest setEntity:entity];
        
        Userinfo *userinfo = [Userinfo shareUserinfo];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@",userinfo.uid];
        [fetchRequest setPredicate:predicate];
        
        // Create the sort descriptors array.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        
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
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@",self];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([WebSiteEntity class]) inManagedObjectContext:self.managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        [fetchRequest setPredicate:predicate];
        
        [fetchRequest setFetchBatchSize:20];
        
        NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    
    return fetchedResultsController;
}

@end
