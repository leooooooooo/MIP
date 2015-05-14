//
//  ContactsNetRequest.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/11.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ContactsNetRequest.h"

@implementation ContactsNetRequest

- (void) requestForGroupContacts
{
    self.requestDescription = @"获取组织通讯录";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"contact" forKey:kBizCode];
    [bodyDictionary setObject:@"ContactAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getEncContacts" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"company"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"department"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"duties"];
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
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

- (void) requestForPersonalContacts
{
    self.requestDescription = @"获取个人通讯录";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"contact" forKey:kBizCode];
    [bodyDictionary setObject:@"ContactAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getPerContacts" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"companyid"];
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

- (void) requestForSearchContacts
{
    self.requestDescription = @"检索个人通讯录";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"contact" forKey:kBizCode];
    [bodyDictionary setObject:@"ContactAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getStaffContactList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"filter"];
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

- (void) requestForFullCompany
{
    self.requestDescription = @"获取全部企业列表";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"contact" forKey:kBizCode];
    [bodyDictionary setObject:@"ContactAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getEnterList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:0] ;
//    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
//    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"companyid"];
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
