//
//  TempNoteDao.h
//  MOA
//
//  Created by  on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TempNotePage.h"
#import "DaoBase.h"

@interface TempNoteDao : DaoBase

//插入页面信息，成功插入返回插入后生成的GUID，返回nil为插入失败
- (BOOL)insertTempNotePage:(TempNotePage *)tempNotePage;

//根据记事本ID和页数获取页面对象，如果没有，就返回nil
-(UIImage *)getNotePage:(NSInteger)pageNumber;

//删除所有的记事本的页面，返回是否成功删除
-(BOOL)deleteAllTempPage;

@end
