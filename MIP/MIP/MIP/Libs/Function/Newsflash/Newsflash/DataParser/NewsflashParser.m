//
//  NewsflashParser.m
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "NewsflashParser.h"

#import "NewsflashEntity.h"
#import "SecurityDailyInfo.h"

#import "NSDictionary+CustomExtensions.h"

@implementation NewsflashParser
+(BOOL)getTodaySecurity:(NSData *)data{
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        if (isValid(ret)) {
            
            if (![ret isEqualToString:@"0"]) {
                
                return NO;
            }
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
            
        }
        
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata objectForKey:@"data"];
            
            if (isValid(dataArr) && [dataArr count] > 0)
            {
                NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsflashEntity class]) inManagedObjectContext:context];
                
                //先查询用户的公文流转栏目列表的历史记录
                NSFetchRequest *request=[[NSFetchRequest alloc] init];
                
                [request setEntity:entityDescription];
                
                for (NSDictionary *itemDic in dataArr)
                {
                    if (![itemDic.allKeys containsObject:@"funcname"]) {
                        continue;
                    }
                    
                    NSString *name = [itemDic objectForKey:@"funcname"];
                    
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && name == %@",[Userinfo shareUserinfo].uid, name];
                    
                    [request setPredicate:predicate];
                    
                    NSError *error = nil;
                    
                    NSArray *results = [context executeFetchRequest:request error:&error];
                    
                    NewsflashEntity *entity = nil;
                    
                    if (isValid(results) && !error) {
                        
                        if (results.count == 1) {//如果有原来记录,则直接使用原coreData对象
                            
                            entity = [[results objectAtIndex:0] retain];
                            
                        }
                        else {
                            //如果没有记录则新建记录
                            entity = [[NewsflashEntity alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                            
                            entity.readType = [NSNumber numberWithInt:Unreaded];
                        }
                        
                        entity.userid = [Userinfo shareUserinfo].uid;
                        entity.name = [NSString stringWithFormat:@"%@",name];
                        entity.sort = [NSNumber numberWithInt:0];
                        
                        [entity release];
                    }
                }
                
                [request release];
                
                return YES;
            }
        }
    }
    
    return NO;

}

+(BOOL)getSecurityDailyList:(NSData *)data{
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        if (isValid(ret)) {
            
            if (![ret isEqualToString:@"0"]) {
                
                return NO;
            }
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
            
        }
        
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata objectForKey:@"data"];
            
            if (isValid(dataArr) && [dataArr count] > 0)
            {
                NSDictionary *newsResult = [dataArr firstObject];
                
                NSDictionary *newsListResult = [newsResult objectForKey:@"newstitles"];
                
                NSArray *newsList = [newsListResult objectForKey:@"data"];
                
                if (isValid(newsList) && [newsList count] > 0) {
                    
                    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                    
                    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([SecurityDailyInfo class]) inManagedObjectContext:context];
                    
                    //先查询用户的公文流转栏目列表的历史记录
                    NSFetchRequest *request=[[NSFetchRequest alloc] init];
                    
                    [request setEntity:entityDescription];
                    
                    for (NSDictionary *itemDic in newsList)
                    {
                        if (![itemDic.allKeys containsObject:@"id"]) {
                            continue;
                        }
                        
                        NSString *dailyId = [itemDic objectForKey:@"id"];
                        
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dailyId == %@", dailyId];
                        
                        [request setPredicate:predicate];
                        
                        NSError *error = nil;
                        
                        NSArray *results = [context executeFetchRequest:request error:&error];
                        
                        SecurityDailyInfo *entity = nil;
                        
                        if (isValid(results) && !error) {
                            
                            if (results.count == 1) {//如果有原来记录,则直接使用原coreData对象
                                
                                entity = [[results objectAtIndex:0] retain];
                                entity.readType=[NSNumber numberWithInt:[[itemDic objectForKey:@"newmark"] intValue]];
                            }
                            else {
                                //如果没有记录则新建记录
                                entity = [[SecurityDailyInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                
                                entity.dailyId = [NSString stringWithFormat:@"%@",dailyId];
                            }
                            NSString *newmark = [itemDic objectForKey:@"newmark"];
                            if (isValid(newmark)) {
                                entity.readType = [NSNumber numberWithInt:[newmark intValue]];
                            }
                            
                            
                            NSString *dailyName = [itemDic objectForKey:@"name"];
                            if (isValid(dailyName)) {
                                entity.dailyName = [NSString stringWithFormat:@"%@",dailyName];
                            }
                            
                            NSString *regDate = [itemDic objectForKey:@"regdate"];
                            if (isValid(regDate)) {
                                entity.regDate = [NSString stringWithFormat:@"%@",regDate];
                            }
                            
                            NSString *typeId = [itemDic objectForKey:@"typeid"];
                            if (isValid(typeId)) {
                                entity.typeId = [NSString stringWithFormat:@"%@",typeId];
                            }
                            
                            NSString *typeName = [itemDic objectForKey:@"typename"];
                            if (isValid(typeName)) {
                                entity.typeName = [NSString stringWithFormat:@"%@",typeName];
                            }
                            
                            [entity release];
                        }
                    }
                    
                    [request release];
                    
                    NSError *error = nil;
                    
                    BOOL result = [context save:&error];
                    
                    if (!result) {
                        
                        DLog(@"%@",error);
                    }
                    else {
                        
                        return YES;
                    }
                    
                }
            }
        }
    }
    
    return NO;
    
}

+(BOOL)getNewsflashEntity:(NSData *)data withParentEntity:(NewsflashEntity *)parentEntity{
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        if (isValid(ret)) {
            
            if (![ret isEqualToString:@"0"]) {
                
                return NO;
            }
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
            
        }
        
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata objectForKey:@"data"];
            
            if (isValid(dataArr) && [dataArr count] > 0)
            {
                NSDictionary *dataDic = [dataArr objectAtIndex:0];
                if (isValid(dataDic) && [dataDic isKindOfClass:[NSDictionary class]] && [[dataDic allKeys] containsObject:@"webitems"]) {
                    
                    //解析用户的公文流转栏目列表
                    
                    NSDictionary *webitemsDic = [dataDic objectForKey:@"webitems"];
                    
                    if (isValid(webitemsDic) && [webitemsDic isKindOfClass:[NSDictionary class]] && [[webitemsDic allKeys] containsObject:@"data"])
                    {
                        NSArray *itemList = [webitemsDic objectForKey:@"data"];
                        
                        if (isValid(itemList)) {
                            
                            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                            
                            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsflashEntity class]) inManagedObjectContext:context];
                            
                            //先查询用户的公文流转栏目列表的历史记录
                            NSFetchRequest *request=[[NSFetchRequest alloc] init];
                            
                            [request setEntity:entityDescription];
                            
                            for (NSDictionary *itemDic in itemList)
                            {
                                
                                NSString *messageItemGuid = [itemDic objectForKey:@"id"];
                                
                                if (isValid(messageItemGuid)) {
                                    
                                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && uid == %@",[Userinfo shareUserinfo].uid,messageItemGuid];
                                    
                                    [request setPredicate:predicate];
                                    
                                    NSError *error = nil;
                                    
                                    NSArray *results = [context executeFetchRequest:request error:&error];
                                    
                                    NewsflashEntity *entity = nil;
                                    
                                    if (isValid(results) && !error) {
                                        
                                        if (results.count == 1) {//如果有原来记录,则直接使用原coreData对象
                                            
                                            entity = [[results objectAtIndex:0] retain];
                                            
                                        }
                                        else {
                                            //如果没有记录则新建记录
                                            entity = [[NewsflashEntity alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                            
                                            entity.readType = [NSNumber numberWithInt:Unreaded];
                                        }
                                    }
                                    entity.userid = [Userinfo shareUserinfo].uid;
                                    entity.uid = [NSString stringWithFormat:@"%@",messageItemGuid];
                                    entity.parentuid = parentEntity.uid;
                                    
                                    NSString *title = [itemDic objectForKey:@"name"];
                                    if (isValid(title)) {
                                        entity.name = title;
                                    }
                                    
                                    NSString *sort = [itemDic objectForKey:@"sort"];
                                    if (isValid(sort)) {
                                        entity.sort = [NSNumber numberWithInt:(int)[sort integerValue]];
                                    }
                                    
                                    NSString *url = [itemDic objectForKey:@"url"];
                                    if (isValid(url)) {
                                        entity.url = url;
                                    }
                                    
                                    [entity release];
                                    
                                }
                            }
                            
                            [request release];
                            
                            NSError *error = nil;
                            
                            BOOL result = [context save:&error];
                            
                            if (!result) {
                                
                                DLog(@"%@",error);
                            }
                            else {
                                
                                return YES;
                            }
                        }
                    }
                }
            }
        }
    }
    
    return NO;
    
}

+(NSDictionary *)getSecurityDailyDetail:(NSData *)data
{
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        if (isValid(ret)) {
            
            if (![ret isEqualToString:@"0"]) {
                
                return NO;
            }
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
            
        }
        
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata objectForKey:@"data"];
            
            if (isValid(dataArr) && [dataArr count] > 0)
            {
                NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
                
                NSDictionary *newsResult = [dataArr firstObject];
                
                NSArray *urlList = [newsResult dataArrForKey:@"attachmenturls"];
                
                NSMutableArray *urls = [[NSMutableArray alloc] init];
                
                if (isValid(urlList) && [urlList count] > 0) {
                    
                    for (NSDictionary *itemDic in urlList)
                    {
                        if (![itemDic.allKeys containsObject:@"url"]) {
                            continue;
                        }
                        
                        NSString *url = [itemDic objectForKey:@"url"];
                        
                        [urls addObject:url];
                        
                    }
                }
                
                [resultDic setObject:urls forKey:@"urlList"];
                
                NSString *author = [newsResult objectForKey:@"author"];
                
                [resultDic setObject:author forKey:@"author"];
                
                NSString *content = [newsResult objectForKey:@"content"];
                
                [resultDic setObject:content forKey:@"content"];
                
                NSString *displaytype = [newsResult objectForKey:@"displaytype"];
                
                [resultDic setObject:displaytype forKey:@"displaytype"];
                
                NSString *dailyId = [newsResult objectForKey:@"id"];
                
                [resultDic setObject:dailyId forKey:@"dailyId"];
                
                NSString *source = [newsResult objectForKey:@"source"];
                
                [resultDic setObject:source forKey:@"source"];
                
                return [resultDic autorelease];
            }
        }
    }
    
    return nil;
    
}

@end
