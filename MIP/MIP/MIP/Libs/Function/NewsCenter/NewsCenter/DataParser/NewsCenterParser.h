//
//  NewsCenterParser.h
//  NewsCenter
//
//  Created by wanghao on 14-3-14.
//
//

#import <Foundation/Foundation.h>
#import "NewsCenterCategory.h"

@interface NewsCenterParser : NSObject
+(BOOL)parserNewsCenterWith:(NSData *)data;

+(BOOL)parserNewsCenterDocumentWith:(NSData *)data category:(NewsCenterCategory *)newsCenterCategory;

+(NSDictionary *)parserNewsCenterPDFAndContentWith:(NSData *)data andDocumentID:(NSString *)documentID;

+(NSMutableArray *)parserNewsCenterPDFListWith:(NSData *)data;

+(NSArray *)parserNewsCenterNewsType:(NSData *)data;

+(NSString *)getNewsTypeIdByName:(NSString *)typeName;

+(NSString *)getNewsTypeIdByID:(NSString *)typeID;

+(NSString *)getContentByDocument:(NSString *)documentID;
@end
