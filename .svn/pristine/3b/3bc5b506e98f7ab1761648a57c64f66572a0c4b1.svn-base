//
//  MyAppCenterNetRequest.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/13.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "MyAppCenterNetRequest.h"

@implementation MyAppCenterNetRequest

- (void)requestForAppTypeList
{
    self.requestDescription = @"获取应用分类";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"appmgr" forKey:kBizCode];
    [bodyDictionary setObject:@"AppMgrAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getAppTypes" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [dataDictionary release];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

- (void)requestForAppList
{
    self.requestDescription = @"获取应用列表";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"appmgr" forKey:kBizCode];
    [bodyDictionary setObject:@"AppMgrAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getAppsByType" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:3];
    
    //应用类型
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"appType"];
    //应用分页大小
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"size"];
    //筛选日期
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"queryDate"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [dataDictionary release];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

@end
