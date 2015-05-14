//
//  LowCPortDataParser.m
//  LCHarbour
//
//  Created by lu_sicong on 2014/04/25.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "LowCPortDataParser.h"
#import "NSDictionary+CustomExtensions.h"
#import "JSON.h"
#import "LowCPortMenuInfo.h"

@implementation LowCPortDataParser

+ (BOOL)parserEngSuperviseList:(NSData *)data
{
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        NSDictionary *bizdata = [bodyDictionary dataForKey:@"bizdata"];
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata))
        {
            
            NSArray *dataArr = [bizdata dataArrForKey:@"webitems"];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] newManageContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([LowCPortMenuInfo class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            NSArray *_results = [context executeFetchRequest:request error:&error];
            if (isValid(_results) && !error)
            {
                for(LowCPortMenuInfo *temp in _results)
               {
                 [context deleteObject:temp];
               }
            }
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *menuId = [itemDic objectForKeyWithOutCaps:@"id"];
                
                if (isValid(menuId))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"menuId == %@", menuId];
                    
                    [request setPredicate:predicate];
                }
                
                LowCPortMenuInfo *lowCPortMenuInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        lowCPortMenuInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        lowCPortMenuInfo = [[LowCPortMenuInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        lowCPortMenuInfo.menuId = menuId;
                    }
                    
                    NSString *menuName = [itemDic objectForKeyWithOutCaps:@"name"];
                    if (isValid(menuName)) {
                        lowCPortMenuInfo.menuName = menuName;
                    }
                    
                    NSString *sort = [itemDic objectForKeyWithOutCaps:@"sort"];
                    if (isValid(sort)) {
                        lowCPortMenuInfo.sort = sort;
                    }
                    
                    NSString *url = [itemDic objectForKeyWithOutCaps:@"url"];
                    if (isValid(url)) {
                        lowCPortMenuInfo.url = url;
                    }
                    
                    lowCPortMenuInfo.userId = [Userinfo shareUserinfo].uid;
                }
                
                [lowCPortMenuInfo release];
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
    
    return YES;
    
}

@end
