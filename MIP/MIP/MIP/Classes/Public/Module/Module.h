//
//  Module.h
//  MIP
//
//  Created by kangqijun on 13-11-6.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Userinfo;
@class UIImage;
@class BaseScrollViewController;

@interface Module : NSManagedObject

//动态绑定属性
@property (nonatomic, retain) NSString * unionId;//服务端权限id,该标志只用于与服务端权限匹配
@property (nonatomic, retain) NSString * userId;//用户唯一id号,对应Userinfo中的uid
@property (nonatomic, retain) NSString * name;//模块名称
@property (nonatomic, retain) NSNumber * sort;//模块排序
@property (nonatomic, retain) NSNumber * badge;//模块未读数量
@property (nonatomic, retain) NSString * funcCode;
@property (nonatomic, retain) NSString *type;
//TODO:
@property (nonatomic, retain) NSString *searchKeywords;//筛选条件（逗号隔开）
@property (nonatomic, retain) Userinfo *userInfo;//模块所属的Userinfo
@property (nonatomic, retain) NSString *unreadNumber;//lixiangai  add
@property (nonatomic, retain) NSNumber *moduleType; //模块类型(0为左侧列表使用，1为主页下侧快捷方式使用)
//静态绑定属性
@property (nonatomic, retain, readonly) NSString * uid;//客户端模块的唯一标识,该标志可作为模块的唯一标识,不可修改
@property (nonatomic, retain, readonly) NSString *className;//模块对应的入口类名

@property (nonatomic, retain, readonly) UIImage  *iconImage;
@property (nonatomic, retain, readonly) UIImage  *backgroundImage;
@property (nonatomic, retain, readonly) UIImage  *selectedBackgroundImage;

@property (nonatomic, retain, readonly) NSString *identifier;


@property (nonatomic, retain, readonly) BaseScrollViewController *viewController;

@property (nonatomic, assign) BOOL hasChildren;


/*!
 @function
 @abstract      根据服务端的关联id,检查module的有效性
 
 @param         unionId                     服务端的关联id
 
 @result        模块是否有效的判断结果
 */
+ (BOOL)checkModuleValidity:(NSString *)funcCode;

@end
