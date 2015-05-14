//
//  NewsflashNetRequest.m
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "NewsflashNetRequest.h"

@implementation NewsflashNetRequest

-(void)getTodaySecurity
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
    
    //    [bodyDictionary setObject:@"operdevice" forKey:kBizCode];
    //    [bodyDictionary setObject:@"OperDeviceAdapter" forKey:kBizType];
    //    [bodyDictionary setObject:@"getDevSuperviseList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    //funcid    主菜单
    [dataDictionary setObject:@"f4655e6cad5a427ee043a8640169427e" forKey:@"funcid"];
    
    //type	类型（0目录、1按钮）
    [dataDictionary setObject:@"0" forKey:@"type"];
    
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

-(void)getNewsflash{
    self.requestDescription = @"getNewsflash";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"fastnews" forKey:kBizCode];
    [bodyDictionary setObject:@"FastNewsAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getFastNewsList" forKey:kMethodName];
    
//    [bodyDictionary setObject:@"operdevice" forKey:kBizCode];
//    [bodyDictionary setObject:@"OperDeviceAdapter" forKey:kBizType];
//    [bodyDictionary setObject:@"getDevSuperviseList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //funcId	父及目录的id
    [dataDictionary setObject:[[Userinfo shareUserinfo] token] forKey:@"token"];
    
    //type	类型（0目录、1按钮）
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"listId"];
    
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

-(void)getSecurityDailyList{
    self.requestDescription = @"getSafeNewsList";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getSafeNewsList" forKey:kMethodName];
    
    //    [bodyDictionary setObject:@"operdevice" forKey:kBizCode];
    //    [bodyDictionary setObject:@"OperDeviceAdapter" forKey:kBizType];
    //    [bodyDictionary setObject:@"getDevSuperviseList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //funcId	父及目录的id
    [dataDictionary setObject:[[Userinfo shareUserinfo] token] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"querydate"];
    [dataDictionary setObject:@"20" forKey:@"size"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"keyWord"];
    
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

-(void)getSecurityDailyDetail{
    self.requestDescription = @"getSafeNewsDetail";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getSafeNewsDetail" forKey:kMethodName];
    
    //    [bodyDictionary setObject:@"operdevice" forKey:kBizCode];
    //    [bodyDictionary setObject:@"OperDeviceAdapter" forKey:kBizType];
    //    [bodyDictionary setObject:@"getDevSuperviseList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //funcId	父及目录的id
    [dataDictionary setObject:[[Userinfo shareUserinfo] token] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"newsId"];
    
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

//下载文件
- (void)downloadPDF
{
    NSString *url = [[_argList objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *name = [_argList objectAtIndex:1];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setRequestMethod:@"GET"];
    
    request.delegate = self;
    
    NSError *error = nil;
    
    DownloadRequestDecorator *downLoadRequest = [[DownloadRequestDecorator alloc] initWithASIHTTPRequest:request];
    
    downLoadRequest.delegate = self;
    
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
    NSString *tempPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:name];
    
    [downLoadRequest setFileSavePath:path];
    [downLoadRequest setFileCachePath:tempPath];
    
    error = [downLoadRequest executeRequest];
}


//下载请求完成后的回调协议
-(void)downloadRequestFinished:(ASIHTTPRequest*)request{
    [self requestFinishedCallBack:request.downloadDestinationPath error:nil];
}

//下载请求失败后的回调协议
-(void)downloadRequestFailed:(ASIHTTPRequest*)request{
    [self requestFinishedCallBack:request.downloadDestinationPath error:request.error];
}

@end
