//
//  CommonlyUsedToolBLL.m
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-27.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "CommonlyUsedToolBLL.h"

#import "CommonlyUsedToolParser.h"

@implementation CommonlyUsedToolBLL
+(BOOL)isExsitWebSiteCategory:(NSString *)categoryName{
    return [CommonlyUsedToolParser isExsitWebSiteCategory:categoryName];
}
+(BOOL)saveWebSiteCategory:(NSString *)categoryName{
    return [CommonlyUsedToolParser saveWebSiteCategory:categoryName];
}

+(BOOL)isExsitWebSiteEntityWithName:(NSString *)entityName inCategory:(WebSiteCategory *)category{
    return [CommonlyUsedToolParser isExsitWebSiteEntityWithName:entityName inCategory:category];
}

+(BOOL)saveWebSiteEntityWithName:(NSString *)entityName andValue:(NSString *)entityValue inCategory:(WebSiteCategory *)category{
    return [CommonlyUsedToolParser saveWebSiteEntityWithName:entityName andValue:entityValue inCategory:category];
}

+(BOOL)isExsitNoteCategory:(NSString *)categoryName{
    return [CommonlyUsedToolParser isExsitNoteCategory:categoryName];
}

+(BOOL)saveNoteCategory:(NSString *)categoryName{
    return [CommonlyUsedToolParser saveNoteCategory:categoryName];
}

+(BOOL)isExsitNoteEntityWithName:(NSString *)entityName inCategory:(NoteCategory *)category{
    return [CommonlyUsedToolParser isExsitNoteEntityWithName:entityName inCategory:category];
}

+(BOOL)saveNoteEntityWithName:(NSString *)entityName inCategory:(NoteCategory *)category{
    return [CommonlyUsedToolParser saveNoteEntityWithName:entityName inCategory:category];
}
@end
