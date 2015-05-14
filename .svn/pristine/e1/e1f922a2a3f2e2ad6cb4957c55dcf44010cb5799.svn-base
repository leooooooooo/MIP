//
//  LoginBLL.m
//  Login
//
//  Created by Sea on 13-9-16.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "LoginBLL.h"
#import "LoginParser.h"

@implementation LoginBLL

/*********************************************************************
 Function description:解析登录返回数据
 Parameter: data
 Return value: NSDictionary
 Author: li_xiangai
 Remark: override
 *********************************************************************/
+ (BOOL)synchroniseUserinfo:(NSData*)data
{
    return [LoginParser parseUserinfo:data];
}

/*********************************************************************
 Function description:
 Parameter: data
 Return value: BOOL
 Author: lu_sicong
 Remark: N/A
 *********************************************************************/
+ (BOOL)synchroniseLaunchImage:(NSData*)data
{
    NSDictionary *launchImageDic = [LoginParser parseLaunchImage:data];
    
    NSString *urlStr = [launchImageDic objectForKey:@"url"];
    
    if (!isValid(urlStr) || urlStr.length == 0) {
        return NO;
    }
    
    NSString *curVerCode = [launchImageDic objectForKey:@"vercode"];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if ([userDefault objectForKey:IMAGEVERCODE] &&
        [[userDefault objectForKey:IMAGEVERCODE] isEqualToString: curVerCode]) {
        return NO;
    }
    
    NSData *tmpImgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    
    UIImage *tmpImage = [UIImage imageWithData:tmpImgData];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/launch.png",docDir];

    NSData *tmpSaveImage = [NSData dataWithData:UIImagePNGRepresentation(tmpImage)];

    [tmpSaveImage writeToFile:pngFilePath atomically:YES];
    
    [userDefault setObject:curVerCode forKey:IMAGEVERCODE];
    
    return YES;
}

@end
