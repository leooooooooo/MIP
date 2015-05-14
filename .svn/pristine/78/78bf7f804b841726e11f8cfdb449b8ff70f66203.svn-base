//
//  NewsCenterBLL.m
//  NewsCenter
//
//  Created by wanghao on 14-3-14.
//
//

#import "NewsCenterBLL.h"

#import "NewsCenterParser.h"

@implementation NewsCenterBLL

+(void)getNewsCenterCategorys:(NSData *)data{
    [NewsCenterParser parserNewsCenterWith:data];
}

+(void)synchroniseNewsCenterDocuments:(NSData *)data category:(NewsCenterCategory *)category
{
    [NewsCenterParser parserNewsCenterDocumentWith:data category:category];
}

+(NSMutableArray *)getNewsCenterPDFList:(NSData *)data
{
    return [NewsCenterParser parserNewsCenterPDFListWith:data];
}

+(NSDictionary *)getNewsCenterPDFAndContent:(NSData *)data andDocumentID:(NSString *)documentID
{
    return [NewsCenterParser parserNewsCenterPDFAndContentWith:data andDocumentID:documentID];
}


+(NSArray *)synchroniseNewsCenterNewsType:(NSData *)data
{
    return [NewsCenterParser parserNewsCenterNewsType:data];
}

+(NSString *)getNewsTypeIdByName:(NSString *)typeName{
    return [NewsCenterParser getNewsTypeIdByName:typeName];
}

+(NSString *)getNewsTypeNameByID:(NSString *)typeID{
    return [NewsCenterParser getNewsTypeIdByID:typeID];
}

+(NSString *)getContentByDocument:(NSString *)documentID{
    return [NewsCenterParser getContentByDocument:documentID];
}

@end
