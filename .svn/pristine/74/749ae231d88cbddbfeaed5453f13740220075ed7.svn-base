//
//  BusinessDataParser.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/01.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessDataParser.h"
#import "JSON.h"
#import "BusinessType.h"
#import "ShipInfo.h"
#import "BerthList.h"
#import "BerthPosList.h"
#import "LargeCommission.h"
#import "JobCompany.h"

#import "NSDictionary+CustomExtensions.h"

@implementation BusinessDataParser

+ (BOOL) parseBusinessTypeList : (NSData *) data
{
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
    if (isValid(bodyDictionary) && !error)
    {
        NSArray *bizdata = [bodyDictionary dataArrForKey:@"bizData"];
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata))
        {
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([BusinessType class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            NSInteger index = 0;
            
            for (NSDictionary *itemDic in bizdata)
            {
                NSString *funcname = [itemDic objectForKeyWithOutCaps:@"funcname"];
                
                if (isValid(funcname))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@",funcname];
                    
                    [request setPredicate:predicate];
                }
                
                BusinessType *businessType = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        businessType = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        businessType = [[BusinessType alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        businessType.title = funcname;
                    }
                    
                    businessType.type = [NSNumber numberWithInt: index++];
                    businessType.hasNew = NO;
                }
                
                [businessType release];
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

+ (BOOL) parseLargeCommList:(NSData *)data withShip :(BOOL) withShip
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
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata dataArrForKey:@"jobinfos"];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([LargeCommission class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *bcNo = [itemDic objectForKeyWithOutCaps:@"bcno"];
                
                if (isValid(bcNo))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bcno == %@",bcNo];
                    
                    [request setPredicate:predicate];
                }
                
                LargeCommission *largeComm = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        largeComm = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        largeComm = [[LargeCommission alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        largeComm.bcno = bcNo;
                    }
                    
                    NSString *serial = [itemDic objectForKeyWithOutCaps:@"serial"];
                    if (isValid(serial)) {
                        largeComm.serial = [NSString stringWithFormat:@"%@", serial];
                    }
                    
                    NSString *shipid = [itemDic objectForKeyWithOutCaps:@"shipid"];
                    if (isValid(shipid)) {
                        largeComm.shipid = [NSString stringWithFormat:@"%@", shipid];
                    }
                    
                    NSString *shipname = [itemDic objectForKeyWithOutCaps:@"shipname"];
                    if (isValid(shipname)) {
                        largeComm.shipname = [NSString stringWithFormat:@"%@", shipname];
                    }
                    
                    NSString *voyage = [itemDic objectForKeyWithOutCaps:@"voyage"];
                    if (isValid(voyage)) {
                        largeComm.voyage = [NSString stringWithFormat:@"%@", voyage];
                    }
                    
                    NSString *jobTypeId = [itemDic objectForKeyWithOutCaps:@"jobtypeid"];
                    if (isValid(jobTypeId)) {
                        largeComm.jobtypeid = [NSString stringWithFormat:@"%@", jobTypeId];
                    }
                    
                    NSString *jobTypeName = [itemDic objectForKeyWithOutCaps:@"jobtypename"];
                    if (isValid(jobTypeName)) {
                        largeComm.jobtypename = [NSString stringWithFormat:@"%@", jobTypeName];
                    }
                    
                    NSString *jobcompanyid = [itemDic objectForKeyWithOutCaps:@"jobcompanyid"];
                    if (isValid(jobcompanyid)) {
                        largeComm.jobcompanyid = [NSString stringWithFormat:@"%@", jobcompanyid];
                    }

                    NSString *jobcompanyname = [itemDic objectForKeyWithOutCaps:@"jobcompanyname"];
                    if (isValid(jobcompanyname)) {
                        largeComm.jobcompanyname = [NSString stringWithFormat:@"%@", jobcompanyname];
                    }
                    
                    NSString *cargoid = [itemDic objectForKeyWithOutCaps:@"cargoid"];
                    if (isValid(cargoid)) {
                        largeComm.cargoid = [NSString stringWithFormat:@"%@", cargoid];
                    }
                    
                    NSString *cargoname = [itemDic objectForKeyWithOutCaps:@"cargoname"];
                    if (isValid(cargoname)) {
                        largeComm.cargoname = [NSString stringWithFormat:@"%@", cargoname];
                    }
                    
                    NSString *weight = [itemDic objectForKeyWithOutCaps:@"weight"];
                    if (isValid(weight)) {
                        largeComm.weight = [NSString stringWithFormat:@"%@", weight];
                    }
                    
                    NSString *shipclientid = [itemDic objectForKeyWithOutCaps:@"shipclientid"];
                    if (isValid(shipclientid)) {
                        largeComm.shipclientid = [NSString stringWithFormat:@"%@", shipclientid];
                    }
                    
                    NSString *shipclientname = [itemDic objectForKeyWithOutCaps:@"shipclientname"];
                    if (isValid(shipclientname)) {
                        largeComm.shipclientname = [NSString stringWithFormat:@"%@", shipclientname];
                    }
                    
                    NSString *applydate = [itemDic objectForKeyWithOutCaps:@"applydate"];
                    if (isValid(applydate)) {
                        largeComm.applydate = [NSString stringWithFormat:@"%@", applydate];
                    }
                    
                    NSString *auditmarkid = [itemDic objectForKeyWithOutCaps:@"auditmarkid"];
                    if (isValid(auditmarkid)) {
                        largeComm.auditmarkid = [NSString stringWithFormat:@"%@", auditmarkid];
                    }
                    
                    NSString *auditmarkname = [itemDic objectForKeyWithOutCaps:@"auditmarkname"];
                    if (isValid(auditmarkname)) {
                        largeComm.auditmarkname = [NSString stringWithFormat:@"%@", auditmarkname];
                    }
                    
                    largeComm.createDate = [NSDate date];
                    
                    largeComm.withship = [NSNumber numberWithBool:withShip];
                }
                
                [largeComm release];
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


+ (BOOL) parseShipInfoList:(NSData *)data withType : (BusinessType *)type
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
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata dataArrForKey:@"todoshiptitles"];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([ShipInfo class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *shipId = [itemDic objectForKeyWithOutCaps:@"shipid"];
                
                if (isValid(shipId))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"shipid == %@ && processType.type == %d",shipId, [type.type integerValue]];
                    
                    [request setPredicate:predicate];
                }
                
                ShipInfo *shipInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        shipInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        shipInfo = [[ShipInfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                        shipInfo.shipid = shipId;
                    }
                    
                    NSString *shipName = [itemDic objectForKeyWithOutCaps:@"shipnamecn"];
                    if (isValid(shipName)) {
                        shipInfo.shipnamecn = [NSString stringWithFormat:@"%@", shipName];
                    }
                    
                    NSString *berthId = [itemDic objectForKeyWithOutCaps:@"berthid"];
                    if (isValid(berthId)) {
                        shipInfo.berthid = [NSString stringWithFormat:@"%@", berthId];
                    }
                    
                    NSString *berthName = [itemDic objectForKeyWithOutCaps:@"berthname"];
                    if (isValid(berthName)) {
                        shipInfo.berthname = [NSString stringWithFormat:@"%@", berthName];
                    }
                    
                    NSString *jobCompanyId = [itemDic objectForKeyWithOutCaps:@"jobcompanyid"];
                    if (isValid(jobCompanyId)) {
                        shipInfo.jobcompanyid = [NSString stringWithFormat:@"%@", jobCompanyId];
                    }
                    
                    NSString *jobCompanyName = [itemDic objectForKeyWithOutCaps:@"jobcompanyname"];
                    if (isValid(jobCompanyName)) {
                        shipInfo.jobcompanyname = [NSString stringWithFormat:@"%@", jobCompanyName];
                    }
                    
                    NSString *unloadcargoid = [itemDic objectForKeyWithOutCaps:@"unloadcargoid"];
                    if (isValid(unloadcargoid)) {
                        shipInfo.unloadcargoid = [NSString stringWithFormat:@"%@", unloadcargoid];
                    }
                    
                    NSString *unloadcargoname = [itemDic objectForKeyWithOutCaps:@"unloadcargoname"];
                    if (isValid(unloadcargoname)) {
                        shipInfo.unloadcargoname = [NSString stringWithFormat:@"%@", unloadcargoname];
                    }
                    
                    NSString *unloadweight = [itemDic objectForKeyWithOutCaps:@"unloadweight"];
                    if (isValid(unloadweight)) {
                        shipInfo.unloadweight = [NSString stringWithFormat:@"%@", unloadweight];
                    }
                    
                    NSString *loadcargoid = [itemDic objectForKeyWithOutCaps:@"loadcargoid"];
                    if (isValid(loadcargoid)) {
                        shipInfo.loadcargoid = [NSString stringWithFormat:@"%@", loadcargoid];
                    }
                    
                    NSString *loadcargoname = [itemDic objectForKeyWithOutCaps:@"loadcargoname"];
                    if (isValid(loadcargoname)) {
                        shipInfo.loadcargoname = [NSString stringWithFormat:@"%@", loadcargoname];
                    }
                    
                    NSString *loadweight = [itemDic objectForKeyWithOutCaps:@"loadweight"];
                    if (isValid(loadweight)) {
                        shipInfo.loadweight = [NSString stringWithFormat:@"%@", loadweight];
                    }
                    
                    NSString *arriveanchortime = [itemDic objectForKeyWithOutCaps:@"arriveanchortime"];
                    if (isValid(arriveanchortime)) {
                        shipInfo.arriveanchortime = [NSString stringWithFormat:@"%@", arriveanchortime];
                    }
                    
                    NSString *shipclientid = [itemDic objectForKeyWithOutCaps:@"shipclientid"];
                    if (isValid(shipclientid)) {
                        shipInfo.shipclientid = [NSString stringWithFormat:@"%@", shipclientid];
                    }
                    
                    NSString *shipclientname = [itemDic objectForKeyWithOutCaps:@"shipclientname"];
                    if (isValid(shipclientname)) {
                        shipInfo.shipclientname = [NSString stringWithFormat:@"%@", shipclientname];
                    }
                    
                    NSString *leadmarkid = [itemDic objectForKeyWithOutCaps:@"leadmarkid"];
                    if (isValid(leadmarkid)) {
                        shipInfo.leadmarkid = [NSString stringWithFormat:@"%@", leadmarkid];
                    }
                    
                    NSString *leadmarkname = [itemDic objectForKeyWithOutCaps:@"leadmarkname"];
                    if (isValid(leadmarkname)) {
                        shipInfo.leadmarkname = [NSString stringWithFormat:@"%@", leadmarkname];
                    }
                    
                    NSString *planmarkid = [itemDic objectForKeyWithOutCaps:@"planmarkid"];
                    if (isValid(planmarkid)) {
                        shipInfo.planmarkid = [NSString stringWithFormat:@"%@", planmarkid];
                    }
                    
                    NSString *planmarkname = [itemDic objectForKeyWithOutCaps:@"planmarkname"];
                    if (isValid(planmarkname)) {
                        shipInfo.planmarkname = [NSString stringWithFormat:@"%@", planmarkname];
                    }
                    
                    NSString *planinporttime = [itemDic objectForKeyWithOutCaps:@"planinporttime"];
                    if (isValid(planinporttime)) {
                        shipInfo.planinporttime = [NSString stringWithFormat:@"%@", planinporttime];
                    }
                    
                    NSString *planoutporttime = [itemDic objectForKeyWithOutCaps:@"planoutporttime"];
                    if (isValid(planoutporttime)) {
                        shipInfo.planoutporttime = [NSString stringWithFormat:@"%@", planoutporttime];
                    }
                    
                    NSString *planmoveberthno = [itemDic objectForKeyWithOutCaps:@"planmoveberthno"];
                    if (isValid(planmoveberthno)) {
                        shipInfo.planmoveberthno = [NSString stringWithFormat:@"%@", planmoveberthno];
                    }
                    
                    NSString *planmoveberthtime = [itemDic objectForKeyWithOutCaps:@"planmoveberthtime"];
                    if (isValid(planmoveberthtime)) {
                        shipInfo.planmoveberthtime = [NSString stringWithFormat:@"%@", planmoveberthtime];
                    }
                    
                    shipInfo.createDate = [NSDate date];
                    
                    shipInfo.processType = type;
                    [type addShipsObject:shipInfo];
                }
                
                [shipInfo release];
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

+ (BOOL) parseBerthInfoList:(NSData *)data
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
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata dataArrForKey:@"berthlist"];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([BerthList class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *berthId = [itemDic objectForKeyWithOutCaps:@"berthid"];
                
                if (isValid(berthId))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"berthId == %@",berthId];
                    
                    [request setPredicate:predicate];
                }
                
                BerthList *berthInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        berthInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        berthInfo = [[BerthList alloc] initWithEntity:entityDescription
                                       insertIntoManagedObjectContext:context];
                        berthInfo.berthId = berthId;
                    }
                    
                    NSString *berthNo = [itemDic objectForKeyWithOutCaps:@"berthno"];
                    if (isValid(berthNo)) {
                        berthInfo.berthNo = berthNo;
                    }
                    
                    NSString *deptCode = [itemDic objectForKeyWithOutCaps:@"deptcode"];
                    if (isValid(deptCode)) {
                        berthInfo.deptCode = deptCode;
                    }
                    
                    NSString *department = [itemDic objectForKeyWithOutCaps:@"department"];
                    if (isValid(department)) {
                        berthInfo.department = department;
                    }
                    
                }
                
                [berthInfo release];
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

+ (BOOL) parseBerthPosInfoList:(NSData *)data
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
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata dataArrForKey:@"berthPoslist"];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([BerthPosList class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *position = [itemDic objectForKeyWithOutCaps:@"position"];
                
                if (isValid(position))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"position == %@",position];
                    
                    [request setPredicate:predicate];
                }
                
                BerthPosList *berthPosInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        berthPosInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        berthPosInfo = [[BerthPosList alloc] initWithEntity:entityDescription
                                       insertIntoManagedObjectContext:context];
                        berthPosInfo.position = position;
                    }
                }
                
                [berthPosInfo release];
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

+ (BOOL) parseJobCompanyList:(NSData *)data
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
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata))
        {
            NSArray *dataArr = [bizdata dataArrForKey:@"deptlist"];
            
            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([JobCompany class]) inManagedObjectContext:context];
            NSFetchRequest *request=[[NSFetchRequest alloc] init];
            [request setEntity:entityDescription];
            
            for (NSDictionary *itemDic in dataArr)
            {
                NSString *codeDepartment = [itemDic objectForKeyWithOutCaps:@"code_department"];
                
                if (isValid(codeDepartment))
                {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"codeDepartment == %@",codeDepartment];
                    
                    [request setPredicate:predicate];
                }
                
                JobCompany *jobCompanyInfo = nil;
                
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if (isValid(results) && !error)
                {
                    
                    if (results.count >= 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                        jobCompanyInfo = [[results objectAtIndex:0] retain];
                    }
                    else
                    {
                        jobCompanyInfo = [[JobCompany alloc] initWithEntity:entityDescription
                                             insertIntoManagedObjectContext:context];
                        jobCompanyInfo.codeDepartment = codeDepartment;
                    }
                    
                    NSString *department = [itemDic objectForKey:@"department"];
                    if (isValid(department)) {
                        jobCompanyInfo.department = department;
                    }
                    
                }
                
                [jobCompanyInfo release];
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


+ (NSDictionary *) parseShipInfoDetail:(NSData *)data
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
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        return bizdata;
    }
    
    return nil;
}

@end
