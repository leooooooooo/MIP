//
//  Userinfo.m
//  MIP
//
//  Created by kangqijun on 13-11-6.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import "Userinfo.h"
#import "Module.h"

static Userinfo *userinfo = nil;

@implementation Userinfo

@dynamic uid;
@dynamic name_zhCN;
@dynamic name;
@dynamic deptID;
@dynamic deptName;
@dynamic password;
@dynamic isRememberPassword;
@dynamic configVersion;
@dynamic relationToModule;

@dynamic userId;
@dynamic duty;
@dynamic bakTel;
@dynamic officeTel;
@dynamic bakOfficeTel;
@dynamic perEmail;
@dynamic headPicUrl;
@dynamic markWeibo;

@synthesize appId;
@synthesize appVersion;

@synthesize deviceId;
@synthesize deviceType;

@synthesize OSVersion;

@synthesize moduleArray;
@synthesize indexModuleArray;

@synthesize isBindRemind;

@synthesize loginCode;
@synthesize loginCodeMessage;

@synthesize updateType;
@synthesize bindCode;

@synthesize token;
@synthesize company;
@synthesize companyid;
@synthesize telephone;
@synthesize email;


- (NSString *)appId {
    
    if (!appId) {
        
        appId = [@"F4655E6CAD51427EE043A8640169427E" retain];//[[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey] retain];
    }
    
    return appId;
}

- (NSString *)appVersion {
    
    if (!appVersion) {
        
        appVersion = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] retain];
    }
    
    return appVersion;
}


- (NSString *)deviceId {
    
    if (!deviceId) {
        
        deviceId = [[[UIDevice currentDevice] performSelector:@selector(uniqueIdentifier)] retain];
    }
    
    return deviceId;
}

- (NSString *)deviceType {
    
    if (!deviceType) {
        
        deviceType = [@"iPhone" retain];
    }
    
    return deviceType;
}

- (NSString *)OSVersion {
    
    if (!OSVersion) {
        
        OSVersion = [[[UIDevice currentDevice] systemVersion] retain];
    }
    
    return OSVersion;
}

- (NSArray *)moduleArray {
    
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:context];
    
    //先查询用户的模块的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userInfo.uid == %@ && moduleType == %d",self.uid,0];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"sort" ascending:YES];
    
    [request setPredicate:predicate];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];

    return results;
}

- (NSArray *)indexModuleArray
{
    NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:context];
    
    //先查询用户的模块的历史记录
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userInfo.uid == %@ && moduleType == %d",self.uid,1];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"sort" ascending:YES];
    
    [request setPredicate:predicate];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    return results;
}

- (void) dealloc {
    
    [appId release];
    appId = nil;
    
    [appVersion release];
    appVersion = nil;
    
    [deviceId release];
    deviceId = nil;
    
    [deviceType release];
    deviceType = nil;
    
    [OSVersion release];
    OSVersion = nil;
    
    isBindRemind = NO;
    
    self.loginCodeMessage = nil;
    self.indexModuleArray = nil;
    
    [super dealloc];
}

//使用username设置userinfo,该方法只有在登陆时使用
+ (void)setUserinfo:(NSString *)username {
    
    if (![userinfo.name isEqualToString:username] && isValid(username)) {
        
        [userinfo release];
        userinfo = nil;
        
        NSManagedObjectContext *context = [[DataManager shareDataManager] managedObjectContext];
        
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Userinfo" inManagedObjectContext:context];
        
        //先查询用户是否登陆历史记录
        NSFetchRequest *request=[[NSFetchRequest alloc] init];
        
        [request setEntity:entityDescription];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",username];
        
        [request setPredicate:predicate];
        
        NSError *error = nil;
        
        NSArray *results=[context executeFetchRequest:request error:&error];
        
        [request release];
        
        if (isValid(results) && !error) {
            
            if (results.count == 1) {//如果有用户的登陆记录,则直接使用原coreData对象
                
                userinfo = [[results objectAtIndex:0] retain];
                
                //note: 该处不可省略,目前如果没有省略该代码,则关联关系无法正常使用,可能在关联关系的使用方式上有误,暂时使用该解决方案,待后期有时间调研
                userinfo.name = username;
                
                return ;
            }
        }
        
        //否则新建用户记录
        userinfo = [[Userinfo alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
        userinfo.uid = username;
        userinfo.name = username;
        [context save:NULL];
    }
}

+ (Userinfo *)shareUserinfo {
    
    return userinfo;
}

- (Module *)getModuleWithIdentifier:(NSString *)identifier {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.identifier == %@",identifier];
    
    NSArray *results = [self.moduleArray filteredArrayUsingPredicate:predicate];

    if (results.count == 1) {

        return [results objectAtIndex:0];
    }
    
    return nil;
}

+ (void)releaseUserinfo {
    
    [userinfo release];
    
    userinfo = nil;
}

@end
