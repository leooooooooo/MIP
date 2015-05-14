//
//  NewsCenterBLL.h
//  NewsCenter
//
//  Created by wanghao on 14-3-14.
//
//

#import <Foundation/Foundation.h>

@class NewsCenterCategory;
@class NewsCenterDocument;

typedef void(^GetValidData)(id data, NSError *error);

@interface NewsCenterBLL : NSObject

+(void)getNewsCenterCategorys:(NSData *)data;

+(void)synchroniseNewsCenterDocuments:(NSData *)data category:(NewsCenterCategory *)category;

+(NSDictionary *)getNewsCenterPDFAndContent:(NSData *)data andDocumentID:(NSString *)documentID;

+(NSMutableArray *)getNewsCenterPDFList:(NSData *)data;

+(NSArray *)synchroniseNewsCenterNewsType:(NSData *)data;

+(NSString *)getNewsTypeIdByName:(NSString *)typeName;

+(NSString *)getNewsTypeNameByID:(NSString *)typeID;

+(NSString *)getContentByDocument:(NSString *)documentID;

@end
