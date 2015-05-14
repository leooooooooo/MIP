//
//  NewsflashCategory.h
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum{
    Readed = 0,
    Unreaded = 1,
}readType;

@interface NewsflashEntity : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * parentuid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * sort;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSNumber * readType;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

+ (NSFetchedResultsController *)newsflashFfetchedResultsController;

@end
