//
//  SecurityDailyInfo.h
//  Newsflash
//
//  Created by lu_sicong on 2014/04/24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SecurityDailyInfo : NSManagedObject

@property (nonatomic, retain) NSString * dailyId;
@property (nonatomic, retain) NSString * dailyName;
@property (nonatomic, retain) NSString * regDate;
@property (nonatomic, retain) NSString * typeId;
@property (nonatomic, retain) NSString * typeName;
@property (nonatomic, retain) NSNumber * readType;

@end
