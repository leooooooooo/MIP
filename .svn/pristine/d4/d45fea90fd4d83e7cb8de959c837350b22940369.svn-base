//
//  FoldawayTableView.h
//  MOA
//
//  Created by Sea on 13-5-20.
//
//  折叠表视图
//  继承:刷新表视图,可进行下拉刷新

#import "CustomRefreshTableView.h"

#import "FoldawaySectionHeaderView.h"
#import "FoldawaySectionFooterView.h"

@class FoldawayEntity;

@interface FoldawayTableView : CustomRefreshTableView <FoldawaySectionHeaderDelegate> {
    
    FoldawayEntity  *_currentEntity;
}

@property (nonatomic, retain) NSArray *dataList;

@end
