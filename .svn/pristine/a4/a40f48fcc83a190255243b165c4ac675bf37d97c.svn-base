//
//  LoginNetRequest.m
//  Login
//
//  Created by Sea on 13-9-16.
//  Copyright (c) 2013年 Sea. All rights reserved.
//


#import "LoginNetRequest.h"

#import "NSString+MD5Encrypt.h"

@implementation LoginNetRequest


static ASIHTTPRequest *request  = nil;

/*********************************************************************
 Function description:登录请求
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (void)login
{

    self.requestDescription = @"loginRequest";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:downloadURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getLoginSSO" forKey:kMethodName];
  
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:3] ;
    [dataDictionary setObject:@"1.0" forKey:@"preversion"];
    
//    NSString *password = [[_argList objectAtIndex:0] md5EncryptUsingEncoding:NSUTF8StringEncoding];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"password"];
    [dataDictionary setObject:@"127.0.0.1" forKey:@"ip"];
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    
    [dataDictionary release];
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

/*********************************************************************
 Function description:启动宣传画面路径获取
 Parameter: N/A
 Return value: N/A
 Author: lu_sicong
 Remark:
 *********************************************************************/
- (void)launchImageGet
{
    self.requestDescription = @"getIPhonePicList";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:20];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getPhonePicList" forKey:kMethodName];
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:0] ;

    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

/*********************************************************************
 Function description:返回请求对象
 Parameter:N/A
 Return value: ASIHTTPRequest
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(ASIHTTPRequest*)RequestObject
{
    return request;
}

- (void)postDevToken
{
    self.requestDescription = @"postDevToken";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"UpdateUserImsi" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:3] ;
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"tokenId"];
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    
    [dataDictionary release];
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

//获取模块未读数
- (void)getModuleBadge
{
    self.requestDescription = @"getModuleBadge";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getModuleNoReadCount" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:3];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"funcid"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

//获取短信验证码
- (void)getRandomCode
{
    self.requestDescription = @"getRandomCode";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"common" forKey:kBizCode];
    [bodyDictionary setObject:@"SMSVerifyAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getRandomCode" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:3];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"phoneNum"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

//验证短信验证码
- (void)verifyRandomCode
{
    self.requestDescription = @"verifyRandomCode";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"common" forKey:kBizCode];
    [bodyDictionary setObject:@"SMSVerifyAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"verifyRandomCode" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:3];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"phoneNum"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"randomCode"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

@end
