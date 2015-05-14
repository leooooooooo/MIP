//
//  FoldawayEntity.h
//  MOA
//
//  Created by Sea on 13-5-20.
//
//

#import <Foundation/Foundation.h>

@class FoldawaySectionHeaderView;

@interface FoldawayEntity : NSObject

@property (nonatomic, assign) BOOL  isFolded;
@property (nonatomic, retain) NSArray *entryList;//条目数组

@property (nonatomic, retain) FoldawaySectionHeaderView *headerView;

@end
