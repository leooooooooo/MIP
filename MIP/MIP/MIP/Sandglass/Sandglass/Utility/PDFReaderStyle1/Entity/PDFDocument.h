//
//  PDFDocument.h
//  MOA
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFDocument : NSObject {

	NSString *url;		//文件地址
	NSString *title;	//file name
}

@property (nonatomic, retain)	NSString *url;
@property (nonatomic, retain)	NSString *title;

@end