//
//  CommonlyUsedToolParser.h
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-27.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebSiteCategory.h"
#import "NoteCategory.h"

@interface CommonlyUsedToolParser : NSObject
+(BOOL)isExsitWebSiteCategory:(NSString *)categoryName;
+(BOOL)saveWebSiteCategory:(NSString *)categoryName;

+(BOOL)isExsitWebSiteEntityWithName:(NSString *)entityName inCategory:(WebSiteCategory *)category;
+(BOOL)saveWebSiteEntityWithName:(NSString *)entityName andValue:(NSString *)entityValue inCategory:(WebSiteCategory *)category;

+(BOOL)isExsitNoteCategory:(NSString *)categoryName;
+(BOOL)saveNoteCategory:(NSString *)categoryName;

+(BOOL)isExsitNoteEntityWithName:(NSString *)entityName inCategory:(NoteCategory *)category;
+(BOOL)saveNoteEntityWithName:(NSString *)entityName inCategory:(NoteCategory *)category;
@end
