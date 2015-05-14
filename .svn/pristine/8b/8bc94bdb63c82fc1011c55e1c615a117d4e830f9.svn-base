//
//  LoginNetRequest.h
//  Login
//
//  Created by Sea on 13-9-16.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "MIPNetUniformInterface.h"
#import "ASIHTTPRequest.h"

@interface LoginNetRequest : NetUniformInterface


/*********************************************************************
 Function description:登录请求
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(void)login;

//上传设备token
- (void)postDevToken;

//获取模块未读数
- (void)getModuleBadge;

//获取短信验证码
- (void)getRandomCode;

//验证短信验证码
- (void)verifyRandomCode;

/*********************************************************************
 Function description:返回请求对象
 Parameter:N/A
 Return value: ASIHTTPRequest
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+(ASIHTTPRequest*)RequestObject;

@end
