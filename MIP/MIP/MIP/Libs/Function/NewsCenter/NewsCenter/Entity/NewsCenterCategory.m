//
//  NewsCenterCategory.m
//  MIP
//
//  Created by wanghao on 14-3-14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "NewsCenterCategory.h"
#import "NewsCenterDocument.h"

//static NSFetchedResultsController *categoryResultsController = nil;

@implementation NewsCenterCategory

@dynamic code;
@dynamic filters;
@dynamic flowType;
@dynamic searchType;
@dynamic sort;
@dynamic title;
@dynamic uid;
@dynamic unreadCount;
@dynamic userid;
@dynamic relationshipToNewsCategory;

@synthesize keyword;
@synthesize typeID;
@synthesize fetchedResultsController;
@synthesize funcdes;

@synthesize newsType;

+ (NSFetchedResultsController *)newsCenterCategoryResultsController{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[DataManager shareDataManager] managedObjectContext]];
    
    [fetchRequest setEntity:entity];
    
    Userinfo *userinfo = [Userinfo shareUserinfo];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && code != %@",userinfo.uid,@"TZGG"];
    [fetchRequest setPredicate:predicate];
    
    // Create the sort descriptors array.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sort" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [sortDescriptor release];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [sortDescriptors release];
    
    // Create and initialize the fetch results controller.
    NSFetchedResultsController *categoryResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager shareDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    [fetchRequest release];
    
    return categoryResultsController;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (!fetchedResultsController) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"newsCenterCategory.userid == %@ && newsCenterCategory.uid == %@ && type == %@",[Userinfo shareUserinfo].uid,self.uid,[NSNumber numberWithInt:self.newsType]];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterDocument class]) inManagedObjectContext:self.managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        [fetchRequest setPredicate:predicate];
        
        [fetchRequest setFetchBatchSize:20];
        
        NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"generateDate" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:authorDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    
    return fetchedResultsController;
}

+ (void)releaseNewsCenterCategoryResultsController {
    
//    [categoryResultsController release];
}


- (void)setKeyword:(NSString *)nKeyword {
    
    NSString *validKeyword = [nKeyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NetworkStatus status = [[SystemInfo shareSystemInfo] currentNetworkStatus];
    
    NSPredicate *predicate = nil;
    
    if (status == NotReachable) {
        
        if (!nKeyword || [validKeyword isEqualToString:@""]) {
            
            //无keyword
            predicate = [NSPredicate predicateWithFormat:@"newsCenterCategory.userid == %@ && newsCenterCategory.uid == %@ && type == %@",[Userinfo shareUserinfo].uid,self.uid,[NSNumber numberWithInt:self.newsType]];
            
        }
        else {
            
            predicate = [NSPredicate predicateWithFormat:@"newsCenterCategory.userid == %@ && newsCenterCategory.uid == %@ && type == %@ && title contains[cd] %@",[Userinfo shareUserinfo].uid,self.uid,[NSNumber numberWithInt:self.newsType],nKeyword];
        }
    }
    else {
        
        NSString *validKeyword = [nKeyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (!nKeyword || [validKeyword isEqualToString:@""]) {
            
            //无keyword
            predicate = [NSPredicate predicateWithFormat:@"newsCenterCategory.userid == %@ && newsCenterCategory.uid == %@ && type == %@",[Userinfo shareUserinfo].uid,self.uid,[NSNumber numberWithInt:self.newsType]];
        }
        else {
            
            predicate = [NSPredicate predicateWithFormat:@"newsCenterCategory.userid == %@ && newsCenterCategory.uid == %@ && type == %@ && onlineKeyword == %@",[Userinfo shareUserinfo].uid,self.uid,[NSNumber numberWithInt:self.newsType],nKeyword];
            
        }
    }
    
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    
    [keyword release];
    
    keyword = [nKeyword retain];
    
}

- (void)setNewsType:(NewsType)aNewsType {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"newsCenterCategory.userid == %@ && newsCenterCategory.uid == %@ && type == %@",[Userinfo shareUserinfo].uid,self.uid,[NSNumber numberWithInt:aNewsType]];
    
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    newsType = aNewsType;
}

- (void)setTypeID:(NSString *)aTypeID{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"newsCenterCategory.userid == %@ && newsCenterCategory.uid == %@ && type == %@ && typeID == %@",[Userinfo shareUserinfo].uid,self.uid,[NSNumber numberWithInt:newsType],aTypeID];
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    typeID = aTypeID;
}
@end
