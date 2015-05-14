//
//  PublicManager.h
//  MIP
//
//  Created by kangqijun on 14-4-28.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseScrollViewController.h"

@interface PublicManager : NSObject
{
    BaseScrollViewController   *viewController;
}

@property (retain, nonatomic) BaseScrollViewController   *viewController;

+ (PublicManager *)sharedInstance;

@end
