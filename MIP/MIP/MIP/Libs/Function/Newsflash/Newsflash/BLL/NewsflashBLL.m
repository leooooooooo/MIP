//
//  NewsflashBLL.m
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "NewsflashBLL.h"

#import "NewsflashParser.h"

#import "NewsflashEntity.h"

#import "SecurityDailyInfo.h"

@implementation NewsflashBLL
+(BOOL)getNewsflashEntity:(NSData *)data withParentEntity:(NewsflashEntity *)parentEntity{
    return [NewsflashParser getNewsflashEntity:data withParentEntity:parentEntity];
}

+(BOOL)getTodaySecurity:(NSData *)data{
    return [NewsflashParser getTodaySecurity:data];
}

+(BOOL)getSecurityDaily:(NSData *)data{
    return [NewsflashParser getSecurityDailyList:data];
}

+(NSDictionary *)getSecurityDailyDetail:(NSData *)data{
    return [NewsflashParser getSecurityDailyDetail:data];
}

+(BOOL)setSecurityDailyReadState:(NSString *)dailyId
{
    if (!dailyId) {
        return NO;
    }
    
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([SecurityDailyInfo class]) inManagedObjectContext:context];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dailyId == %@",dailyId];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if ([results count] == 0) {
        return NO;
    }
    
    SecurityDailyInfo *entity = [results firstObject];
    
    entity.readType = [NSNumber numberWithBool:Readed];
    
    return [context save:NULL];
}

@end
