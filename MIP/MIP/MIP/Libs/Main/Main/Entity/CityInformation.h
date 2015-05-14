//
//  CityInformation.h
//  MIP
//
//  Created by lixiangai on 14-1-7.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CityInformation : NSManagedObject

@property (nonatomic, retain) NSString * citydesc;
@property (nonatomic, retain) NSString * cityId;
@property (nonatomic, retain) NSString * cityname;
@property (nonatomic, retain) NSString * scale;
@property (nonatomic, retain) NSString * cityState;

@end
