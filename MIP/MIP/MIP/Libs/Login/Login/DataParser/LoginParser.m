//
//  LoginParser.m
//  Login
//
//  Created by lixiangai on 13-9-22.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "LoginParser.h"

#import "JSON.h"

#import "NSDictionary+CustomExtensions.h"

@implementation LoginParser

/*********************************************************************
 Function description:解析登录返回数据
 Parameter: data
 Return value: NSDictionary
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+ (BOOL)parseUserinfo:(NSData*)data
{
    
    if (!data)
        return NO;
    
    NSError *error = nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    DLog(@"%@",bodyDictionary);
    if (isValid(bodyDictionary) && !error)
    {
        Userinfo *userinfo = [Userinfo shareUserinfo];
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        if (isValid(ret)) {
            
            userinfo.loginCode = (LoginStatues)[ret integerValue];
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
            userinfo.loginCodeMessage = retMsg;
        }
        
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
                
        if (isValid(bizdata)) {
 
            NSArray *dataArr = [bizdata objectForKey:@"data"];
            
            if (isValid(dataArr) && [dataArr count] > 0)
            {
                NSDictionary *dataDic = [dataArr objectAtIndex:0];
                
                //接口token
                NSString *tokenStr = [dataDic objectForKey:@"token"];
                if (isValid(tokenStr))
                {
                    [Userinfo shareUserinfo].token = tokenStr;
                }
                
                //解析是否需要绑定
                NSString *value = [dataDic objectForKey:@"isbindremind"];
                
                if (isValid(value)) {
                    
                    userinfo.bindCode = [value intValue];
                    
                }
                
                //解析最新的配置文件版本号
                value = [dataDic objectForKey:@"preversion"];
                
                if (isValid(value)) {
                    
                    userinfo.configVersion = value;
                }
                
                //解析用户的中文名
                value = [dataDic objectForKey:@"username"];
                
                if (isValid(value)) {
                    
                    userinfo.name_zhCN = value;
                }
                
                userinfo.uid = userinfo.name;
                
                value = [dataDic objectForKey:@"companyid"];
                
                if (isValid(value)) {
                    
                    userinfo.companyid = value;
                }
                
                value = [dataDic objectForKey:@"companyname"];
                
                if (isValid(value)) {
                    
                    userinfo.company = value;
                }
                
                value = [dataDic objectForKey:@"tel"];
                
                if (isValid(value)) {
                    
                    userinfo.telephone = value;
                }
                
                value = [dataDic objectForKey:@"email"];
                
                if (isValid(value)) {
                    
                    userinfo.email = value;
                }
                
                //更新类型
                value = [dataDic objectForKey:@"newupdpolicy"];
                
                if (isValid(value)) {
                    
                    userinfo.updateType = [value intValue];
                }
                
                //用户编号
                value = [dataDic objectForKey:@"userid"];
                
                if (isValid(value)) {
                    
                    userinfo.userId = value;
                }
                
                //部门编号
                value = [dataDic objectForKey:@"departmentid"];
                
                if (isValid(value)) {
                    
                    userinfo.deptID = value;
                }
                
                //部门名称
                value = [dataDic objectForKey:@"departmentname"];
                
                if (isValid(value)) {
                    
                    userinfo.deptName = value;
                }
                
                //职务
                value = [dataDic objectForKey:@"duty"];
                
                if (isValid(value)) {
                    
                    userinfo.duty = value;
                }
                
                //备用手机
                value = [dataDic objectForKey:@"baktel"];
                
                if (isValid(value)) {
                    
                    userinfo.bakTel = value;
                }
                
                //办公电话
                value = [dataDic objectForKey:@"officetel"];
                
                if (isValid(value)) {
                    
                    userinfo.officeTel = value;
                }
                
                //备用电话
                value = [dataDic objectForKey:@"bakofficetel"];
                
                if (isValid(value)) {
                    
                    userinfo.bakOfficeTel = value;
                }
                
                //个人邮箱
                value = [dataDic objectForKey:@"peremail"];
                
                if (isValid(value)) {
                    
                    userinfo.perEmail = value;
                }
                
                //头像URL
                value = [dataDic objectForKey:@"headpicurl"];
                
                if (isValid(value)) {
                    
                    userinfo.headPicUrl = value;
                }
                
                //云之家微博开通标识
                value = [dataDic objectForKey:@"markweibo"];
                
                if (isValid(value)) {
                    
                    userinfo.markWeibo = [NSNumber numberWithBool:[value boolValue]];
                }
                
                //最新版本号
                value = [dataDic objectForKey:@"newversion"];
                
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                
                if (isValid(value)) {
                    
                    [userDefaults setObject:value forKey:kLastVersion];
                }
                
                //最新版本下载路径
                value = [dataDic objectForKey:@"newapppath"];
                
                if (isValid(value)) {
                    
                    [userDefaults setObject:value forKey:kLastVersionURL];
                }
                
                //更新日志
                value = [dataDic objectForKey:@"updatelog"];
                
                if (isValid(value)) {
                    
                    [userDefaults setObject:value forKey:kVersionUpdateLog];
                }
                
                [userDefaults synchronize];
                
                NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                
                //解析用户的模块权限
                NSDictionary *modulesDic = [dataDic objectForKey:@"module"];
                
                if (isValid(modulesDic) && [dataDic.allKeys containsObject:@"module"]) {
                    
                    NSArray *modules = [modulesDic objectForKey:@"data"];
                    
                    if (isValid(modules))
                    {
                        
                        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:context];
                        
                        //先查询用户的模块的历史记录
                        NSFetchRequest *request=[[NSFetchRequest alloc] init];
                        
                        [request setEntity:entityDescription];
                        
                        for (NSDictionary *moduleDic in modules) {
                            
                            NSString *funcCode = [moduleDic objectForKey:@"funccode"];
                            
                            if ([funcCode isEqualToString:@"WDZM"] || [funcCode isEqualToString:@"CYGN"])//过滤掉我的桌面模块,常用功能(手机不需要)
                            {
                                continue;
                            }
                            
                            if (isValid(funcCode)) {
                                
                                //检查模块关联id的有效性,判断客户端是否支持该功能模块
                                if ([Module checkModuleValidity:funcCode])
                                {
                                    
                                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userInfo.uid == %@ && funcCode == %@",userinfo.uid,funcCode];
                                    
                                    [request setPredicate:predicate];
                                    
                                    NSError *error = nil;
                                    
                                    NSArray *results = [context executeFetchRequest:request error:&error];
                                    
                                    Module *module = nil;
                                    
                                    if (isValid(results) && !error) {
                                        
                                        if (results.count == 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                                            
                                            module = [results objectAtIndex:0];
                                        }
                                        else {
                                            
                                            //删除错误数据,重新建立数据及关联关系
                                            
//                                            NSEnumerator *enumerator = [results objectEnumerator];
//                                            
//                                            module = [enumerator nextObject];
//                                            
//                                            while (module) {
//                                                
//                                                [userinfo removeRelationToModuleObject:module];
//                                                [context deleteObject:module];
//                                                
//                                                module = [enumerator nextObject];
//                                            }
                                            
                                            //如果没有记录则新建模块记录
                                            module = [[Module alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                            
                                            [userinfo addRelationToModuleObject:module];
                                            
                                            module.funcCode = funcCode;
                                            
                                            module.moduleType = [NSNumber numberWithInt:0];
                                            
                                            [module release];
                                        }
                                    }
                                    
                                    NSString *unionId = [moduleDic objectForKey:@"funcid"];
                                    
                                    if (isValid(unionId)) {
                                        
                                        module.unionId = unionId;
                                    }
                                    
                                    NSString *moduleName = [moduleDic objectForKey:@"funcname"];
                                    
                                    if (isValid(moduleName)) {
                                        
                                        module.name = moduleName;
                                    }
                                    
                                    NSString *badge = [moduleDic objectForKey:@"count"];
                                    
                                    if (isValid(badge)) {
                                        
                                        module.badge = [NSNumber numberWithInteger:[badge integerValue]];
                                    }
                                    
                                    NSString *sort = [moduleDic objectForKey:@"sort"];
                                    
                                    if (isValid(sort)) {
                                        
                                        module.sort = [NSNumber numberWithInteger:[sort integerValue]];
                                    }
                                    
                                    //TODO:筛选条件属性，暂时加到module上面
                                    NSString *searchkeywords = [moduleDic objectForKey:@"searchkeywords"];
                                    
                                    if (isValid(searchkeywords)) {
                                        
                                        module.searchKeywords = searchkeywords;
                                    }
                                }
                            }
                            
                        }
                        
                        [request release];
                    }                    
                }
                
                
                //获取主页模块列表
                NSDictionary *indexModulesDic = [dataDic objectForKey:@"indexmodule"];
                
                NSString *indexString = [indexModulesDic JSONRepresentation];
                
                DLog(@"%@",indexString);
                
                if (isValid(indexModulesDic)) {
                    
                    NSArray *indexModules = [indexModulesDic objectForKey:@"data"];
                    
                    if (isValid(indexModules))
                    {
                        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:context];
                        
                        //先查询用户的模块的历史记录
                        NSFetchRequest *request=[[NSFetchRequest alloc] init];
                        
                        [request setEntity:entityDescription];
                        
                        NSMutableArray *indexModuleArray = [[NSMutableArray alloc] initWithCapacity:indexModules.count];
                        
                        for (NSDictionary *indexDic in indexModules)
                        {
                            NSString *funcCode = [indexDic objectForKey:@"funccode"];
                            
                            if (isValid(funcCode))
                            {
                                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userInfo.uid == %@ && funcCode == %@",userinfo.uid,funcCode];
                                
                                [request setPredicate:predicate];
                                
                                NSError *error = nil;
                                
                                NSArray *results = [context executeFetchRequest:request error:&error];
                                
                                Module *indexModule = nil;
                                
                                if (isValid(results) && !error) {
                                    
                                    if (results.count == 1) {//如果有原来模块权限记录,则直接使用原coreData对象
                                        
                                        //indexModule = [results objectAtIndex:0];
                                        
                                    }
                                    else
                                    {
                                        indexModule = [[Module alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                        
                                        [userinfo addRelationToModuleObject:indexModule];
                                        
                                        indexModule.userId = userinfo.uid;
                                        indexModule.funcCode = funcCode;
                                        
                                        NSString *unionId = [indexDic objectForKey:@"funcid"];
                                        
                                        if (isValid(unionId)) {
                                            
                                            indexModule.unionId = unionId;
                                        }
                                        
                                        NSString *moduleName = [indexDic objectForKey:@"funcname"];
                                        
                                        if (isValid(moduleName)) {
                                            
                                            indexModule.name = moduleName;
                                        }
                                        
                                        NSString *badge = [indexDic objectForKey:@"count"];
                                        
                                        if (isValid(badge)) {
                                            
                                            indexModule.badge = [NSNumber numberWithInteger:[badge integerValue]];
                                        }
                                        
                                        NSString *sort = [indexDic objectForKey:@"sort"];
                                        
                                        if (isValid(sort)) {
                                            
                                            indexModule.sort = [NSNumber numberWithInteger:[sort integerValue]];
                                        }
                                        
                                        NSString *funcCode = [indexDic objectForKey:@"funccode"];
                                        
                                        if (isValid(funcCode)) {
                                            
                                            indexModule.funcCode = funcCode;
                                        }
                                        
                                        //TODO:筛选条件属性，暂时加到module上面
                                        NSString *searchkeywords = [indexDic objectForKey:@"searchkeywords"];
                                        
                                        if (isValid(searchkeywords)) {
                                            
                                            indexModule.searchKeywords = searchkeywords;
                                        }
                                        
                                        NSString *type = [indexDic objectForKey:@"type"];
                                        
                                        if (isValid(type)) {
                                            
                                            indexModule.type = type;
                                        }
                                        
                                        indexModule.moduleType = [NSNumber numberWithInt:1];
                                        
                                        [indexModuleArray addObject:indexModule];
                                        
                                        [indexModule release];
                                    }
                                }
                            }
                            
                        }
                        
                        userinfo.indexModuleArray = indexModuleArray;
                        
                        [indexModuleArray release];
                        
                        [request release];
                    }
                }
                
                
                BOOL result = [userinfo.managedObjectContext save:&error];
                
                
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

+ (BOOL)parseModuleBadge:(NSData *)data
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
            
            userinfo.loginCode = (LoginStatues)[ret integerValue];
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
            userinfo.loginCodeMessage = retMsg;
        }
        
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        
        DLog(@"%@",[bizdata JSONRepresentation]);
        
        if (isValid(bizdata)) {
            
            NSArray *dataArr = [bizdata objectForKey:@"data"];
            
            if (isValid(dataArr) && [dataArr count] > 0)
            {
                NSDictionary *dataDic = [dataArr objectAtIndex:0];
                
                NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                
                //解析用户的模块权限
                NSDictionary *modulesDic = [dataDic objectForKey:@"module"];
                
                if (isValid(modulesDic)) {
                    
                    NSArray *modules = [modulesDic objectForKey:@"data"];
                    
                    if (isValid(modules))
                    {
                        
                        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:context];
                        
                        //先查询用户的模块的历史记录
                        NSFetchRequest *request=[[NSFetchRequest alloc] init];
                        
                        [request setEntity:entityDescription];
                        
                        for (NSDictionary *moduleDic in modules)
                        {
                            NSString *funcCode = [moduleDic objectForKey:@"funccode"];
                            
                            if (isValid(funcCode))
                            {
                                //检查模块关联id的有效性,判断客户端是否支持该功能模块
                                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userInfo.uid == %@ && funcCode == %@",userinfo.uid,funcCode];
                                
                                [request setPredicate:predicate];
                                
                                NSError *error = nil;
                                
                                NSArray *results = [context executeFetchRequest:request error:&error];
                                
                                Module *module = nil;
                                
                                if (isValid(results) && !error && [results count] == 1)
                                {
                                    module = [results objectAtIndex:0];
                                    
                                    NSString *unionId = [moduleDic objectForKey:@"funcid"];
                                    
                                    if (isValid(unionId)) {
                                        
                                        module.unionId = unionId;
                                    }
                                    
                                    NSString *moduleName = [moduleDic objectForKey:@"funcname"];
                                    
                                    if (isValid(moduleName)) {
                                        
                                        module.name = moduleName;
                                    }
                                    
                                    NSString *badge = [moduleDic objectForKey:@"count"];
                                    
                                    if (isValid(badge)) {
                                        
                                        module.badge = [NSNumber numberWithInteger:[badge integerValue]];
                                    }
                                    
                                    NSString *sort = [moduleDic objectForKey:@"sort"];
                                    
                                    if (isValid(sort)) {
                                        
                                        module.sort = [NSNumber numberWithInteger:[sort integerValue]];
                                    }
                                    
                                    //TODO:筛选条件属性，暂时加到module上面
                                    NSString *searchkeywords = [moduleDic objectForKey:@"searchkeywords"];
                                    
                                    if (isValid(searchkeywords)) {
                                        
                                        module.searchKeywords = searchkeywords;
                                    }
                                }
                            }
                            
                        }
                        
                        [request release];
                    }
                }
                
                BOOL result = [userinfo.managedObjectContext save:&error];
                
                
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

+ (NSDictionary *) parseLaunchImage:(NSData *)data
{
    if (!data)
        return nil;
    
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
            
            if ([dataArr count] > 0) {
                
                NSInteger width = SCREEN_WIDTH * 2;
                
                NSInteger height = SCREEN_HEIGHT * 2;
                
                NSString *picName = [NSString stringWithFormat:@"%ld*%ld.PNG", (long)width, (long)height];
                
                for (NSDictionary *tmpDic in dataArr) {
                    NSString *tmpName = [tmpDic objectForKey:@"name"];
                    if (tmpName && [tmpName isEqualToString:picName]) {
                        return tmpDic;
                    }
                }
                
                return [dataArr lastObject];
            }
        }
    }
    
    return nil;
    
}

@end
