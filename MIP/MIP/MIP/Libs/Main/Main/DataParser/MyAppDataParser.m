//
//  MyAppDataParser.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/18.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "MyAppDataParser.h"
#import "JSON.h"
#import "ApplicationType.h"
#import "ApplicationInfor.h"
#import "NSDictionary+CustomExtensions.h"

@implementation MyAppDataParser

+ (BOOL) parseAppList : (NSData*) data withAppType : (ApplicationType *) appType
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
        
        DLog(@"%@",bizdata);
        
        if (isValid(bizdata))
        {
            
            NSArray *dataArr = [bizdata dataArrForKey:@"apps"];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ApplicationInfor class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            /*
            for (ApplicationInfor *tmpApp in [appType.appliinfor allObjects]) {
                [appType removeAppliinforObject:tmpApp];
            }
            */
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *appId = [itemDic objectForKeyWithOutCaps:@"appId"];
                
                if (isValid(appId))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appId == %@",appId];
                    
                    [request setPredicate:predicate];
                }
                
                ApplicationInfor *appInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count == 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        appInfo = [[results objectAtIndex:0] retain];
                        
                        if (0 != [appType.appType intValue])
                        {
                            [appType addAppliinforObject:appInfo];
                        }
                        
                    }
                    else
                    {
                        appInfo = [[ApplicationInfor alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        appInfo.appId = appId;
                        appInfo.applitype = appType;
                        appInfo.isChecked = [NSNumber numberWithBool:YES];
                        
                        if (0 != [appType.appType intValue])
                        {
                            [appType addAppliinforObject:appInfo];
                        }
                    }
                    
                    NSString *appCode = [itemDic objectForKeyWithOutCaps:@"appCode"];
                    if (isValid(appCode)) {
                        appInfo.appCode = appCode;
                    }
                    
                    NSString *appName = [itemDic objectForKeyWithOutCaps:@"appName"];
                    if (isValid(appName)) {
                        appInfo.appName = appName;
                    }
                    
                    NSString *appIcon = [itemDic objectForKeyWithOutCaps:@"appIcon"];
                    if (isValid(appIcon)) {
                        appInfo.appIcon = appIcon;
                    }
                    
                    NSString *attachUrl = [itemDic objectForKeyWithOutCaps:@"attachUrl"];
                    if (isValid(attachUrl)) {
                        appInfo.attachUrl = attachUrl;
                    }
                    
                    NSString *createTime = [itemDic objectForKeyWithOutCaps:@"createTime"];
                    if (isValid(createTime)) {
                        appInfo.createTime = createTime;
                    }
                    
                    NSString *sn = [itemDic objectForKeyWithOutCaps:@"sn"];
                    if (isValid(sn)) {
                        appInfo.sn = sn;
                    }
                    
                    NSString *version = [itemDic objectForKeyWithOutCaps:@"version"];
                    if (isValid(version)) {
                        appInfo.version = version;
                    }
                    
                    NSString *appicon = [itemDic objectForKeyWithOutCaps:@"appicon"];
                    if (isValid(appicon)) {
                        appInfo.iconUrl = appicon;
                    }
                    
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
    
    return YES;
    
}

+ (BOOL) parseAppTypeList : (NSData*) data
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
            
            NSArray *dataArr = [bizdata dataArrForKey:@"appTypes"];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ApplicationType class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *appType = [itemDic objectForKeyWithOutCaps:@"appType"];
                
                if (isValid(appType))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appType == %@",appType];
                    
                    [request setPredicate:predicate];
                }
                
                ApplicationType *appTypeInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count == 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        appTypeInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        appTypeInfo = [[ApplicationType alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        appTypeInfo.appType = appType;
                    }
                    
                    NSString *appTypeName = [itemDic objectForKeyWithOutCaps:@"appTypeName"];
                    if (isValid(appTypeName)) {
                        appTypeInfo.appTypeName = appTypeName;
                    }
                    
                    NSString *appNum = [itemDic objectForKeyWithOutCaps:@"appNum"];
                    if (isValid(appNum)) {
                        appTypeInfo.appNum = appNum;
                    }
                }
                
                [appTypeInfo release];
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
