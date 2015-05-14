//
//  OperDeviceDataParser.m
//  OperDevice
//
//  Created by lu_sicong on 2014/04/25.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "OperDeviceDataParser.h"
#import "NSDictionary+CustomExtensions.h"
#import "JSON.h"
#import "OperDeviceMenuInfo.h"

@implementation OperDeviceDataParser

+ (BOOL)parserOperDeviceList:(NSData *)data
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
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([OperDeviceMenuInfo class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *menuId = [itemDic objectForKeyWithOutCaps:@"id"];
                
                if (isValid(menuId))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"menuId == %@", menuId];
                    
                    [request setPredicate:predicate];
                }
                
                OperDeviceMenuInfo *operDeviceMenuInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        operDeviceMenuInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        operDeviceMenuInfo = [[OperDeviceMenuInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        operDeviceMenuInfo.menuId = menuId;
                    }
                    
                    NSString *menuName = [itemDic objectForKeyWithOutCaps:@"name"];
                    if (isValid(menuName)) {
                        operDeviceMenuInfo.menuName = menuName;
                    }
                    
                    NSString *sort = [itemDic objectForKeyWithOutCaps:@"sort"];
                    if (isValid(sort)) {
                        operDeviceMenuInfo.sort = sort;
                    }
                    
                    NSString *url = [itemDic objectForKeyWithOutCaps:@"url"];
                    if (isValid(url)) {
                        operDeviceMenuInfo.url = url;
                    }
                    
                    operDeviceMenuInfo.userId = [Userinfo shareUserinfo].uid;
                }
                
                [operDeviceMenuInfo release];
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
