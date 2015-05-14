//
//  PageInfo.h
//  MOA
//
//  Created by zhou_min on 11-11-15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotePage : NSObject {
    NSString *pageId;       //页数唯一标识
    NSString *noteId;       //笔记ID
    NSInteger pageNumber;   //第几页
    UIImage  *pageContent;  //页面内容
}

@property (nonatomic, retain)	NSString    *pageId;
@property (nonatomic, retain)	NSString    *noteId;
@property (nonatomic)           NSInteger    pageNumber;
@property (nonatomic, retain)	UIImage     *pageContent;


@end
