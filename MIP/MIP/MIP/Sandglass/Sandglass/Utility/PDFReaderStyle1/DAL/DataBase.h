//
//  DataBase.h
//  YumMOSApplication
//
//  Created by Sky.xu on 11-5-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface DataBase : NSObject {

}

+ (FMDatabase *)instance;
+ (void)closeDatabase;
@end
