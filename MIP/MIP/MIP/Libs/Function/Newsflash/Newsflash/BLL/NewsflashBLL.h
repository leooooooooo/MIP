//
//  NewsflashBLL.h
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsflashEntity;

@interface NewsflashBLL : NSObject

+(BOOL)getNewsflashEntity:(NSData *)data withParentEntity:(NewsflashEntity *)parentEntity;

+(BOOL)getTodaySecurity:(NSData *)data;

+(BOOL)getSecurityDaily:(NSData *)data;

+(NSDictionary *)getSecurityDailyDetail:(NSData *)data;

+(BOOL)setSecurityDailyReadState:(NSString *)dailyId;

@end
