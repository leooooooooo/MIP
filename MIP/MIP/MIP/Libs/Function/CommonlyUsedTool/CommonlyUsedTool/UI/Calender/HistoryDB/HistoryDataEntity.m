//
//  HistoryDataEntity.m
//  MOA
//
//  Created by zhang beibei on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HistoryDataEntity.h"

@implementation HistoryDataEntity
@synthesize uuId,day,dayData;

-(void)dealloc{
    [uuId release];
    [day release];
    [dayData release];
    
    [super dealloc];
}

@end
