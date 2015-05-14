//
//  NewsCenterPDF.h
//  MIP
//
//  Created by kangqijun on 14-3-18.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsCenterPDF : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * filePath;

@end
