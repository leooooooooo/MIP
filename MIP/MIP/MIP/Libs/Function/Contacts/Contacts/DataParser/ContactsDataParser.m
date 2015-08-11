//
//  ContactsDataParser.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ContactsDataParser.h"
#import "JSON.h"
#import "PerContactsInfo.h"
#import "ComContactsInfo.h"
#import "FullCompanyInfo.h"
#import "NSDictionary+CustomExtensions.h"

@implementation ContactsDataParser

+ (BOOL) parseComContactsList:(NSData *)data withSort : (NSString *)sort
{
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        NSDictionary *bizdata = [bodyDictionary dataForKey:@"bizData"];
        
        if (isValid(bizdata))
        {
            
            NSArray *dataArr = [bizdata dataArrForKey:@"contactList"];
            NSLog(@"contactList count is %d",dataArr.count);
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ComContactsInfo class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *company = [itemDic objectForKeyWithOutCaps:@"company"];
                NSString *department = [itemDic objectForKeyWithOutCaps:@"department"];
                department = department ? department : @"";
                
                NSString *duties = [itemDic objectForKeyWithOutCaps:@"duties"];
                duties = duties ? duties : @"";
                
                NSString *tel = [itemDic objectForKeyWithOutCaps:@"tel"];
                tel = tel ? tel : @"";
                
                if (isValid(company))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"company == %@ && department == %@ && duties == %@ && tel == %@",company, department, duties, tel];
                    
                    [request setPredicate:predicate];
                }
                
                ComContactsInfo *comContactsInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        comContactsInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        comContactsInfo = [[ComContactsInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        comContactsInfo.company = company;
                        comContactsInfo.department = department;
                        comContactsInfo.duties = duties;
                        comContactsInfo.tel = tel;
                    }
                    
                    NSString *num = [itemDic objectForKeyWithOutCaps:@"num"];
                    if (isValid(num)) {
                        comContactsInfo.num = [NSString stringWithFormat:@"%@-%04d", sort, [num integerValue]];
                    }
                }
                
                [comContactsInfo release];
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

+ (BOOL) parseFullCompanyList:(NSData *)data
{
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        NSDictionary *bizdata = [bodyDictionary dataForKey:@"bizData"];
        
        if (isValid(bizdata))
        {
            
            NSArray *dataArr = [bizdata dataArrForKey:@"enterList"];
            NSLog(@"enterList count is %d",dataArr.count);
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([FullCompanyInfo class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *companyid = [itemDic objectForKeyWithOutCaps:@"companyid"];
                NSString *companyname = [itemDic objectForKeyWithOutCaps:@"companyname"];
                
                if (isValid(companyid))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"companyid == %@",companyid];
                    
                    [request setPredicate:predicate];
                }
                
                FullCompanyInfo *fullCompanyInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        fullCompanyInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        fullCompanyInfo = [[FullCompanyInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        fullCompanyInfo.companyid = companyid;
                        fullCompanyInfo.companyname = companyname;
                    }
                }
                
                [fullCompanyInfo release];
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


+ (BOOL) parseComContactsList:(NSData *)data
{
    return [ContactsDataParser parseComContactsList:data withSort:@""];
}

+ (NSDictionary *) parseComContactsSearchResult:(NSData *)data
{
    if (!data)
        return nil;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        NSDictionary *bizdata = [bodyDictionary dataForKey:@"bizData"];
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata dataArrForKey:@"contactList"];
            NSLog(@"contactList count is %d",dataArr.count);
            
            NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
            
            NSMutableArray *tmpResult = nil;
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ComContactsInfo class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[[NSFetchRequest alloc] init]autorelease];
            [request setEntity:entityDescription];
            
            NSInteger index = 0;
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *company = [itemDic objectForKeyWithOutCaps:@"company"];
                NSString *department = [itemDic objectForKeyWithOutCaps:@"department"];
                department = department ? department : @"";
                
                NSString *duties = [itemDic objectForKeyWithOutCaps:@"duties"];
                duties = duties ? duties : @"";
                
                NSString *tel = [itemDic objectForKeyWithOutCaps:@"tel"];
                tel = tel ? tel : @"";
                
                NSArray *searchResults = nil;
                
                if ([results.allKeys containsObject:company]) {
                    tmpResult = [[results objectForKey: company] retain];
                }else {
                    tmpResult = [[NSMutableArray alloc] init];
                    [results setObject:tmpResult forKey:company];
                }
                
                ComContactsInfo *comDepart = nil;
                
                if (isValid(company))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"company == %@ && department == %@ && duties == \"\"",company, department];
                    
                    [request setPredicate:predicate];
                    
                    searchResults = [context executeFetchRequest:request error:&error];
                    
                    if (searchResults.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        comDepart = [[searchResults objectAtIndex:0] retain];
                    }
                    else
                    {
                        comDepart = [[ComContactsInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        comDepart.company = company;
                        comDepart.department = department;
                        comDepart.duties = @"";
                        comDepart.num = [NSString stringWithFormat:@"%04d", index++];
                    }
                    
                    if (comDepart && ![tmpResult containsObject:comDepart]) {
                        [tmpResult addObject:comDepart];
                    }
                }
                
                if (isValid(company))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"company == %@ && department == %@ && duties == %@ && tel == %@",company, department, duties, tel];
                    
                    [request setPredicate:predicate];
                }
                
                ComContactsInfo *comContactsInfo = nil;
                
                searchResults = [context executeFetchRequest:request error:&error];
                
                if (isValid(searchResults) && !error)
                {
                    
                    if (searchResults.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        comContactsInfo = [[searchResults objectAtIndex:0] retain];
                    }
                    else
                    {
                        comContactsInfo = [[ComContactsInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        comContactsInfo.company = company;
                        comContactsInfo.department = department;
                        comContactsInfo.duties = duties;
                        comContactsInfo.tel = tel;
                    }
                    
                    NSString *num = [itemDic objectForKeyWithOutCaps:@"num"];
                    if (isValid(num)) {
                        comContactsInfo.num = [NSString stringWithFormat:@"%@-%04d", comDepart.num, [num integerValue]];
                    }
                }
                
                if (comContactsInfo) {
                    [tmpResult addObject:comContactsInfo];
                }
                
                [comContactsInfo release];
                [comDepart release];
                [tmpResult release];
            }
            
            for (NSMutableArray *tmpComContacts in results.allValues) {
                [tmpComContacts sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    ComContactsInfo *info1 = obj1;
                    ComContactsInfo *info2 = obj2;
                    return [info1.num compare:info2.num];
                }];
            }
            
            NSDictionary *result = [[[NSDictionary alloc] initWithDictionary:results] autorelease];
            
            [results release];
            
//            [context rollback];
            
            return result;
        }
    }
    
    return nil;
}

+ (BOOL) parsePerContactsList:(NSData *)data
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
        
        if (isValid(bizdata))
        {
            
            NSArray *dataArr = [bizdata dataArrForKey:@"percontacts"];
            NSLog(@"percontacts count is %d",dataArr.count);
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([PerContactsInfo class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];

            dataArr = [dataArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {

                NSString *name1 = [(NSDictionary *)obj1 objectForKeyWithOutCaps:@"name"];
                NSString *name2 = [(NSDictionary *)obj2 objectForKeyWithOutCaps:@"name"];
                return [name1 localizedCompare:name2];
            }];
            
            NSInteger index = 0;
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *userId = [itemDic objectForKeyWithOutCaps:@"userid"];
                NSString *name = [itemDic objectForKeyWithOutCaps:@"name"];
                NSString *tel = [itemDic objectForKeyWithOutCaps:@"tel"];
                NSString *email = [itemDic objectForKeyWithOutCaps:@"email"];
                
                if (isValid(userId))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@", userId];
                    
                    [request setPredicate:predicate];
                }
                
                PerContactsInfo *perContactsInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        perContactsInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        perContactsInfo = [[PerContactsInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        perContactsInfo.name = name;
                    }
                    
                    NSString *companyid = [itemDic objectForKeyWithOutCaps:@"companyid"];
                    if (isValid(companyid)) {
                        perContactsInfo.companyid = companyid;
                    }
                    
                    NSString *companyname = [itemDic objectForKeyWithOutCaps:@"companyname"];
                    if (isValid(companyname)) {
                        perContactsInfo.companyname = companyname;
                    }
                    
                    if (isValid(tel)) {
                        perContactsInfo.tel = tel;
                    }
                    
                    if (isValid(email)) {
                        perContactsInfo.email = email;
                    }
                    
                    NSString *departmentid = [itemDic objectForKeyWithOutCaps:@"departmentid"];
                    if (isValid(departmentid)) {
                        perContactsInfo.departmentid = departmentid;
                    }
                    
                    NSString *departmentname = [itemDic objectForKeyWithOutCaps:@"departmentname"];
                    if (isValid(departmentname)) {
                        perContactsInfo.departmentname = departmentname;
                    }
                    
//                    NSString *userid = [itemDic objectForKeyWithOutCaps:@"userid"];
                    if (isValid(userId)) {
                        perContactsInfo.userid = userId;
                    }
                    
                    NSString *duty = [itemDic objectForKeyWithOutCaps:@"duty"];
                    if (isValid(duty)) {
                        perContactsInfo.duty = duty;
                    }
                    
                    NSString *baktel = [itemDic objectForKeyWithOutCaps:@"baktel"];
                    if (isValid(baktel)) {
                        perContactsInfo.baktel = baktel;
                    }
                    
                    NSString *officetel = [itemDic objectForKeyWithOutCaps:@"officetel"];
                    if (isValid(officetel)) {
                        perContactsInfo.officetel = officetel;
                    }
                    
                    NSString *bakofficetel = [itemDic objectForKeyWithOutCaps:@"bakofficetel"];
                    if (isValid(bakofficetel)) {
                        perContactsInfo.bakofficetel = bakofficetel;
                    }
                    
                    NSString *peremail = [itemDic objectForKeyWithOutCaps:@"peremail"];
                    if (isValid(peremail)) {
                        perContactsInfo.peremail = peremail;
                    }
                    
                    NSString *headpicurl = [itemDic objectForKeyWithOutCaps:@"headpicurl"];
                    if (isValid(headpicurl)) {
                        perContactsInfo.headpicurl = headpicurl;
                    }
                    
                    NSString *markweibo = [itemDic objectForKeyWithOutCaps:@"markweibo"];
                    if (isValid(markweibo)) {
                        perContactsInfo.markweibo = markweibo;
                    }
                    
                    perContactsInfo.num = [NSNumber numberWithInt: index++];
                }
                
                [perContactsInfo release];
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
