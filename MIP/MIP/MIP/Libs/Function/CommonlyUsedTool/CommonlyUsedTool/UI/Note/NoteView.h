//
//  NoteView.h
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-28.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseView.h"

@interface NoteView : BaseView
{
    UIButton            *categoryRefreshButton;
    UIButton            *itemRefreshButton;
    
    UIButton            *categoryAddButton;
    UIButton            *itemAddButton;
    
    UIButton            *categoryEditButton;
    UIButton            *itemEditButton;
}

@property(nonatomic,retain,readonly) UIButton            *categoryRefreshButton;
@property(nonatomic,retain,readonly) UIButton            *itemRefreshButton;

@property(nonatomic,retain,readonly) UIButton            *categoryAddButton;
@property(nonatomic,retain,readonly) UIButton            *itemAddButton;

@property(nonatomic,retain,readonly) UIButton            *categoryEditButton;
@property(nonatomic,retain,readonly) UIButton            *itemEditButton;
@end
