//
//  MainDataParser.m
//  Main
//
//  Created by lixiangai on 14-3-5.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "MainDataParser.h"
#import "JSON.h"
#import "Userinfo.h"
#import "SignHistoryInfo.h"
#import "NSDictionary+CustomExtensions.h"
#import "MessageClassInfo.h"
#import "NewsCenterCategory.h"

@implementation MainDataParser
+(BOOL)parseUnreadCount:(NSData*)data array:(NSArray *)arr
{

    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata))
        {
            
            NSArray *dataArr = [bizdata objectForKey:@"data"];
            
            Userinfo *info = [Userinfo shareUserinfo];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *fdic in dataArr)
            {
                NSString *funcCode = [fdic objectForKey:@"funccode"];
                
                if (isValid(funcCode))
                {
//                    for (Module *module in arr)
//                    {
//                        if ([module.funcCode isEqualToString:funcCode])
//                        {
//                            module.badge =[NSNumber numberWithInteger: [[fdic objectForKey:@"Count"] integerValue]];
//                            break;
//                        }
//                    }
                    
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userInfo.uid == %@ && funcCode == %@",info.uid,funcCode];

                        [request setPredicate:predicate];
                        
                        NSError *error = nil;
                        
                        NSArray *results = [context executeFetchRequest:request error:&error];
                        
                        if (isValid(results) && !error)
                        {
                            
                            if (results.count == 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                                
                              Module * module = [results objectAtIndex:0];
                              module.badge =[NSNumber numberWithInteger: [[fdic objectForKey:@"Count"] integerValue]];
                               
                            }
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

+(BOOL)parseSignList:(NSData*)data
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
            NSArray *dataArr = [bizdata dataArrForKey:@"signlist"];
            
            Userinfo *info = [Userinfo shareUserinfo];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([SignHistoryInfo class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *signId = [itemDic objectForKey:@"signid"];
                
                if (isValid(signId))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"signId == %@ && userId == %@",signId,info.uid];
                    
                    [request setPredicate:predicate];
                }
                
                SignHistoryInfo *signInfo  = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count == 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        signInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        signInfo = [[SignHistoryInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        signInfo.signId = signId;
                        signInfo.userId = info.uid;
                    }
                    
                    NSString *signTime = [itemDic objectForKey:@"signtime"];
                    if (isValid(signInfo)) {
                        signInfo.signTime = signTime;
                    }
                    
                    NSString *location = [itemDic objectForKey:@"location"];
                    if (isValid(location)) {
                        if ([location isKindOfClass:[NSDictionary class]]) {
                            continue;
                        }
                        signInfo.location = location;
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

+(BOOL)parseMessageClassInfo:(NSData*)data
{
    
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        NSDictionary *bizdata = [bodyDictionary dataForKey:@"bizdata"];
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata))
        {
            
            NSArray *msgItems = [bizdata dataArrForKey:@"msgitems"];
            
            Userinfo *info = [Userinfo shareUserinfo];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"MessageClassInfo" inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *fdic in msgItems)
            {
                NSString *msgId = [fdic objectForKey:@"id"];
                
                NSString *classId = [fdic objectForKey:@"classid"];
                
                NSString *title = [fdic objectForKey:@"title"];
                
                NSString *postTime = [fdic objectForKey:@"posttime"];
                
                if (isValid(msgId) || isValid(classId))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@ && messageId == %@ && msgClassId == %@ && title == %@ && postTime == %@",info.uid, msgId, classId, title, postTime];
                    
                    [request setPredicate:predicate];
                    
                    NSError *error = nil;
                    
                    NSArray *results = [context executeFetchRequest:request error:&error];
                    
                    if (isValid(results) && !error)
                    {
                        
                        MessageClassInfo *msgClass = nil;
                        
                        if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                            
                            msgClass = [[results firstObject] retain];
                            
                        }
                        else
                        {
                            msgClass = [[MessageClassInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        }
                        
                        if (isValid(msgId)) {
                            msgClass.messageId = msgId;
                        }
                        
                        if (isValid(classId)) {
                            msgClass.msgClassId = classId;
                        }
                        
                        NSString *classname = [fdic objectForKey:@"classname"];
                        if (isValid(classname)) {
                            msgClass.msgClassName = classname;
                        }
                        
                        if (isValid(postTime)) {
                            msgClass.postTime = postTime;
                        }
                        
                        if (isValid(title)) {
                            msgClass.title = title;
                        }
                        
                        msgClass.userId = [Userinfo shareUserinfo].uid;
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

+(BOOL)parserNewsCenter:(NSData *)data
{
    
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (isValid(bodyDictionary) && !error)
    {
        Userinfo *userinfo = [Userinfo shareUserinfo];
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        if (isValid(ret)) {
            
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
        }
        
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        
        if (isValid(bizdata)) {
            
            
            //解析用户的公文流转栏目列表
            NSArray *itemList = [bizdata objectForKey:@"data"];
            
            if (isValid(itemList)) {
                
                NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterCategory class]) inManagedObjectContext:context];
                
                //先查询用户的公文流转栏目列表的历史记录
                NSFetchRequest *request=[[NSFetchRequest alloc] init];
                
                [request setEntity:entityDescription];
                
                for (NSDictionary *itemDic in itemList) {
                    
                    NSString *funcid = [itemDic objectForKey:@"funcid"];
                    
                    if (isValid(funcid)) {
                        
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && uid == %@",userinfo.uid,funcid];
                        
                        [request setPredicate:predicate];
                        
                        NSError *error = nil;
                        
                        NSArray *results = [context executeFetchRequest:request error:&error];
                        
                        NewsCenterCategory *category = nil;
                        
                        if (isValid(results) && !error) {
                            
                            if (results.count == 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                                
                                category = [[results objectAtIndex:0] retain];
                            }
                            else {
                                //如果没有记录则新建模块记录
                                category = [[NewsCenterCategory alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                
                                category.uid = funcid;
                                category.userid = userinfo.uid;
                            }
                        }
                        
                        NSString *funcname = [itemDic objectForKey:@"funcname"];
                        
                        if (isValid(funcname)) {
                            
                            category.title = funcname;
                        }
                        
                        NSString *funccode = [itemDic objectForKey:@"funccode"];
                        
                        if (isValid(funccode)) {
                            
                            category.code = funccode;
                        }
                        
                        NSString *sort = [itemDic objectForKey:@"sort"];
                        
                        if (isValid(sort)) {
                            
                            category.sort = [NSNumber numberWithInteger:[sort integerValue]];
                        }
                        
                        /*NSString *flowType = [itemDic objectForKey:@"flowType"];
                         
                         if (isValid(sort)) {
                         
                         category.flowType = [NSNumber numberWithInteger:[sort integerValue]];
                         }*/
                        
                        NSString *flowType = [itemDic objectForKey:@"flowType"];
                        
                        if (isValid(flowType)) {
                            
                            //由于目前文档库与领导批示此类型的流程改为到一级菜单,目前公文流转的处理类型中的“收文”/“发文”属于默认类型
                            category.flowType = [NSNumber numberWithInteger:[flowType integerValue]];
                        }
                        
                        NSString *filters = [itemDic objectForKey:@"searchkeywords"];
                        
                        if (isValid(filters)) {
                            
                            category.filters = filters;
                        }
                        
                        NSString *searchType = [itemDic objectForKey:@"searchtype"];
                        
                        if (isValid(searchType)) {
                            
                            category.searchType = [NSNumber numberWithInteger:[searchType integerValue]];
                        }
                        
                        NSString *funcdes = [itemDic objectForKey:@"funcdes"];
                        
                        if (isValid(funcdes)) {
                            
                            category.funcdes = funcdes;
                        }
                        
                        [category release];
                        
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
    return NO;
}

@end
