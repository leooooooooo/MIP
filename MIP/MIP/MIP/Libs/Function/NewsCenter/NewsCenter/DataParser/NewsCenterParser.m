//
//  NewsCenterParser.m
//  NewsCenter
//
//  Created by wanghao on 14-3-14.
//
//

#import "NewsCenterParser.h"

#import "NewsCenterCategory.h"
#import "NewsCenterDocument.h"
#import "NewsCenterPDF.h"
#import "NewsCenterNewsType.h"
#import "NewsCenterContent.h"
#import "NSDictionary+CustomExtensions.h"

@implementation NewsCenterParser

+(BOOL)parserNewsCenterWith:(NSData *)data{
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

+(BOOL)parserNewsCenterDocumentWith:(NSData *)data category:(NewsCenterCategory *)newsCenterCategory
{
    NSError *error = nil;
    
    if (!data || !isValid(newsCenterCategory))
        return NO;
    
//    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
//    NewsCenterCategory *category = (NewsCenterCategory *)[context objectWithID:[newsCenterCategory objectID]];
    NewsCenterCategory *category = newsCenterCategory;
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
                
                if (isValid(dataDic) && [dataDic isKindOfClass:[NSDictionary class]] && [[dataDic allKeys] containsObject:@"newstitles"]) {
                    
                    //解析用户的公文流转栏目列表
                    
                    NSDictionary *newstitlesDic = [dataDic objectForKey:@"newstitles"];
                    
                    if (isValid(newstitlesDic) && [newstitlesDic isKindOfClass:[NSDictionary class]] && [[newstitlesDic allKeys] containsObject:@"data"])
                    {
                        NSArray *itemList = [newstitlesDic objectForKey:@"data"];
                        
                        if (isValid(itemList)) {
                            
                            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                            
                            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterDocument class]) inManagedObjectContext:context];
                            
                            //先查询用户的公文流转栏目列表的历史记录
                            NSFetchRequest *request=[[NSFetchRequest alloc] init];
                            
                            [request setEntity:entityDescription];
                            
                            for (NSDictionary *itemDic in itemList)
                            {
                                
                                NSString *messageItemGuid = [itemDic objectForKey:@"id"];
                                
                                if (isValid(messageItemGuid)) {
                                    
                                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"newsCenterCategory.userid == %@ && uid == %@ && type == %@",[Userinfo shareUserinfo].uid,messageItemGuid,[NSNumber numberWithInt:category.newsType]];
                                    
                                    [request setPredicate:predicate];
                                    
                                    NSError *error = nil;
                                    
                                    NSArray *results = [context executeFetchRequest:request error:&error];
                                    
                                    NewsCenterDocument *document = nil;
                                    
                                    if (isValid(results) && !error) {
                                        
                                        if (results.count == 1) {//如果有原来记录,则直接使用原coreData对象
                                            
                                            document = [[results objectAtIndex:0] retain];
                                            
                                            if ([document.newsCenterCategory.uid isEqualToString:category.uid])
                                            {
                                                
                                            }
                                            else
                                            {
                                                [category addRelationshipToNewsCategoryObject:document];
                                            }
                                        }
                                        else {
                                            //如果没有记录则新建记录
                                            document = [[NewsCenterDocument alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                            
                                            [category addRelationshipToNewsCategoryObject:document];
                                        }
                                    }
                                    
                                    document.uid = [NSString stringWithFormat:@"%@",messageItemGuid];
                                    
                                    NSString *typename = [itemDic objectForKey:@"typename"];
                                    
                                    if (isValid(typename))
                                    {
                                        document.typeName = typename;
                                    }
                                    
                                    NSString *title = [itemDic objectForKey:@"name"];
                                    
                                    if (isValid(title))
                                    {
//                                        if (isValid(typename) && ![typename isEqualToString:@""])
//                                        {
//                                            document.title = [NSString stringWithFormat:@"[%@] %@",typename,title];
//                                        }
//                                        else
//                                        {
                                            document.title = title;
//                                        }
                                    }
                                    
                                    NSString *generateDate = [itemDic objectForKey:@"regdate"];
                                    
                                    if (isValid(generateDate)) {
                                        
                                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                        if ([generateDate length]<=10) {
                                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                                        }else{
                                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                        }
                                        document.generateDate = [dateFormatter dateFromString:generateDate];
                                        [dateFormatter release];
                                    }
                                                                                                                                                                                    
                                    NSString *typeID = [itemDic objectForKey:@"typeid"];
                                    
                                    if (isValid(typeID)) {
                                        document.typeID = typeID;
                                    }
                                    
                                    NSString *playUrl = [itemDic objectForKey:@"url"];
                                    
                                    if (isValid(playUrl))
                                    {
                                        document.url = playUrl;
                                    }
                                    
                                    document.type = [NSNumber numberWithInt:category.newsType];
                                    
                                    //将界面的搜索关键词给接口返回的搜索结果数据，作为为谓词查询的标示
                                    document.onlineKeyword = category.keyword;
                                    
                                    NSString *newMark = [itemDic objectForKey:@"newmark"];
                                    
                                    if (isValid(newMark))
                                    {
                                        document.newsMark = [NSNumber numberWithBool:[newMark boolValue]];
                                    }
                                    
                                    NSString *msgTypeId = [itemDic objectForKey:@"msgtypeid"];
                                    
                                    if (isValid(msgTypeId))
                                    {
                                        document.msgTypeID = msgTypeId;
                                    }
                                    
                                    [document release];
                                    
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

+(NSMutableArray *)parserNewsCenterPDFListWith:(NSData *)data
{
    NSMutableArray *resultArr = [[[NSMutableArray alloc] init] autorelease];
    
    NSError *error = nil;
    
    if (!data)
        return nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (isValid(bodyDictionary) && !error)
    {
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        if (isValid(ret)) {
            
            if (![ret isEqualToString:@"0"]) {
                
                return nil;
            }
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
            
        }
        
        if (isValid(bodyDictionary) && !error)
        {
            NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
            
            if (isValid(bizdata)) {
                
                NSDictionary *bizdataDic = [bizdata objectMetaForKey:@"data"];
                
                if (isValid(bizdataDic))
                {
                    NSDictionary *attachmenturlsDic = [bizdataDic objectForKey:@"attachmenturls"];
                    
                    if (isValid(attachmenturlsDic))
                    {
                        NSArray *itemList = [attachmenturlsDic objectForKey:@"data"];
                        
                        if (isValid(itemList))
                        {
                            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                            
                            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterPDF class]) inManagedObjectContext:context];
                            
                            //先查询用户的公文流转栏目列表的历史记录
                            NSFetchRequest *request=[[NSFetchRequest alloc] init];
                            
                            [request setEntity:entityDescription];
                            
                            for (NSDictionary *dic in itemList)
                            {
                                NSString *url = [dic objectForKey:@"url"];
                                
                                if (isValid(url))
                                {
                                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@ && url == %@",[Userinfo shareUserinfo].uid,url];
                                    
                                    [request setPredicate:predicate];
                                    
                                    NSError *error = nil;
                                    
                                    NSArray *results = [context executeFetchRequest:request error:&error];
                                    
                                    NewsCenterPDF *pdfFile = nil;
                                    
                                    if (isValid(results) && !error) {
                                        
                                        if (results.count == 1) {//如果有原来记录,则直接使用原coreData对象
                                            
                                            pdfFile = [[results objectAtIndex:0] retain];
                                        }
                                        else {
                                            //如果没有记录则新建记录
                                            pdfFile = [[NewsCenterPDF alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                            
                                            pdfFile.url = url;
                                            
                                            pdfFile.userId = [Userinfo shareUserinfo].uid;
                                        }
                                    }
                                    
                                    NSString *title = [dic objectForKey:@"name"];
                                    
                                    if (isValid(title))
                                    {
                                        pdfFile.name = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
                                    }
                                    
                                    [resultArr addObject:pdfFile];
                                    
                                    [pdfFile release];
                                }
                            }
                            
                            [request release];
                            
                            NSError *error = nil;
                            
                            BOOL result = [context save:&error];
                            
                            if (!result) {
                                
                                DLog(@"%@",error);
                            }
                            else {
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    return resultArr;
}

+(NSDictionary *)parserNewsCenterPDFAndContentWith:(NSData *)data andDocumentID:(NSString *)documentID
{
    NSMutableDictionary *resultDic = [[[NSMutableDictionary alloc] init] autorelease];
    NSMutableArray *resultArr = [[[NSMutableArray alloc] init] autorelease];
    
    NSError *error = nil;
    
    if (!data)
        return nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (isValid(bodyDictionary) && !error)
    {
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        if (isValid(ret)) {
            
            if (![ret isEqualToString:@"0"]) {
                
                return nil;
            }
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
            NSLog(@"%@",retMsg);
        }
        
        if (isValid(bodyDictionary) && !error)
        {
            NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
            
            if (isValid(bizdata)) {
                
                NSDictionary *bizdataDic = [bizdata objectMetaForKey:@"data"];
                
                if (isValid(bizdataDic))
                {
                    NSDictionary *attachmenturlsDic = [bizdataDic objectForKey:@"attachmenturls"];
                    
                    if (isValid(attachmenturlsDic) && [attachmenturlsDic isKindOfClass:[NSDictionary class]] && [[attachmenturlsDic allKeys] containsObject:@"data"])
                    {
                        NSArray *itemList = [attachmenturlsDic objectForKey:@"data"];
                        
                        if (isValid(itemList))
                        {
                            NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                            
                            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterPDF class]) inManagedObjectContext:context];
                            
                            //先查询用户的公文流转栏目列表的历史记录
                            NSFetchRequest *request=[[NSFetchRequest alloc] init];
                            
                            [request setEntity:entityDescription];
                            
                            for (NSDictionary *dic in itemList)
                            {
                                NSString *url = [dic objectForKey:@"url"];
                                
                                if (isValid(url))
                                {
                                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@ && url == %@",[Userinfo shareUserinfo].uid,url];
                                    
                                    [request setPredicate:predicate];
                                    
                                    NSError *error = nil;
                                    
                                    NSArray *results = [context executeFetchRequest:request error:&error];
                                    
                                    NewsCenterPDF *pdfFile = nil;
                                    
                                    if (isValid(results) && !error) {
                                        
                                        if (results.count == 1) {//如果有原来记录,则直接使用原coreData对象
                                            
                                            pdfFile = [[results objectAtIndex:0] retain];
                                        }
                                        else {
                                            //如果没有记录则新建记录
                                            pdfFile = [[NewsCenterPDF alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                            
                                            pdfFile.url = url;
                                            
                                            pdfFile.userId = [Userinfo shareUserinfo].uid;
                                        }
                                    }
                                    
                                    NSString *title = [url lastPathComponent];
                                    
                                    if (isValid(title))
                                    {
                                        pdfFile.name = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
                                    }
                                    
                                    [resultArr addObject:pdfFile];
                                    
                                    [pdfFile release];
                                }
                            }
                            
                            [request release];
                            
                            NSError *error = nil;
                            
                            BOOL result = [context save:&error];
                            
                            if (!result) {
                                
                                DLog(@"%@",error);
                            }
                            else {
                                
                            }
                        }
                    }
                    
                    [resultDic setObject:resultArr forKey:@"PDFArr"];
                    
                    NSString *content = [bizdataDic objectForKey:@"content"];

                    if (isValid(content)&&![content isEqualToString:@""]) {
                        //                   存储content
                        NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                        
                        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterContent class]) inManagedObjectContext:context];
                        
                        //先查询用户的公文流转栏目列表的历史记录
                        NSFetchRequest *request=[[NSFetchRequest alloc] init];
                        
                        [request setEntity:entityDescription];
                        
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && uid == %@",[Userinfo shareUserinfo].uid,documentID];
                        
                        [request setPredicate:predicate];
                        
                        NSError *error = nil;
                        
                        NSArray *results = [context executeFetchRequest:request error:&error];
                        
                        NewsCenterContent *newsCenterContent = nil;
                        
                        if (isValid(results) && !error) {
                            
                            if (results.count == 1) {//如果有原来记录,则直接使用原coreData对象
                                
                                newsCenterContent = [[results objectAtIndex:0] retain];
                            }
                            else {
                                //如果没有记录则新建记录
                                newsCenterContent = [[NewsCenterContent alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                newsCenterContent.userid = [Userinfo shareUserinfo].uid;
                                newsCenterContent.uid = documentID;
                            }
                            
                            
                        }
                        
                        NSString *contentS = [content stringByReplacingOccurrencesOfString:@"<img " withString:@"<img width=\"95%\" "];
                        
                        contentS = [contentS stringByReplacingOccurrencesOfString:@"<IMG " withString:@"<IMG width=\"95%\" "];
                        
                        contentS = [NSString stringWithFormat:@"<div style=\"font-family:'黑体-简';font-size:50px;line-height:70px\">%@</div>",contentS];
                        
                        newsCenterContent.content = contentS;
                        
                        NSString *author = [bizdataDic objectForKey:@"author"];
                        if (isValid(author)&&![author isEqualToString:@""]) {
                            newsCenterContent.author = author;
                            [resultDic setObject:author forKey:@"author"];
                        }
                        
                        NSString *source = [bizdataDic objectForKey:@"source"];
                        if (isValid(source)&&![source isEqualToString:@""]) {
                            newsCenterContent.source = source;
                            [resultDic setObject:source forKey:@"source"];
                        }
                        
                        NSError *bError = nil;
                        
                        BOOL result = [context save:&bError];
                        
                        if (!result) {
                            
                            DLog(@"%@",bError);
                        }
                        else {
                            
                        }
                        [resultDic setObject:contentS forKey:@"content"];
                    }
                    
                }
            }
        }
    }
    
    return resultDic;
}

+(NSArray *)parserNewsCenterNewsType:(NSData *)data{
    NSError *error = nil;
    
    if (!data)
        return nil;
    
    NSDictionary *bodyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (isValid(bodyDictionary) && !error)
    {
        
        NSString *ret = [bodyDictionary objectForKey:@"ret"];
        
        if (isValid(ret)) {
            
            if (![ret isEqualToString:@"0"]) {
                
                return nil;
            }
        }
        
        NSString *retMsg = [bodyDictionary objectForKey:@"retMsg"];
        
        if (isValid(retMsg)) {
            
            
        }
        
        NSDictionary *bizdata = [bodyDictionary objectForKey:@"bizdata"];
        NSArray *dataArr = [bizdata objectForKey:@"data"];
        
        if (isValid(dataArr) && [dataArr count] > 0)
        {
            NSDictionary *dataDic = [dataArr objectAtIndex:0];
            
            if (isValid(dataDic) && [dataDic isKindOfClass:[NSDictionary class]] && [[dataDic allKeys] containsObject:@"newstypes"]) {
                NSDictionary *newstypesDic = [dataDic objectForKey:@"newstypes"];
                
                if (isValid(newstypesDic) && [newstypesDic isKindOfClass:[NSDictionary class]] && [[newstypesDic allKeys] containsObject:@"data"])
                {
                    NSArray *itemList = [newstypesDic objectForKey:@"data"];
                    
                    if (isValid(itemList)) {
                        
                        NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
                        
                        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterNewsType class]) inManagedObjectContext:context];
                        
                        //先查询用户的公文流转栏目列表的历史记录
                        NSFetchRequest *request=[[NSFetchRequest alloc] init];
                        
                        [request setEntity:entityDescription];
                        
                        for (NSDictionary *itemDic in itemList) {
                            
                            NSString *messageItemGuid = [itemDic objectForKey:@"id"];
                            
                            if (isValid(messageItemGuid)) {
                                
                                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && uid == %@",[Userinfo shareUserinfo].uid,messageItemGuid];
                                
                                [request setPredicate:predicate];
                                
                                NSError *error = nil;
                                
                                NSArray *results = [context executeFetchRequest:request error:&error];
                                
                                NewsCenterNewsType *type = nil;
                                
                                if (isValid(results) && !error) {
                                    
                                    if (results.count == 1) {//如果有原来记录,则直接使用原coreData对象
                                        
                                        type = [[results objectAtIndex:0] retain];
                                    }
                                    else {
                                        //如果没有记录则新建记录
                                        type = [[NewsCenterNewsType alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                                    }
                                }
                                
                                type.uid = [NSString stringWithFormat:@"%@",messageItemGuid];
                                
                                type.userid = [Userinfo shareUserinfo].uid;
                                
                                NSString *title = [itemDic objectForKey:@"name"];
                                
                                if (isValid(title)) {
                                    type.name = title;
                                }
                                
                                [type release];
                                
                            }
                            
                        }
                        
                        [request release];
                        
                        NSError *error = nil;
                        
                        BOOL result = [context save:&error];
                        
                        if (!result) {
                            
                            DLog(@"%@",error);
                        }
                        else {
                            
                            return itemList;
                        }
                    }
                }
                
            }
        }
    }
    
    return nil;
}

+(NSString *)getNewsTypeIdByName:(NSString *)typeName{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterNewsType class]) inManagedObjectContext:context];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && name == %@",[Userinfo shareUserinfo].uid,typeName];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (isValid(results) && !error) {
        
        if (results.count >= 1) {//如果有原来记录,则直接使用原coreData对象
            
            NewsCenterNewsType *type = [results objectAtIndex:0];
            return type.uid;
        }
        else {
            //如果没有记录则新建记录
            return @"";
        }
    }
    return @"";
}


+(NSString *)getNewsTypeIdByID:(NSString *)typeID{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterNewsType class]) inManagedObjectContext:context];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && uid == %@",[Userinfo shareUserinfo].uid,typeID];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (isValid(results) && !error) {
        
        if (results.count >= 1) {//如果有原来记录,则直接使用原coreData对象
            
            NewsCenterNewsType *type = [results objectAtIndex:0];
            return type.name;
        }
        else {
            //如果没有记录则新建记录
            return @"";
        }
    }
    return @"";
}

+(NSString *)getContentByDocument:(NSString *)documentID{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([NewsCenterContent class]) inManagedObjectContext:context];
    
    //先查询用户的公文流转栏目列表的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid == %@ && uid == %@",[Userinfo shareUserinfo].uid,documentID];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (isValid(results) && !error) {
        
        if (results.count >= 1) {//如果有原来记录,则直接使用原coreData对象
            
            NewsCenterContent *type = [results objectAtIndex:0];
            return type.content;
        }
        else {
            //如果没有记录则新建记录
            return @"";
        }
    }
    return @"";
}


@end
