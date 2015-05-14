//
//  NewsCenterNetRequest.h
//  NewsCenter
//
//  Created by wanghao on 14-3-13.
//
//

#import "MIPNetUniformInterface.h"

#import "DownloadRequestDecorator.h"

#import "UploadRequestDecorator.h"

@interface NewsCenterNetRequest : NetUniformInterface <ASIHTTPDownloadDelegate,ASIHTTPUploadDelegate>

-(void)getNewsCenterCategory;

-(void)getModuleBadge;

//获取列表
-(void)getNewSCenterQZLXDocument;

-(void)getNewsCenterTZGGDocument;

-(void)getNewsCenterAQRBDocument;

-(void)getNewsCenterXMDCDocument;

-(void)getNewsCenterDZGBDocument;

-(void)getNewsCenterSPXWDocument;

-(void)getNewsCenterHotNewsDocument;

-(void)getNewsCenterAllNewsDocument;

-(void)getNewsCenterNewsType;

//集团要闻
-(void)getNewsCenterJTYWDocument;
//基层动态
-(void)getNewsCenterJCDTDocument;
//港行咨询
-(void)getNewsCenterGHZXDocument;
//陆桥扫描
-(void)getNewsCenterLQSMDocument;


//获取文件URL
- (void)getDZGBDocumentURL;

-(void)getQZLXDocumentURL;

- (void)getTZGGDocumentURL;

- (void)getAQRBDocumentURL;

- (void)getXMDCDocumentURL;

- (void)getXWXXDocumentURL;

//集团要闻
-(void)getJTYWDocumentURL;
//基层动态
-(void)getJCDTDocumentURL;
//港行咨询
-(void)getGHZXDocumentURL;
//陆桥扫描
-(void)getLQSMDocumentURL;

-(void)updateHaveReadState;

//下载文件
- (void)downloadPDF;
@end
