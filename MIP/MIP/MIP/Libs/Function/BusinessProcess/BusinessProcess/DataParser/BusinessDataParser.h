//
//  BusinessDataParser.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/01.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BusinessType;

@interface BusinessDataParser : NSObject

+ (BOOL) parseBusinessTypeList : (NSData *) data;

+ (BOOL) parseLargeCommList:(NSData *)data withShip :(BOOL) withShip;

+ (BOOL) parseShipInfoList:(NSData *)data withType : (BusinessType *)type;

+ (BOOL) parseBerthInfoList:(NSData *)data;

+ (BOOL) parseBerthPosInfoList:(NSData *)data;

+ (BOOL) parseJobCompanyList:(NSData *)data;

+ (NSDictionary *) parseShipInfoDetail:(NSData *)data;

@end
