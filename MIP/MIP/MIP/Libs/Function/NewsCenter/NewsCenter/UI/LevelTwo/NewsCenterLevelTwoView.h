//
//  NewsCenterLevelTwoView.h
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "BaseView.h"
#import "CustomPopListView.h"
#import "CustomSegmentedControl.h"
#import "NewsCenterDocument.h"
#import "NewsCenterCategory.h"
#import "InsetTextField.h"
@protocol NewsCenterDcumentLevelTwoViewDelegate <NSObject>

- (void)filterNewsCenterDcumentWith:(NSString *)filterkey;

@end
@interface NewsCenterLevelTwoView : BaseView <CustomPopListViewDelegate>
{
    
    CustomSegmentedControl *segmentedControl;
    
    UIButton               *filtrateBtn;  //筛选按钮
    UIButton               *closeBtn;     //关闭按钮
    UIButton               *searchBtn;    //搜索按钮
    UIButton               *backSearchBtn; //退出搜索按钮
    
    UIView                 *searchInputView; //搜索输入视图
    UIView                 *searchResultView;//搜索结果视图
    
    
    UIImageView            *arrowBgImage;
    UILabel                *searchResultLab;
    UILabel                *searchNumLab;
    
    InsetTextField            *searchTextField;
    
    CustomPopListView      *popListView;  //筛选弹出视图
    
    NSArray                *filtrateDataArr; //筛选条件数据
    
    id<NewsCenterDcumentLevelTwoViewDelegate> m_delegate;
    
    UIImageView            *filtrateBtnBg;
    UIImageView            *funnelBg;
    
    UIButton               *backBtn;
    UIImageView            *segmenteBGView;
    UILabel                *titleLab;
}

@property (nonatomic ,retain, readonly) CustomSegmentedControl  *segmentedControl;

@property (nonatomic, retain) UIButton               *filtrateBtn;
@property (nonatomic, retain) UIButton               *closeBtn;
@property (nonatomic, retain) UIButton               *searchBtn;
@property (nonatomic, retain) UIButton               *backSearchBtn;
@property (nonatomic, retain) UITextField            *searchTextField;
@property (nonatomic, retain) NSArray                *filtrateDataArr;
@property (nonatomic ,assign) id<NewsCenterDcumentLevelTwoViewDelegate> m_delegate;
@property (nonatomic,retain) NSString                *filtrateStr;
@property (retain, nonatomic) UIButton               *backBtn;
@property (retain, nonatomic) NewsCenterCategory     *category;

//显示筛选弹出框
- (void)showFiltrateViewWith:(NSString *)filters;

//显示搜索视图
- (void)showSearchInputView;

//显示搜索结果视图
- (void)showSearchResultViewWithKeyword:(NSString *)_keyString count:(int)_count;

//不带segmentedControl视图
- (void)changeToHideSegmentedControlView;
//带segmentedControl视图
- (void)changeToShowSegmentedControlView;

//隐藏筛选功能
- (void)hiddenFiltrateView;
//展示筛选功能
- (void)showFiltrateView;

- (void)showNetTVMoviePlayer;

- (void)hiddenNetTVMoviePlayer;

- (void)loadNewsWithCategory:(NewsCenterCategory *)category;

@end
