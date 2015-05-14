//
//  LCNetRequest.m
//  LCHarbour
//
//  Created by kangqijun on 14-3-25.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "LCNetRequest.h"

@implementation LCNetRequest

- (void)getEngSuperviseList
{
    self.requestDescription = @"getEngSuperviseList";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"lowcport" forKey:kBizCode];
    [bodyDictionary setObject:@"LowCPortAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getEngSuperviseList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"listId"];
    
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
