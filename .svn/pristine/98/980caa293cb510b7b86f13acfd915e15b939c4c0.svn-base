//
//  MyDesktopView.h
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/13.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "BaseView.h"

#define kBtnIcon                @"BtnIconName"
#define kBtnTitle               @"BtnTitle"
#define kBtnBgColor             @"BtnBgColor"

@protocol MsgTileButtonClickDelegate <NSObject>

- (void) clickMsgTileButton : (NSInteger) index;

- (void) refreshMsgView;

@end

@interface MsgCenterView : BaseView
{
    UIScrollView *m_messageCenterView;
    
    NSMutableDictionary *m_listTiles;
    
    UIButton *closeButton;
    
    __weak id<MsgTileButtonClickDelegate> m_delegate;
}

@property (nonatomic, weak) id<MsgTileButtonClickDelegate> delegate;

@property (nonatomic, retain) UIScrollView *m_messageCenterView;

- (void) addBaseTileButton;

- (void) setNewsTitle : (NSArray *)titleList withClassName : (NSString *)className;

//下拉更新结束后，调用，用于scrollView复位
- (void)doneLoadingHeaderTableViewData;

@end
