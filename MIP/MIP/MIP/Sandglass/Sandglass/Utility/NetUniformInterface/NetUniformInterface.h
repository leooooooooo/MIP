//
//  NetUniformInterface.h
//  NetUniformInterface
//
//  Created by  on 13-1-8.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"

@interface NetUniformInterface : NSObject<ASIHTTPRequestDelegate> {
    
    SEL         _entranceMethod;
    
    SEL         _finishedMethod;
    id          _finishedTarget;
    
    SEL         _recvHeaderMethod;
    id          _recvHeaderTarget;
    
    NSMutableArray     *_argList;//用于存放http请求的各个参数
}

/*!
 @function	
 @abstract      网络共通接口同步调用方法
 
 @param         entrance                入口方法
 @param         args                    文件类中将调用的方法的参数
 
 @result      
 */
+ (id)executeSynchronous:(SEL)entrance args:(id)arg,...;



/*!
 @function	
 @abstract      网络共通接口异步调用方法
 
 @param         entrance                入口方法
 @param         callback                回调方法    该方法需要两个参数,第一个为response，类型任意; 第二个为NSError
 @param         target                  回调方法所在的目标
 @param         args                    文件类中将调用的方法的参数
 
 @result      
 */
+ (void)executeAsynchronous:(SEL)entrance 
                   callback:(SEL)callback 
                 backTarget:(id)target 
                       args:(id)arg,...;

/*!
 @function	
 @abstract      设置异步请求时的入口方法
 
 @param         entrance                入口方法
 @param         args                    入口方法中将调用的方法的参数
 
 @result        自身实例
 */
+ (id)setExecuteAsynchronous:(SEL)entrance args:(id)arg,...;



/*!
 @function   
 @abstract      设置异步请求时接收到响应头时的回调方法
 
 @param         target                  回调方法所在的目标
 @param         callback                回调方法    该方法需要一个参数,为返回的ResponseHeaders
 
 @result      
 */
- (void)setReceiveResponseHeaders:(id)target callback:(SEL)callback;



/*!
 @function   
 @abstract      设置异步请求完成时的回调方法
 
 @param         target                  回调方法所在的目标
 @param         callback                回调方法 该方法需要两个参数,第一个为response，类型任意; 第二个为NSError
 
 @result      
 */
- (void)setRequestFinished:(id)target callBack:(SEL)callback;



/*!
 @function   
 @abstract      入口方法开始执行

 @result      
 */
- (void)executeAsynchronous;



/*!
 @function   
 @abstract      取消接收到http请求头的回调方法
 
 @result      
 */
- (void)cancelReceiveResponseHeadersCallback;



/*!
 @function   
 @abstract      取消http请求完成的回调方法
 
 @result      
 */
- (void)cancelRequestFinishedCallback;




//TODO: 请求完成后的回调方法
- (void)requestFinishedCallBack:(id)argument error:(NSError *)error;

@end

