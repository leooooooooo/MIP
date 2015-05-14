//
//  DownloadRequestDecorator.h
//  Common
//
//  Created by wang hao on 13-9-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//


#import "AbstractRequestComponent.h"

@protocol ASIHTTPDownloadDelegate<NSObject>

@optional

//下载请求完成后的回调协议
-(void)downloadRequestFinished:(ASIHTTPRequest*)request;

//下载请求失败后的回调协议
-(void)downloadRequestFailed:(ASIHTTPRequest*)request;

@end

@interface DownloadRequestDecorator :AbstractRequestComponent<ASIProgressDelegate>{
    
    id<ASIHTTPDownloadDelegate> _delegate; //下载返回代理
    
}
@property (nonatomic, assign) id<ASIHTTPDownloadDelegate> delegate;

-(NSError *)setFileSavePath:(NSString *)path;//设置下载文件保存路径，如果不设置，则默认存放在沙盒临时目录下。
-(NSError *)setFileCachePath:(NSString *)path;//设置缓存文件路径，如果不设置，默认存放在沙盒临时目录下。临时文件后缀名为.tmp
@end
