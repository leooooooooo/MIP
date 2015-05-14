//
//  LoginBLL.h
//  Login
//
//  Created by Sea on 13-9-16.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginBLL : NSObject

/*********************************************************************
 Function description:解析登录返回数据
 Parameter: data
 Return value: NSDictionary
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+ (BOOL)synchroniseUserinfo:(NSData*)data;

/*********************************************************************
 Function description:
 Parameter: data
 Return value: BOOL
 Author: lu_sicong
 Remark: N/A
 *********************************************************************/
+ (BOOL)synchroniseLaunchImage:(NSData*)data;

@end
