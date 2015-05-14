//
//  NetUniformInterface+DataHandle.h
//  MIP
//
//  Created by Sea on 13-9-16.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "NetUniformInterface.h"

extern NSString * baseURL;//基础服务地址
extern NSString * downloadURL;//下载服务地址
extern NSString * uploadURL;//上传服务地址

extern

@interface NetUniformInterface (DataHandle)


@property (nonatomic,retain) NSString  * requestDescription;//请求描述


/*!
 @function
 @abstract      封装请求信息
 
 @param         bodyValue                   需要封装的body键值对
 
 @result        对请求的描述
 */
//TODO: 封装请求信息
- (NSDictionary *)netRequestPostDataPackage:(NSDictionary *)bodyValue;



/*!
 @function
 @abstract      从请求响应数据中获取出body的信息
 
 @param         bodyValue                   参数字典
 @param         identify                    模块标识
 
 @result        从响应数据中提取出的body数据
 */
+ (NSData *)extractDataBodyFromResponsePackage:(NSData *)responseData;



/*!
 @function 
 @abstract      如果响应数据是zip包,其中zip中包含文件及data.json文件及其他文件,返回data.json中body的字符串并将其他文件移动到目标文件夹下 并给其他文件重新随机命名 
 
 @note          zip包中只包含data.json文件及令一文件responseDatae 的编码格式为UTF-8
 
 @param         responseData                zip包数据
 @param         path                        文件移动的目标文件夹
 @param         filePath                    新文件名内存地址
 
 @result
 */
+ (NSData *)extractDataBodyFromResponsePackage:(NSData *)responseData destinationPath:(NSString *)folder filePath:(NSString **)fileName;



/*!
 @function
 @abstract      如果响应数据是zip包,其中zip中包含文件及data.json文件及其他文件,返回data.json中body的字符串并将其他文件移动到目标文件夹下 并给其他文件重新随机命名
 
 @note          zip包中只包含data.json文件及令一文件responseDatae 的编码格式为UTF-8
 
 @param         zipPath                     zip包路径
 @param         path                        文件移动的目标文件夹
 @param         filePath                    新文件名内存地址
 
 @result
 */
+ (NSData *)extractDataBodyFromZipPackage:(NSString *)zipPath destinationPath:(NSString *)folder filePath:(NSString **)fileName;


- (NSData *)packagingData:(NSData *)data attachmentPath:(NSString *)path;

@end


@interface NSData(ToNSString)

-(NSString *)ConvertToNSString;

@end

@interface NSString (NSStringHexToBytes)

-(NSData*) hexStringToNSData ;

@end