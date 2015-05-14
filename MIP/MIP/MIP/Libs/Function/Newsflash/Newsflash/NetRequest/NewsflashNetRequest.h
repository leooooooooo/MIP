//
//  NewsflashNetRequest.h
//  Newsflash
//
//  Created by wanghao on 14-3-24.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "MIPNetUniformInterface.h"

#import "DownloadRequestDecorator.h"

@interface NewsflashNetRequest : NetUniformInterface<ASIHTTPDownloadDelegate>

-(void)getTodaySecurity;

-(void)getNewsflash;

-(void)getSecurityDailyList;

-(void)getSecurityDailyDetail;

- (void)downloadPDF;

@end
