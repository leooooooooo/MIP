//
//  NetUniformInterface+DataHandle.m
//  MIP
//
//  Created by Sea on 13-9-16.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "NetUniformInterface+DataHandle.h"

#import "ZipArchive.h"

#import "NSData+Encrypt.h"

#import "Userinfo.h"

#import <objc/runtime.h>

static NSString *bodySecurityKey = @"HOPERUN.COM";//body加密密钥
static NSString *paddingKey = @"0102030405060708";

//亮仔环境
//const NSString * baseURL = @"http://10.20.108.112:8080/mipserv/server/baseServlet";//基础服务地址
//const NSString * downloadURL = @"http://10.20.108.112:8080/mipserv/server/download";//下载服务地址
//const NSString * uploadURL = @"http://10.20.108.112:8080/mipserv/server/upload";//上传服务地址

//const NSString * baseURL = @"http://10.20.108.201:8080/mipserv/server/baseServlet";//基础服务地址
//const NSString * downloadURL = @"http://10.20.108.201:8080/mipserv/server/download";//下载服务地址
//const NSString * uploadURL = @"http://10.20.108.201:8080/mipserv/server/upload";//上传服务地址

//生产环境
const NSString * baseURL = @"http://218.92.115.48:8080/mipserv/server/baseServlet";//基础服务地址
const NSString * downloadURL = @"http://218.92.115.48:8080/mipserv/server/download";//下载服务地址
const NSString * uploadURL = @"http://218.92.115.48:8080/mipserv/server/upload";//上传服务地址

static char requestDescriptionKey;

@implementation NetUniformInterface (DataHandle)

/*!
 @function
 @abstract      为请求描述添加setter方法
 
 @param         aRequestDescription             对请求的描述
 
 @result
 */
//TODO: 为请求描述添加setter方法
- (void)setRequestDescription:(NSString *)aRequestDescription {
    
    objc_setAssociatedObject(self, &requestDescriptionKey, aRequestDescription, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



/*!
 @function
 @abstract      为请求描述添加getter方法
 
 @result        对请求的描述
 */
//TODO: 为请求描述添加getter方法
- (NSString *)requestDescription {
    
    return objc_getAssociatedObject(self, &requestDescriptionKey);
}



/*!
 @function
 @abstract      封装请求信息
 
 @param         bodyValue                       需要封装的body键值对
 
 @result        对请求的描述
 */
//TODO: 封装请求信息
- (NSDictionary *)netRequestPostDataPackage:(NSDictionary *)bodyValue {
    
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    NSMutableDictionary *headDic = [[NSMutableDictionary alloc] initWithCapacity:11];
    
    Userinfo *userinfo = [Userinfo shareUserinfo];
    
    if (userinfo.appId) {//应用id
        
        [headDic setObject:userinfo.appId forKey:@"appId"];
    }
    else {
        
        [headDic setObject:@"" forKey:@"appId"];
    }
    
    if (userinfo.appVersion) {//应用版本
        
        [headDic setObject:userinfo.appVersion forKey:@"appVersion"];
    }
    else {
     
        [headDic setObject:@"" forKey:@"appVersion"];
    }
    
    if (userinfo.deviceId) {//设备唯一标识符
        
        [headDic setObject:userinfo.deviceId forKey:@"deviceId"];
    }
    else {
        
        [headDic setObject:@"" forKey:@"deviceId"];
    }
    
    if (userinfo.deviceType) {//设备类型
        
        [headDic setObject:userinfo.deviceType forKey:@"deviceType"];
    }
    else {
        
        [headDic setObject:@"iPhone" forKey:@"deviceType"];
    }
    
    if (userinfo.OSVersion) {//系统类型及版本
        
        [headDic setObject:userinfo.OSVersion forKey:@"OSVersion"];
    }
    else {
        
        [headDic setObject:@"" forKey:@"OSVersion"];
    }
    
    if (userinfo.deptID) {//用户部门
        
        [headDic setObject:userinfo.deptID forKey:@"userDept"];
    }
    else {
        
        [headDic setObject:@"" forKey:@"userDept"];
    }
    
    if (userinfo.name) {//用户登录名
        
        [headDic setObject:userinfo.name forKey:@"userId"];
    }
    else {
        
        [headDic setObject:@"" forKey:@"userId"];
    }
        
    [headDic setObject:@"" forKey:@"sessionId"];//会话标识
    
    [headDic setObject:[[NSDate date] description] forKey:@"requestDateTime"];//请求时间
    
    if (self.requestDescription) {//请求描述
        
        [headDic setObject:self.requestDescription forKey:@"requestDescription"];
    }
    else {
        
        [headDic setObject:@"" forKey:@"requestDescription"];
    }
    
    [requestDic setObject:headDic forKey:@"header"];
    
    [headDic release];
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyValue options:NSJSONWritingPrettyPrinted error:NULL];
    
    NSData *encryBodyData = [bodyData cipherByAES:paddingKey
                                       ivEncoding:NSUTF8StringEncoding
                                              key:bodySecurityKey
                                      keyEncoding:NSUTF8StringEncoding
                                        operation:kCCEncrypt];
    
    [requestDic setObject:[encryBodyData ConvertToNSString] forKey:@"body"];
    
    return [requestDic autorelease];
    
}


/*!
 @function
 @abstract      从请求响应数据中获取出body的信息
 
 @param         bodyValue                   参数字典
 @param         identify                    模块标识
 
 @result        从响应数据中提取出的body数据
 */
//TODO: 从返回报文中提取数据体
+ (NSData *)extractDataBodyFromResponsePackage:(NSData *)responseData {
    
    //判断是否获取到返回信息
    if (responseData && [responseData length]) {
        
        NSError *error = nil;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        
        //判断解析数据是否正确
        if (isValid(dic) && !error) {
            
            NSDictionary *headerDic = [dic objectForKey:@"header"];
            
            NSInteger retCode = [[headerDic objectForKey:@"retCode"] integerValue];
            
            if (!retCode) {
                
                NSString *hexString = [dic objectForKey:@"body"];
                
                NSData *bodyData = [hexString hexStringToNSData];
                
                NSData *decryptData = [bodyData cipherByAES:paddingKey ivEncoding:NSUTF8StringEncoding key:bodySecurityKey keyEncoding:NSUTF8StringEncoding operation:kCCDecrypt];
                
                return decryptData;
            }
            else {
                
                
            }
        }
    }
    
    return nil;
}



/*!
 @function
 @abstract      如果响应数据是zip包,其中zip中包含文件及data.json文件及其他文件,返回data.json中body的字符串并将其他文件移动到目标文件夹下 并给其他文件重新随机命名
 
 @note          zip包中只包含data.json文件及令一文件responseDatae 的编码格式为UTF-8
 
 @param         responseData                zip包数据
 @param         path                        文件移动的目标文件夹
 @param         filePath                    新文件名内存地址
 
 @result
 */
+ (NSData *)extractDataBodyFromResponsePackage:(NSData *)responseData destinationPath:(NSString *)folder filePath:(NSString **)fileName {
    
    NSString *zipPath = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/elibom.zip"];
    NSString *zipFolder = [zipPath stringByDeletingPathExtension];
    
    [responseData writeToFile:zipPath atomically:YES];//将服务端返回的zip包写成文件
    
    ZipArchive *zip = [[ZipArchive alloc] init];
    
    if ([zip UnzipOpenFile:zipPath]) {
        
        [zip UnzipFileTo:zipFolder overWrite:YES];
        
        [zip UnzipCloseFile];
    }
    
    [zip release];
    
    NSString *dataJson = [zipFolder stringByAppendingPathComponent:@"data.json"];//拼接data.json文件路径
    NSData *data = [[[NSData alloc] initWithContentsOfFile:dataJson] autorelease];//获取data.json里面的数据
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager removeItemAtPath:dataJson error:NULL];//删除data.json文件
    
    NSArray *subDir = [manager subpathsOfDirectoryAtPath:zipFolder error:nil];//取出临时文件夹的所有文件名称
    
    if (subDir.count > 0) {//只获取第一个文件
        
        NSString *subFileName = [subDir objectAtIndex:0];//非data.json文件名
        NSString *extension = [subFileName pathExtension];//非data.json文件的后缀名
        
        if (extension && extension.length > 0) {
            
            //给里面的非data.json文件重新生成名字
            CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
            CFStringRef uuid = CFUUIDCreateString(kCFAllocatorDefault, uuidObject);
            CFRelease(uuidObject);
            
            if (fileName) {
                
                *fileName = [(NSString *)uuid stringByAppendingPathExtension:extension];//生成新文件名
                
                [manager moveItemAtPath:[zipFolder stringByAppendingPathComponent:subFileName] toPath:[folder stringByAppendingPathComponent:*fileName] error:NULL];
            }
            
            CFRelease(uuid);
        }
    }
    
    [manager removeItemAtPath:zipFolder error:NULL];//删除解压的临时文件夹
    
    [manager removeItemAtPath:zipPath error:NULL];//删除zip包
    
    return [self extractDataBodyFromResponsePackage:data];
}



/*!
 @function
 @abstract      如果响应数据是zip包,其中zip中包含文件及data.json文件及其他文件,返回data.json中body的字符串并将其他文件移动到目标文件夹下 并给其他文件重新随机命名
 
 @note          zip包中只包含data.json文件及令一文件responseDatae 的编码格式为UTF-8
 
 @param         zipPath                     zip包路径
 @param         path                        文件移动的目标文件夹
 @param         filePath                    新文件名内存地址
 
 @result
 */
+ (NSData *)extractDataBodyFromZipPackage:(NSString *)zipPath destinationPath:(NSString *)folder filePath:(NSString **)fileName {
    
    NSString *zipFolder = [zipPath stringByDeletingPathExtension];
    
    ZipArchive *zip = [[ZipArchive alloc] init];
    
    if ([zip UnzipOpenFile:zipPath]) {
        
        [zip UnzipFileTo:zipFolder overWrite:YES];
        
        [zip UnzipCloseFile];
    }
    
    [zip release];
    
    NSString *dataJson = [zipFolder stringByAppendingPathComponent:@"data.json"];//拼接data.json文件路径
    NSData *data = [[[NSData alloc] initWithContentsOfFile:dataJson] autorelease];//获取data.json里面的数据
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager removeItemAtPath:dataJson error:NULL];//删除data.json文件
    
    NSArray *subDir = [manager subpathsOfDirectoryAtPath:zipFolder error:nil];//取出临时文件夹的所有文件名称
    
    if (subDir.count > 0) {//只获取第一个文件
        
        NSString *subFileName = [subDir objectAtIndex:0];//非data.json文件名
        NSString *extension = [subFileName pathExtension];//非data.json文件的后缀名
        
        if (extension && extension.length > 0) {
            
            //给里面的非data.json文件重新生成名字
            CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
            CFStringRef uuid = CFUUIDCreateString(kCFAllocatorDefault, uuidObject);
            CFRelease(uuidObject);
            
            if (fileName) {
                
                *fileName = [(NSString *)uuid stringByAppendingPathExtension:extension];//生成新文件名
                
             
                //lixiangiai  文件加密
//                [manager moveItemAtPath:[zipFolder stringByAppendingPathComponent:subFileName] toPath:[folder stringByAppendingPathComponent:*fileName] error:NULL];
                //end
                 [manager moveItemAtPath:[zipFolder stringByAppendingPathComponent:subFileName] toPath:[folder stringByAppendingPathComponent:(NSString *)uuid] error:NULL];
            }
            
            CFRelease(uuid);
        }
    }
    
    [manager removeItemAtPath:zipFolder error:NULL];//删除解压的临时文件夹
    
    [manager removeItemAtPath:zipPath error:NULL];//删除zip包
    
    return [self extractDataBodyFromResponsePackage:data];
}


- (NSData *)packagingData:(NSData *)data attachmentPath:(NSString *)path {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *tempZip = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"tempZip.zip"];
    NSString *tempJson = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"data.json"];
    
    if ([manager fileExistsAtPath:tempZip]) {
        
        [manager removeItemAtPath:tempZip error:NULL];
    }
    
    if ([manager fileExistsAtPath:tempJson]) {
        
        [manager removeItemAtPath:tempJson error:NULL];
    }
    
    [data writeToFile:tempJson atomically:YES];
    
    ZipArchive *zip = [[ZipArchive alloc] init];
    [zip CreateZipFile2:tempZip];
    
    if (path) {
    
        [zip addFileToZip:path newname:[path lastPathComponent]];
    }
    
    [zip addFileToZip:tempJson newname:@"data.json"];
    
    [zip CloseZipFile2];
    
    [zip release];
    
    NSData *requestData = [NSData dataWithContentsOfFile:tempZip];
    
    [manager removeItemAtPath:tempZip error:NULL];
    [manager removeItemAtPath:tempJson error:NULL];
    
    return requestData;
}

@end


@implementation NSData(ToNSString)

-(NSString *)ConvertToNSString {
    
    
	NSMutableString *strTemp = [NSMutableString stringWithCapacity:[self length]*2];
    
	const unsigned char *szBuffer = [self bytes];
    
	for (NSInteger i=0; i < [self length]; ++i) {
        
		[strTemp appendFormat:@"%02lx",(unsigned long)szBuffer[i]];
        
	}
	return [[strTemp retain] autorelease];
}

@end

@implementation NSString (NSStringHexToBytes)

-(NSData*) hexStringToNSData {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        uint intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
@end