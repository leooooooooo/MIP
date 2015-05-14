//
//  MainNetRequest.m
//  Main
//
//  Created by lixiangai on 14-2-20.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "MainNetRequest.h"
#import "NSString+MD5Encrypt.h"
#import "Module.h"

@implementation MainNetRequest
static ASIHTTPRequest *request  = nil;

-(void)getModuleNoReadCount
{
    self.requestDescription = @"moduleUnreadRequest";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getModuleNoReadCount" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:@"" forKey:@"funcid"];
    [dataDictionary setObject:@"" forKey:@"funccode"];
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

//签到接口
- (void)updataSignInPlace
{
    self.requestDescription = @"updataSignInPlaceRequest";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"sign" forKey:kBizCode];
    [bodyDictionary setObject:@"SignAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"signIn" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"location"];
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

//获取签到列表
- (void)getSignList
{
    self.requestDescription = @"getSignListRequest";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"sign" forKey:kBizCode];
    [bodyDictionary setObject:@"SignAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getSignList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
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


-(void)getNextModuleList
{
    self.requestDescription = @"getNextModuleList";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getNextModuleList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    //funcid    主菜单
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"funcid"];
    
    //type	类型（0目录、1按钮）
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"type"];
    
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

-(void)getMessageList
{
    self.requestDescription = @"getMessageList";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getMessageList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    //funcid    主菜单
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    
    //type	类型（0目录、1按钮）
    [dataDictionary setObject:userInfo.uid forKey:@"loginName"];
    
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

-(void)getNewsCenterCategory{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getNextModuleList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //funcId	父及目录的id
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"funcid"];
    
    //type	类型（0目录、1按钮）
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"type"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [dataDictionary release];
    
    request.userInfo = [NSDictionary dictionaryWithObject:[_argList objectAtIndex:2] forKey:@"Category"];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ([self.requestDescription isEqualToString:@"getNewsCenterDocument"])
    {
        [self requestFinishedCallBack:request error:nil];
    }
    else
    {
        [self requestFinishedCallBack:request.responseData error:nil];
    }
}

@end
