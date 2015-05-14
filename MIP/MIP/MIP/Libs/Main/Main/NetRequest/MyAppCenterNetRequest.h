//
//  MyAppCenterNetRequest.h
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/13.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "MIPNetUniformInterface.h"

@interface MyAppCenterNetRequest : NetUniformInterface

- (void)requestForAppTypeList;

- (void)requestForAppList;

@end
