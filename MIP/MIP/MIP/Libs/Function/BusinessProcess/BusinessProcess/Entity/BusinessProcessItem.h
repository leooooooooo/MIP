//
//  BusinessProcessItem.h
//  BusinessProcess
//
//  Created by wanghao on 14-3-14.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BusinessProcessItem : NSManagedObject

@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSDate * generateDate;
@property (nonatomic, retain) NSString * initiator;
@property (nonatomic, retain) NSDate * modifyDate;
@property (nonatomic, retain) NSString * onlineKeyword;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSManagedObject *relationship;

@end
