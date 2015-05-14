//
//  SettingNetRequest.m
//  Setting
//
//  Created by kangqijun on 13-11-8.
//  Copyright (c) 2013年 kangqijun. All rights reserved.
//

#import "SettingNetRequest.h"

@implementation SettingNetRequest

/*********************************************************************
 Function description:修改密码请求
 Parameter: N/A
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
-(void)changePassword
{
    self.requestDescription = @"修改密码请求";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"modifyPwd" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"newpassword"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"password"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"token"];
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
 Function description:绑定设备请求
 Parameter: N/A
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
-(void)setBlindDevice
{
    self.requestDescription = @"设备绑定";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"bindDevice" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"flag"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"password"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"token"];
    
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


- (void)changePersonInfo
{
    self.requestDescription = @"个人信息";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    request.timeOutSeconds = 10;
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"updatePerData" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"tel"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"email"];
    
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

- (void)changePersonDetailInfo
{
    self.requestDescription = @"个人信息";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    request.timeOutSeconds = 10;
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"updatePerDetailData" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"loginName"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"duty"];
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"tel"];
    [dataDictionary setObject:[_argList objectAtIndex:4] forKey:@"bakTel"];
    [dataDictionary setObject:[_argList objectAtIndex:5] forKey:@"officeTel"];
    [dataDictionary setObject:[_argList objectAtIndex:6] forKey:@"bakOfficeTel"];
    [dataDictionary setObject:[_argList objectAtIndex:7] forKey:@"perEmail"];
    
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
