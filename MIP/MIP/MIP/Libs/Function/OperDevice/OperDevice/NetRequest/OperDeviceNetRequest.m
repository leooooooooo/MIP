//
//  OperDeviceNetRequest.m
//  OperDevice
//
//  Created by wanghao on 14-3-25.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "OperDeviceNetRequest.h"

@implementation OperDeviceNetRequest

-(void)getOperDeviceUrl{
    self.requestDescription = @"getNewsflash";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"operdevice" forKey:kBizCode];
    [bodyDictionary setObject:@"OperDeviceAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getDevSuperviseList" forKey:kMethodName];
    
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
@end
