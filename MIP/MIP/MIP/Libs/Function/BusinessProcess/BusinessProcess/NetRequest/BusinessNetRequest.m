//
//  BusinessNetRequest.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/03.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessNetRequest.h"

#define PageSize        @"20"

@implementation BusinessNetRequest

- (void)requestForNextModuleList
{
    self.requestDescription = @"getNextModuleList";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"login" forKey:kBizCode];
    [bodyDictionary setObject:@"LoginAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getNextModuleList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"funcid"];
    [dataDictionary setObject:@"0" forKey:@"type"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForLargeCommissionWithShipInfoList
{
    self.requestDescription = @"获取有船作业申请列表";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getShipJobList" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:6] forKey:@"querydate"];
    [dataDictionary setObject:PageSize forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"beginDate"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"endDate"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"shipName"];
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"voyage"];
    [dataDictionary setObject:[_argList objectAtIndex:4] forKey:@"jobCompanyId"];
    [dataDictionary setObject:[_argList objectAtIndex:5] forKey:@"auditMark"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForLargeCommissionWithNonShipInfoList
{
    self.requestDescription = @"获取无船作业申请列表";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getNonShipJobList" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:4] forKey:@"querydate"];
    [dataDictionary setObject:PageSize forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"beginDate"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"endDate"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"jobCompanyId"];
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"auditMark"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForBerthingProcessInfoList
{
    self.requestDescription = @"获取待处理靠泊船舶列表";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getTodoBerthingList" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"querydate"];
    [dataDictionary setObject:PageSize forKey:@"size"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForBerthingProcessInfoDetail
{
    self.requestDescription = @"获取待处理靠泊船舶明细";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getTodoBerthingDetail" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForJobProcessInfoList
{
    self.requestDescription = @"获取待处理作业船舶列表";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getTodoJobList" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"querydate"];
    [dataDictionary setObject:PageSize forKey:@"size"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForJobProcessInfoDetail
{
    self.requestDescription = @"获取待处理作业船舶明细";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getTodoJobDetail" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForUnberthingProcessInfoList
{
    self.requestDescription = @"获取待处理移泊船舶列表";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getTodoShiftingList" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"querydate"];
    [dataDictionary setObject:PageSize forKey:@"size"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForUnberthingProcessInfoDetail
{
    self.requestDescription = @"获取待处理移泊船舶明细";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getTodoShiftingDetail" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForOutwardProcessInfoList
{
    self.requestDescription = @"获取待处理离港船舶列表";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getTodoLeaveList" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:1] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"querydate"];
    [dataDictionary setObject:PageSize forKey:@"size"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForOutwardProcessInfoDetail
{
    self.requestDescription = @"获取待处理离港船舶明细";
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getTodoLeaveDetail" forKey:kMethodName];
    
    Userinfo *userInfo = [Userinfo shareUserinfo];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:userInfo.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    [self requestForBusinessProcessInfoList:bodyDictionary];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForBusinessProcessInfoList : (NSDictionary *)argDic
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:argDic];
    
    request.userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[_argList lastObject],@"processType", nil];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

- (void)requestForBerthList
{
    self.requestDescription = @"获取泊位列表";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getBerthList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:0] ;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForBerthPosList
{
    self.requestDescription = @"获取泊位位置列表";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getBerthPosList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:0] ;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForJobCompanyList
{
    self.requestDescription = @"获取作业公司列表";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getdeptList" forKey:kMethodName];

    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:0] ;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForAuditShipJob
{
    self.requestDescription = @"auditShipJob";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"auditShipJob" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:5];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"bcno"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"serial"];
    [dataDictionary setObject:user.uid forKey:@"auditorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"auditorName"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary setObject:[NSNumber numberWithBool:YES] forKey:@"auditState"];
    request.userInfo = dataDictionary;
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForUndoAuditShipJob
{
    self.requestDescription = @"undoAuditShipJob";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"undoAuditShipJob" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:5];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"bcno"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"serial"];
    [dataDictionary setObject:user.uid forKey:@"auditorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"auditorName"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary setObject:[NSNumber numberWithBool:NO] forKey:@"auditState"];
    request.userInfo = dataDictionary;
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForAuditNonShipJob
{
    self.requestDescription = @"auditNonShipJob";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"auditNonShipJob" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:5];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"bcno"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"serial"];
    [dataDictionary setObject:user.uid forKey:@"auditorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"auditorName"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary setObject:[NSNumber numberWithBool:YES] forKey:@"auditState"];
    request.userInfo = dataDictionary;
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestForUnAuditNonShipJob
{
    self.requestDescription = @"unauditNonShipJob";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"unauditNonShipJob" forKey:kMethodName];
    
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:5];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"bcno"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"serial"];
    [dataDictionary setObject:user.uid forKey:@"auditorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"auditorName"];
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary setObject:[NSNumber numberWithBool:NO] forKey:@"auditState"];
    request.userInfo = dataDictionary;
    
    [dataDictionary release];
    [bodyDictionary release];
}

//靠泊处理-保存船舶靠泊处理计划完成数据
- (void)requestForSaveBerthingPlanComplete
{
    self.requestDescription = @"saveBerthingPlanComplete";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveBerthingPlanComplete" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:6];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"completeTime"];
    [dataDictionary setObject:user.uid forKey:@"operatorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *operateTime = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    [dataDictionary setObject:operateTime forKey:@"operateTime"];
    
    request.userInfo = dataDictionary;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}
//靠泊处理-保存船舶靠泊数据
- (void)requestForSaveShipBerthing
{
    self.requestDescription = @"saveShipBerthing";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveShipBerthing" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:10];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"remark"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"berthId"];
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"berthPos"];
    [dataDictionary setObject:[_argList objectAtIndex:4] forKey:@"jobCompanyId"];
    [dataDictionary setObject:[_argList objectAtIndex:5] forKey:@"berthTime"];
    [dataDictionary setObject:user.uid forKey:@"operatorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *operateTime = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    [dataDictionary setObject:operateTime forKey:@"operateTime"];
    
    request.userInfo = dataDictionary;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

//离港处理-保存离港处理计划执行完毕数据
- (void)requestForSaveLeavePlanComplete
{
    self.requestDescription = @"saveLeavePlanComplete";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveLeavePlanComplete" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:6];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"completeTime"];
    [dataDictionary setObject:user.uid forKey:@"operatorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *operateTime = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    [dataDictionary setObject:operateTime forKey:@"operateTime"];
    
    request.userInfo = dataDictionary;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

//保存离港处理船舶离港数据
- (void)requestForSaveShipLeave
{
    self.requestDescription = @"saveShipLeave";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveShipLeave" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:7];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"remark"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"leadTime"];
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"leaveTime"];
    [dataDictionary setObject:user.uid forKey:@"operatorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *operateTime = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    [dataDictionary setObject:operateTime forKey:@"operateTime"];
    
    request.userInfo = dataDictionary;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

//移泊处理-保存移泊处理计划执行完毕数据
- (void)requestForSaveShiftingPlanComplete
{
    self.requestDescription = @"saveShiftingPlanComplete";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveShiftingPlanComplete" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:6];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"completeTime"];
    [dataDictionary setObject:user.uid forKey:@"operatorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *operateTime = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    [dataDictionary setObject:operateTime forKey:@"operateTime"];
    
    request.userInfo = dataDictionary;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

//保存移泊处理船舶离开当前泊位数据
- (void)requestForSaveShipLeaveBerth
{
    self.requestDescription = @"saveShipLeaveBerth";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveShipLeaveBerth" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:7];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"berthId"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"leaveTime"];
    [dataDictionary setObject:user.uid forKey:@"operatorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *operateTime = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    [dataDictionary setObject:operateTime forKey:@"operateTime"];
    
    request.userInfo = dataDictionary;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

//保存移泊处理船舶移泊到新泊位数据
- (void)requestForSaveShipShiftBerth
{
    self.requestDescription = @"saveShipShiftBerth";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveShipShiftBerth" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:8];
    
    Userinfo *user = [Userinfo shareUserinfo];
    [dataDictionary setObject:user.token forKey:@"token"];
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"arriveNewBerthTime"];
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"berthId"];
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"berthPos"];
    [dataDictionary setObject:[_argList objectAtIndex:4] forKey:@"jobCompanyId"];
    [dataDictionary setObject:user.uid forKey:@"operatorId"];
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *operateTime = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    [dataDictionary setObject:operateTime forKey:@"operateTime"];
    
    request.userInfo = dataDictionary;
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForSaveMarginValue
{
    self.requestDescription = @"保存作业处理船舶余吨数据";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveJobRestTon" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:6];
    Userinfo *user = [Userinfo shareUserinfo];
    
    [dataDictionary setObject:user.token forKey:@"token"];                              //身份认证码
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];             //船舶ID
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"restTon"];            //余吨
    [dataDictionary setObject:user.userId forKey:@"operatorId"];                        //操作人ID
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];                   //操作人名称
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"operateTime"];        //操作时间
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    NSDictionary *msgInfo = [NSDictionary dictionaryWithObject:self.requestDescription forKey:@"msg"];
    request.userInfo = msgInfo;
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForConfirmAssessment
{
    self.requestDescription = @"保存作业处理考核确认数据";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveJobCheck" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:8];
    Userinfo *user = [Userinfo shareUserinfo];
    
    [dataDictionary setObject:user.token forKey:@"token"];                              //身份认证码
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];             //船舶ID
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"berthNo"];            //泊位ID
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"unloadAmount"];       //近日卸船数
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"stopHour"];           //今日停时
    [dataDictionary setObject:user.userId forKey:@"operatorId"];                        //操作人ID
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];                   //操作人名称
    [dataDictionary setObject:[_argList objectAtIndex:4] forKey:@"operateTime"];        //操作时间
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    NSDictionary *msgInfo = [NSDictionary dictionaryWithObject:self.requestDescription forKey:@"msg"];
    request.userInfo = msgInfo;
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForSaveUnloadStartTime
{
    self.requestDescription = @"保存作业处理卸货开始时间";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveJobUnloadStart" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:7];
    Userinfo *user = [Userinfo shareUserinfo];
    
    [dataDictionary setObject:user.token forKey:@"token"];                              //身份认证码
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];             //船舶ID
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"berthNo"];            //泊位ID
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"jobTime"];            //开始时间
    [dataDictionary setObject:user.userId forKey:@"operatorId"];                        //操作人ID
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];                   //操作人名称
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"operateTime"];        //操作时间
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    NSDictionary *msgInfo = [NSDictionary dictionaryWithObject:self.requestDescription forKey:@"msg"];
    request.userInfo = msgInfo;
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForSaveUnloadEndTime
{
    self.requestDescription = @"保存作业处理卸货结束时间";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveJobUnloadEnd" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:7];
    Userinfo *user = [Userinfo shareUserinfo];
    
    [dataDictionary setObject:user.token forKey:@"token"];                              //身份认证码
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];             //船舶ID
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"berthNo"];            //泊位ID
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"beginTime"];          //开始时间
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"endTime"];            //结束时间
    [dataDictionary setObject:user.userId forKey:@"operatorId"];                        //操作人ID
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];                   //操作人名称
    [dataDictionary setObject:[_argList objectAtIndex:4] forKey:@"operateTime"];        //操作时间
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    NSDictionary *msgInfo = [NSDictionary dictionaryWithObject:self.requestDescription forKey:@"msg"];
    request.userInfo = msgInfo;
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForSaveloadStartTime
{
    self.requestDescription = @"保存作业处理装货开始时间";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveJobLoadStart" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:7];
    Userinfo *user = [Userinfo shareUserinfo];
    
    [dataDictionary setObject:user.token forKey:@"token"];                              //身份认证码
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];             //船舶ID
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"berthNo"];            //泊位ID
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"jobTime"];            //开始时间
    [dataDictionary setObject:user.userId forKey:@"operatorId"];                        //操作人ID
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];                   //操作人名称
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"operateTime"];        //操作时间
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    NSDictionary *msgInfo = [NSDictionary dictionaryWithObject:self.requestDescription forKey:@"msg"];
    request.userInfo = msgInfo;
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForSaveloadEndTime
{
    self.requestDescription = @"保存作业处理装货结束时间";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveJobLoadEnd" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:7];
    Userinfo *user = [Userinfo shareUserinfo];
    
    [dataDictionary setObject:user.token forKey:@"token"];                              //身份认证码
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];             //船舶ID
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"berthNo"];            //泊位ID
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"beginTime"];          //开始时间
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"endTime"];            //结束时间
    [dataDictionary setObject:user.userId forKey:@"operatorId"];                        //操作人ID
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];                   //操作人名称
    [dataDictionary setObject:[_argList objectAtIndex:4] forKey:@"operateTime"];        //操作时间
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    NSDictionary *msgInfo = [NSDictionary dictionaryWithObject:self.requestDescription forKey:@"msg"];
    request.userInfo = msgInfo;
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForSaveErrorHandling
{
    self.requestDescription = @"保存作业处理错误处理数据";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveJobErrorProcess" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:6];
    Userinfo *user = [Userinfo shareUserinfo];
    
    [dataDictionary setObject:user.token forKey:@"token"];                              //身份认证码
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];             //船舶ID
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"berthNo"];            //泊位ID
    [dataDictionary setObject:user.userId forKey:@"operatorId"];                        //操作人ID
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];                   //操作人名称
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"operateTime"];        //操作时间
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    NSDictionary *msgInfo = [NSDictionary dictionaryWithObject:self.requestDescription forKey:@"msg"];
    request.userInfo = msgInfo;
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void) requestForSaveNonLoadUnloadShip
{
    self.requestDescription = @"保存作业处理非装卸作业船舶数据";
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"saveJobNonLoadUnloadShip" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:5];
    Userinfo *user = [Userinfo shareUserinfo];
    
    [dataDictionary setObject:user.token forKey:@"token"];                              //身份认证码
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"shipId"];             //船舶ID
    [dataDictionary setObject:user.userId forKey:@"operatorId"];                        //操作人ID
    [dataDictionary setObject:user.name_zhCN forKey:@"operatorName"];                   //操作人名称
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"operateTime"];        //操作时间
    
    [bodyDictionary setObject:dataDictionary forKey:kBizData];
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    NSDictionary *msgInfo = [NSDictionary dictionaryWithObject:self.requestDescription forKey:@"msg"];
    request.userInfo = msgInfo;
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
    
    [dataDictionary release];
    [bodyDictionary release];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ([self.requestDescription isEqualToString:@"获取有船作业申请列表"] ||
        [self.requestDescription isEqualToString:@"获取无船作业申请列表"] ||
        [self.requestDescription isEqualToString:@"获取待处理靠泊船舶列表"] ||
        [self.requestDescription isEqualToString:@"获取待处理作业船舶列表"] ||
        [self.requestDescription isEqualToString:@"获取待处理移泊船舶列表"] ||
        [self.requestDescription isEqualToString:@"获取待处理离港船舶列表"] ||
        [self.requestDescription isEqualToString:@"auditShipJob"] ||
        [self.requestDescription isEqualToString:@"undoAuditShipJob"] ||
        [self.requestDescription isEqualToString:@"auditNonShipJob"] ||
        [self.requestDescription isEqualToString:@"unauditNonShipJob"]||
        [self.requestDescription isEqualToString:@"saveBerthingPlanComplete"] ||
        [self.requestDescription isEqualToString:@"saveShipBerthing"] ||
        [self.requestDescription isEqualToString:@"saveShiftingPlanComplete"] ||
        [self.requestDescription isEqualToString:@"saveShipLeaveBerth"] ||
        [self.requestDescription isEqualToString:@"saveShipShiftBerth"] ||
        [self.requestDescription isEqualToString:@"保存作业处理船舶余吨数据"] ||
        [self.requestDescription isEqualToString:@"保存作业处理考核确认数据"] ||
        [self.requestDescription isEqualToString:@"保存作业处理卸货开始时间"] ||
        [self.requestDescription isEqualToString:@"保存作业处理卸货结束时间"] ||
        [self.requestDescription isEqualToString:@"保存作业处理装货开始时间"] ||
        [self.requestDescription isEqualToString:@"保存作业处理装货结束时间"] ||
        [self.requestDescription isEqualToString:@"保存作业处理错误处理数据"] ||
        [self.requestDescription isEqualToString:@"保存作业处理非装卸作业船舶数据"] ||
        [self.requestDescription isEqualToString:@"saveLeavePlanComplete"] ||
        [self.requestDescription isEqualToString:@"saveShipLeave"])
    {
        [self requestFinishedCallBack:request error:nil];
    }
    else
    {
        [self requestFinishedCallBack:request.responseData error:nil];
    }
}

@end
