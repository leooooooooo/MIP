//
//  NetDataUniformHandle.h
//  MOA
//
//  Created by  on 13-3-8.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetDataUniformHandle : NSObject

/*!
 @function   
 @abstract   将参数字典加入到请求字典的body键值中   请求字典是header body两个键值
 @param      bodyValue          参数字典
 @param      identify           业务模块标识
 @result     封装完成的请求字典
 */
+ (NSDictionary *)netRequestPostDataPackage:(NSDictionary *)bodyValue moduleIdentify:(NSString *)identify;

/*!
 @function   
 @abstract   从请求响应数据中获取出body的信息     注:responseDatae 的编码格式为UTF-8
 @param      bodyValue          参数字典
 @param      identify           模块标识
 @result     从响应数据中提取出的body数据
 */
+ (NSData *)extractDataBodyFromResponsePackage:(NSData *)responseData;

/*!
 @function   
 @abstract   如果响应数据是zip包,其中zip中包含文件及data.json文件及其他文件,返回data.json中body的字符串并将其他文件移动到目标文件夹下 并给其他文件重新随机命名   注:zip包中只包含data.json文件及令一文件  responseDatae 的编码格式为UTF-8
 @param      responseData       zip包数据
 @param      path               文件移动的目标文件夹
 @param      filePath           新文件名内存地址
 @result      
 */
+ (NSData *)extractDataBodyFromResponsePackage:(NSData *)responseData destinationPath:(NSString *)path filePath:(NSString **)filePath;

/*!
 @function
 @abstract   如果响应数据是zip包,其中zip中包含文件及data.json文件及其他文件,返回data.json中body的字符串并将其他文件移动到目标文件夹下 并给其他文件重新随机命名   注:zip包中只包含data.json文件及令一文件  responseDatae 的编码格式为UTF-8
 @param      zipPath            zip包路径
 @param      path               文件移动的目标文件夹
 @param      filePath           新文件名内存地址
 @result
 */
+ (NSData *)extractDataBodyFromZipPackage:(NSString *)zipPath destinationPath:(NSString *)path filePath:(NSString **)filePath;

/*
+ (NSData *)postDataWithAttach:(NSString *)sourcePath newFileName:(NSString *)newFileName requestDic:(NSDictionary *)requestDic;*/

@end




@interface NSData(ToNSString)

-(NSString *)ConvertToNSString;

@end

@interface NSString (NSStringHexToBytes)

-(NSData*) hexStringToNSData ;

@end
