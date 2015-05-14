//
//  NewsflashParser.h
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsflashEntity;

@interface NewsflashParser : NSObject
+(BOOL)getTodaySecurity:(NSData *)data;
+(BOOL)getSecurityDailyList:(NSData *)data;
+(BOOL)getNewsflashEntity:(NSData *)data withParentEntity:(NewsflashEntity *)parentEntity;
+(NSDictionary *)getSecurityDailyDetail:(NSData *)data;


@end
