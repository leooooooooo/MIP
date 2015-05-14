//
//  MultiFoldawayTableView.h
//  MOA
//
//  Created by Sea on 13-5-27.
//
//

#import "CustomRefreshTableView.h"

#import "FoldawaySectionHeaderView.h"
#import "FoldawaySectionFooterView.h"

#import "SubTableViewStyleCell.h"

#import "FoldawayEntity.h"

@class FoldawayEntity;

@interface MultiFoldawayTableView : CustomRefreshTableView <FoldawaySectionHeaderDelegate>{
    
    CGFloat          _subCellHeight;
    
    FoldawayEntity  *_currentEntity;
    
    //Add by kangqijun on 13-06-07 展开团队的小类的index值
    NSInteger       foldNum;
    //End
}

@property (nonatomic, retain) NSArray *dataList;

@property (nonatomic, assign) NSInteger foldNum;

@end
