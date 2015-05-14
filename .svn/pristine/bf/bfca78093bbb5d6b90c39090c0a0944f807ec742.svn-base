//
//  Module.m
//  MIP
//
//  Created by kangqijun on 13-11-6.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "Module.h"
#import "Userinfo.h"

#import "UIImage+CustomExtensions.h"
#import "NewsCenterLevelOneViewController.h"

static struct {
    
    NSString *funcCode;//服务端权限id,该标志只用于与服务端权限匹配
    NSString *uid;//客户端模块的唯一标识,该标志可作为模块的唯一标识,不可修改
    NSString *className;
    NSString *imageName;
    NSString *identifier;//
    
} matchup[] = {//uid与className的对应关系
{@"WDZM"       ,@"14"       ,@"MyDesktopViewController"    ,@"myAppCenter"   ,@"MyAppCenterModuleIdentifier"},
{@"XWZX"       ,@"2"       ,@"NewsCenterLevelOneViewController"          ,@"newsCenter"         ,@"newsCenterModuleIdentifier"},
{@"JRKB"       ,@"4"       ,@"NewsflashLevelOneViewController"    ,@"newsFlash"   ,@"newsflashModuleIdentifier"},
{@"YWBL"       ,@"7"       ,@"BusinessProcessLevelOneViewController"    ,@"business"   ,@"businessProcessModuleIdentifier"},
{@"TXL"        ,@"5"       ,@"ContactsViewController"    ,@"contacts"   ,@"ContactsModuleIdentifier"},
{@"SPJK"       ,@"6"       ,@"SafePortViewController"    ,@"video"   ,@"SafePortModuleIdentifier"},
{@"SBYX"       ,@"11"       ,@"OperDeviceViewController"    ,@"operDevice"   ,@"operDeviceModuleIdentifier"},
{@"DTGK"       ,@"12"       ,@"LCLevelOneViewController"    ,@"energyCenter"   ,@"LCLHarbourModuleIdentifier"},
{@"GWCK"       ,@"13"       ,@"OfficialCheckViewController"    ,@"documentCheck"   ,@"OfficialCheckModuleIdentifier"},
{@"CYGN"       ,@"15"       ,@"CommonlyUsedToolViewController"    ,@"commonlyUsedTool"   ,@"commonlyUsedToolModuleIdentifier"},
{@"YGFW"       ,@"16"       ,@"StaffServiceViewController"    ,@"StaffService"   ,@"StaffServiceModuleIdentifier"},
{@"YGSJ"       ,@"17"       ,@"StaffSocialViewController"    ,@"StaffSocial"   ,@"StaffSocialModuleIdentifier"}
};

@interface Module () {
    
    NSInteger         index;
    NSArray           *childrenArr;
}

@end

@implementation Module

@dynamic unionId;
@dynamic userId;
@dynamic name;
@dynamic sort;
@dynamic badge;
@dynamic funcCode;
@dynamic type;
@dynamic searchKeywords;
@dynamic moduleType;

@synthesize userInfo;
@synthesize unreadNumber; //add by lixiangai

@synthesize uid;
@synthesize className;

@synthesize iconImage;
@synthesize backgroundImage;
@synthesize selectedBackgroundImage;

@synthesize viewController;

@synthesize identifier;

@synthesize hasChildren;


- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if (self)
    {
        childrenArr = [[NSArray alloc] initWithObjects:@"XWZX",@"JRKB",@"YWBL",@"SPJK",@"YGFW",@"YGSJ",@"SBYX",@"DTGK",nil];
    }
    
    return self;
}

/*!
 @function
 @abstract      根据服务端传入的id,得到对应功能的唯一id
 
 @result        入口类名
 */
- (NSString *)uid {
    
    if (uid)
        return uid;
    
    for (int i = 0; i < sizeof(matchup)/sizeof(matchup[0]); i++) {
        
        if ([self.funcCode isEqualToString:matchup[i].funcCode]) {
            
            uid = [matchup[i].uid retain];
            
            return uid;
        }
    }
    
    return nil;
}



/*!
 @function
 @abstract      根据服务端传入的id,得到对应功能的入口类名
 
 @result        入口类名
 */
- (NSString *)className {
    
    if (className)
        return className;
    
    for (int i = 0; i < sizeof(matchup)/sizeof(matchup[0]); i++) {
        
        if ([self.uid isEqualToString:matchup[i].uid]) {
            
            className = [matchup[i].className retain];
            
            return className;
        }
    }
    
    return nil;
}



/*!
 @function
 @abstract      根据服务端传入的id,得到功能对应的未选中图片
 
 @result        功能对应的未选中图片
 */
- (UIImage *)iconImage {
    
    if (iconImage) {
        
        return iconImage;
    }
    else {
        
        for (int i = 0; i < sizeof(matchup)/sizeof(matchup[0]); i++) {
            
            if ([self.uid isEqualToString:matchup[i].uid]) {
                
                //功能对应的未选中图片
                iconImage = [[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"icon_%@.png",matchup[i].imageName] imageBundle:mainBundle] retain];
                
                return iconImage;
            }
        }
    }
    
    return nil;
}



/*!
 @function
 @abstract      根据服务端传入的id,得到功能对应的未选中图片
 
 @result        功能对应的未选中图片
 */
- (UIImage *)backgroundImage {
    
    //目前无背景图
    /*if (backgroundImage) {
     
     return backgroundImage;
     }
     else {
     
     for (int i = 0; i < sizeof(matchup)/sizeof(matchup[0]); i++) {
     
     if ([self.uid isEqualToString:matchup[i].uid]) {
     
     //功能对应的未选中图片
     backgroundImage = [[UIImage creatImage:[matchup[i].imageName stringByAppendingString:@"_enable.png"] imageBundle:mainBundle] retain];
     
     return backgroundImage;
     }
     }
     }*/
    
    return nil;
}



/*!
 @function
 @abstract      根据服务端传入的id,得到功能对应的选中后的图片
 
 @result        功能对应的选中后的图片
 */
- (UIImage *)selectedBackgroundImage {
    
    if (selectedBackgroundImage) {
        
        return selectedBackgroundImage;
    }
    else {
        
        for (int i = 0; i < sizeof(matchup)/sizeof(matchup[0]); i++) {
            
            if ([self.uid isEqualToString:matchup[i].uid]) {
                
                //得到功能对应的选中后的图片
                selectedBackgroundImage = [[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"bg_%@_selected.png",matchup[i].imageName] imageBundle:mainBundle] retain];
                
                return selectedBackgroundImage;
            }
        }
    }
    
    return nil;
}

- (BaseScrollViewController*)viewController {
    
    if (!viewController) {
        
        Class aClass = NSClassFromString(self.className);
        
        BaseScrollViewController *aViewController = [[aClass alloc] init];
        
        viewController = [aViewController retain];
        
        [aViewController release];
    }
    
    return viewController;
}

- (NSString *)identifier {
    
    if (identifier)
        return identifier;
    
    for (int i = 0; i < sizeof(matchup)/sizeof(matchup[0]); i++) {
        
        if ([self.uid isEqualToString:matchup[i].uid]) {
            
            identifier = [matchup[i].identifier retain];
            
            return identifier;
        }
    }
    
    return identifier;
}

- (BOOL)hasChildren
{
    BOOL  has = NO;
    
    for (int i = 0; i < sizeof(matchup)/sizeof(matchup[0]); i++)
    {
        if ([childrenArr containsObject:self.funcCode])
        {
            has = YES;
        }
    }
    
    return has;
}

- (void)dealloc {
    
    [className release];
    className = nil;
    
    [viewController release];
    viewController = nil;
    
    [iconImage release];
    iconImage = nil;
    
    [backgroundImage release];
    backgroundImage = nil;
    
    [selectedBackgroundImage release];
    selectedBackgroundImage = nil;
    
    [childrenArr release];
    
    [super dealloc];
}



/*!
 @function
 @abstract      根据服务端的关联id,检查module的有效性
 
 @param         funcCode                     服务端的关联id
 
 @result        模块是否有效的判断结果
 */
+ (BOOL)checkModuleValidity:(NSString *)funcCode {
    
    for (int i = 0; i < sizeof(matchup)/sizeof(matchup[0]); i++) {
        
        if ([funcCode isEqualToString:matchup[i].funcCode]) {
            
            return YES;
        }
    }
    
    return NO;
}

@end