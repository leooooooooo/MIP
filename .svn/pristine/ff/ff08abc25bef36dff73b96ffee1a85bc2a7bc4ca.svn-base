//
//  Userinfo.h
//  MIP
//
//  Created by kangqijun on 13-11-6.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Module;

//更新类型
typedef enum
{
    UpdateType_NoUpdate = 0, //不更新
    UpdateType_Normal,       //普通更新
    UpdateType_Force,        //强制更新
    UpdateType_Default,      //静默更新
}
UpdateType;

//登录状态
typedef enum
{
    LoginStatues_success = 0,       //登录成功
    LoginStatues_fail,              //登录失败
    LoginStatues_noAccount,         //用户不存在
    LoginStatues_passwordWrong,     //密码错误
}
LoginStatues;

//绑定状态
typedef enum
{
    BindStatues_noBind = 1,       //未绑定
    BindStatues_isBind,           //已绑定
    BindStatues_bindOther,        //绑定其他设备
}
BindStatues;

@interface Userinfo : NSManagedObject

//动态绑定属性
@property (nonatomic, retain) NSString * uid;//用户唯一id号
@property (nonatomic, retain) NSString * name_zhCN;//用户中文名
@property (nonatomic, retain) NSString * name;//用户登陆名
@property (nonatomic, retain) NSString * deptID;//部门id
@property (nonatomic, retain) NSString * deptName;//部门名称
@property (nonatomic, retain) NSString * password;//密码
@property (nonatomic, retain) NSNumber * isRememberPassword;//是否记住密码
@property (nonatomic, retain) NSString * configVersion;//配置文件版本,默认为0.0
@property (nonatomic, retain) NSSet *relationToModule;//关联module集合
@property (nonatomic, retain) NSString *userId;         //用户编号
@property (nonatomic, retain) NSString *duty;           //职务
@property (nonatomic, retain) NSString *bakTel;         //备用手机
@property (nonatomic, retain) NSString *officeTel;      //办公电话
@property (nonatomic, retain) NSString *bakOfficeTel;   //备用电话
@property (nonatomic, retain) NSString *perEmail;       //个人邮箱
@property (nonatomic, retain) NSString *headPicUrl;     //头像URL
@property (nonatomic, retain) NSNumber *markWeibo;      //云之家微博开通标识

//静态绑定属性
@property (nonatomic, retain, readonly) NSString * appId;//应用标识
@property (nonatomic, retain, readonly) NSString * appVersion;//应用版本

@property (nonatomic, retain, readonly) NSString * deviceId;//设备唯一标识符
@property (nonatomic, retain, readonly) NSString * deviceType;//设备类型

@property (nonatomic, retain, readonly) NSString * OSVersion;//设备操作系统版本

//模块权限
@property (nonatomic, retain, readonly) NSArray  * moduleArray;//模块权限列表
@property (nonatomic, retain) NSArray  * indexModuleArray;//系统主页模块权限列表


//不需要序列化的属性
@property (nonatomic, assign) BOOL      isBindRemind;//是否需要进行绑定提醒
@property (nonatomic, assign) LoginStatues loginCode;//登陆状态码
@property (nonatomic, retain) NSString * loginCodeMessage;//登陆状态码的对应提示

@property (nonatomic, assign) UpdateType updateType;//更新类型
@property (nonatomic, assign) BindStatues bindCode;  //绑定状态

//单点登录token
@property (nonatomic, retain) NSString *token;
//公司ID
@property (nonatomic, retain) NSString *companyid;
//公司
@property (nonatomic, retain) NSString *company;
//电话
@property (nonatomic, retain) NSString *telephone;
//邮箱
@property (nonatomic, retain) NSString *email;

//使用username设置userinfo,该方法只有在登陆时使用
+ (void)setUserinfo:(NSString *)username;

+ (Userinfo *)shareUserinfo;

+ (void)releaseUserinfo;

- (Module *)getModuleWithIdentifier:(NSString *)identifier;


@end

@interface Userinfo (CoreDataGeneratedAccessors)

- (void)addRelationToModuleObject:(Module *)value;
- (void)removeRelationToModuleObject:(Module *)value;
- (void)addRelationToModule:(NSSet *)values;
- (void)removeRelationToModule:(NSSet *)values;

@end
