//
//  UploadRequestDecorator.h
//  Common
//
//  Created by wang hao on 13-9-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AbstractRequestComponent.h"

@protocol ASIHTTPUploadDelegate<NSObject>

@optional

//-(void)netRequest:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;

-(void)uploadRequestFinished:(ASIHTTPRequest*)request;//上传请求完成后的回调协议

-(void)uploadRequestFailed:(ASIHTTPRequest*)request;//上传请求失败后的回调协议

@end


@interface UploadRequestDecorator : AbstractRequestComponent <ASIProgressDelegate>{
    
    id <ASIHTTPUploadDelegate>          _delegate;//上传返回代理
    
}

@property (nonatomic ,assign) id <ASIHTTPUploadDelegate> delegate;

@end
