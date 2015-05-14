//
//  AbstractRequestComponent.h
//  Common
//
//  Created by wang hao on 13-9-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

#import "ASIHTTPRequest.h"
#import "CustomNewAlertView.h"

@class MBProgressHUD;

@interface AbstractRequestComponent : NSObject<ASIHTTPRequestDelegate>{
    
    long long           _totalSize;     //上传或者下载的数据总大小
    
    MBProgressHUD       *_hud;          //进度条视图，目前该形式暂不实现
    
    Class               _originalClass; //用于检测代理有效性
    
    ASIHTTPRequest      *_request;      //用于被装饰的请求
    
}
//@property (nonatomic, retain)UIAlertView        *progressAlertView;
@property (nonatomic, retain)CustomNewAlertView        *progressAlertView;
@property (nonatomic, retain)UIProgressView     *progressView;
@property (nonatomic, retain)UILabel            *progressText;

/*!
 @function	
 @abstract      初始化网络请求
 
 @param         request                 已经完成初始化的请求
 
 @result      
 */
-(id)initWithASIHTTPRequest:(ASIHTTPRequest *)request;



/*!
 @function	
 @abstract      执行网络请求   
 
 @result        NSError                 检测出的错误
 */
-(NSError *)executeRequest;



/*!
 @function	
 @abstract      取消网络请求
 
 @param         request                 需要取消的网络请求
 
 @result      
 */
-(void)cancelRequest:(ASIHTTPRequest *)request;



/*!
 @function	
 @abstract      创建AlertView类型进度条
 
 @param   
 
 @result      
 */
-(void)creatAlertViewForProgress;



/*!
 @function	
 @abstract      格式化进度条数字样式的方法
 
 @param         size                    需要格式化的数字
 
 @result        格式化后的字符串  如 XXXKB XXXMB
 */
-(NSString*)formatSize:(long long)size;



/*!
 @function	
 @abstract      更新进度条数字的方法
 
 @param         request 返回的请求数据
 @param         size 返回的数据大小
 
 @result     
 */
-(void)showRequest:(ASIHTTPRequest *)request bytesInTotal:(long long)size;



/*!
 @function	
 @abstract      隐藏进度条
 
 @param         request                 返回的请求数据
 @param         flag                    成功标志位
 
 @result     
 */
-(void)hideLoadingProgressView:(ASIHTTPRequest *)request success:(BOOL)flag;

@end
