//
//  PublicManager.m
//  MIP
//
//  Created by kangqijun on 14-4-28.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "PublicManager.h"

@implementation PublicManager

@synthesize viewController;

static PublicManager *manager = nil;

+ (PublicManager *)sharedInstance
{
	@synchronized(self)
    {
		if (!manager)
        {
			manager = [[self alloc] init];
		}
	}
	return manager;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    return self;
}

@end
