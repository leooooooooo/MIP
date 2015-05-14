//
//  NewsCenterNetRequest.m
//  NewsCenter
//
//  Created by wanghao on 14-3-13.
//
//

#import "NewsCenterNetRequest.h"

#import "NewsCenterCategory.h"

@implementation NewsCenterNetRequest

-(void)getNewsCenterCategory{
    self.requestDescription = @"获取新闻中心栏目列表";
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
    
    
    NSDictionary *requestDic = [self netRequestPostDataPackage:bodyDictionary];
    
    [bodyDictionary release];
    
    //发送异步请求
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:&error];
    
    [request appendPostData:postData];
    [request startAsynchronous];
}

-(void)getModuleBadge{
    
}

//集团要闻
-(void)getNewsCenterJTYWDocument
{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getImptNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
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

//基层动态
-(void)getNewsCenterJCDTDocument
{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getBaseNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
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
//港行咨询
-(void)getNewsCenterGHZXDocument
{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getSailNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
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
//群众路线
-(void)getNewSCenterQZLXDocument
{
    self.requestDescription = @"getNewSCenterQZLXDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getPeopleNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"queryDate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"count"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"filter"];
    
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

//陆桥扫描
-(void)getNewsCenterLQSMDocument
{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getBridgeNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
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


-(void)getNewsCenterSPXWDocument
{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getViewNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
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

-(void)getNewsCenterTZGGDocument{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getNoticeList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }

    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
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

-(void)getNewsCenterAQRBDocument{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getSafeNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
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

-(void)getNewsCenterXMDCDocument{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getInspectList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
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

-(void)getNewsCenterDZGBDocument
{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getPortNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
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

-(void)getNewsCenterHotNewsDocument{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getHotNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 4)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:4];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
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

-(void)getNewsCenterAllNewsDocument{
    self.requestDescription = @"getNewsCenterDocument";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getAllNewsList" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    //Category对象
    if ([_argList count] > 5)
    {
        NewsCenterCategory *category = [_argList objectAtIndex:5];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:category,@"category", nil];
    }
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"querydate"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"size"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"keyWord"];
    
    [dataDictionary setObject:[_argList objectAtIndex:4] forKey:@"typeId"];
    
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

-(void)getNewsCenterNewsType{
    self.requestDescription = @"getNewsCenterAllNewsType";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getNewsType" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
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


- (void)getDZGBDocumentURL
{
    self.requestDescription = @"getDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getPortNewsDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"newsId"];
    
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

- (void)getTZGGDocumentURL
{
    self.requestDescription = @"getDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getNoticeDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"noticeId"];
    
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

- (void)getAQRBDocumentURL
{
    self.requestDescription = @"getDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getSafeNewsDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"newsId"];
    
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

- (void)getXMDCDocumentURL
{
    self.requestDescription = @"getDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getInspectDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"newsId"];
    
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

- (void)getXWXXDocumentURL
{
    self.requestDescription = @"getDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getAllNewsDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"newsId"];
    
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

//集团要闻
- (void)getJTYWDocumentURL
{
    self.requestDescription = @"getDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getImptNewsDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"newsId"];
    
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

//基层动态
-(void)getJCDTDocumentURL
{
    self.requestDescription = @"getDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getBaseNewsDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"newsId"];
    
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

//港行咨询
-(void)getGHZXDocumentURL
{
    self.requestDescription = @"getDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getSailNewsDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"newsId"];
    
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
//群众路线
-(void)getQZLXDocumentURL
{
    self.requestDescription = @"getQZLXDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getPeopleNewsDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"newsId"];
    
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


//陆桥扫描
-(void)getLQSMDocumentURL
{
    self.requestDescription = @"getDocumentURL";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"newscenter" forKey:kBizCode];
    [bodyDictionary setObject:@"NewsCenterAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"getBridgeNewsDetail" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2];
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"newsId"];
    
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

-(void)updateHaveReadState
{
    self.requestDescription = @"updateHaveReadState";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:baseURL]];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    
    
    //请求体的键值对
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [bodyDictionary setObject:@"businesshandle" forKey:kBizCode];
    [bodyDictionary setObject:@"BusinessHandleAdapter" forKey:kBizType];
    [bodyDictionary setObject:@"updateHaveReadState" forKey:kMethodName];
    
    NSMutableDictionary *dataDictionary =[[NSMutableDictionary alloc] initWithCapacity:2] ;
    
    [dataDictionary setObject:[_argList objectAtIndex:0] forKey:@"token"];
    
    [dataDictionary setObject:[_argList objectAtIndex:1] forKey:@"loginName"];
    
    [dataDictionary setObject:[_argList objectAtIndex:2] forKey:@"msgTypeId"];
    
    [dataDictionary setObject:[_argList objectAtIndex:3] forKey:@"msgId"];
    
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



//下载请求完成后的回调协议
-(void)downloadRequestFinished:(ASIHTTPRequest*)request{
    [self requestFinishedCallBack:request.downloadDestinationPath error:nil];
}

//下载请求失败后的回调协议
-(void)downloadRequestFailed:(ASIHTTPRequest*)request{
    [self requestFinishedCallBack:request.downloadDestinationPath error:request.error];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ([self.requestDescription isEqualToString:@"getNewsCenterDocument"]||[self.requestDescription isEqualToString:@"getNewSCenterQZLXDocument"])
    {
        [self requestFinishedCallBack:request error:nil];
    }
    else
    {
        [self requestFinishedCallBack:request.responseData error:nil];
    }
}

@end
