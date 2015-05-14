//
//  WeatherNetRequest.m
//  Main
//
//  Created by lixiangai on 14-1-7.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "WeatherNetRequest.h"

#import "NSString+MD5Encrypt.h"



@implementation WeatherNetRequest

static ASIHTTPRequest *request  = nil;

/*********************************************************************
 Function description:热门城市信息请求
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(void)getHotCityInfo
{
    self.requestDescription = @"weatherRequest";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"home" forKey:kBizCode];
    [bodyDictionary setObject:@"HomeAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getHotCityInfo" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"cityname"];
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
/*********************************************************************
 Function description:天气请求
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/

-(void)getWeather
{
    self.requestDescription = @"weatherRequest";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"home" forKey:kBizCode];
    [bodyDictionary setObject:@"HomeAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getWeather" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"cityid"];
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
 Function description:城市信息请求
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(void)getCityInfo
{
    self.requestDescription = @"weatherRequest";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"home" forKey:kBizCode];
    [bodyDictionary setObject:@"HomeAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getCityInfo" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"pcityid"];
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

-(void)sendHeartBeat
{
    self.requestDescription = @"HeartBeatRequest";
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"common" forKey:kBizCode];
    [bodyDictionary setObject:@"HeartBeatAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"sendHeartBeat" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"title"];
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
