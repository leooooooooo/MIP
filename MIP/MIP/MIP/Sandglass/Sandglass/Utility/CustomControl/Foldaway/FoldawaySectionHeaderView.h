//
//  FoldawaySectionHeaderView.h
//  MOA
//
//  Created by Sea on 13-5-20.
//
//

#import <UIKit/UIKit.h>

@protocol FoldawaySectionHeaderDelegate;


@interface FoldawaySectionHeaderView : UIView {
    
    id          _sectionHeaderDelegate;
    
    NSInteger   _section;//当前header的索引位置
    
    BOOL        _isFolded;//是否是折叠状态,默认未收起状态NO
    
    UILabel        *_titleLabel;
    UIButton       *_accessoryButton;
    UIImageView    *_indicatorView;
    UIImageView    *_backgroundView;
    UIImageView    *_selectedBackgroundView;
    UILabel        *_badgeLabel;
}

- (id)initWithFrame:(CGRect)frame section:(NSInteger)section;

@property (nonatomic, assign)id <FoldawaySectionHeaderDelegate> sectionHeaderDelegate;

@property (nonatomic, assign) BOOL isFolded;
@property (nonatomic, assign,readonly) NSInteger section;

@property (nonatomic, retain) UILabel        *titleLabel;//用于显示该视图的描述信息

@property (nonatomic, retain) UIButton       *accessoryButton;//附加信息按钮,可用于显示详细信息等功能
@property (nonatomic, retain) UIImageView    *indicatorView;//指示器图片,用于显示sectionHeader的伸缩状态
@property (nonatomic, retain) UIImageView    *backgroundView;//正常情况下的背景图片
@property (nonatomic, retain) UIImageView    *selectedBackgroundView;//选中状态下的背景图片
@property (nonatomic, retain) UILabel        *badgeLabel;//用于标记未读数据

@end


@protocol FoldawaySectionHeaderDelegate <NSObject>

@optional

- (void)foldawaySectionHeaderViewClicked:(BOOL)isFolded section:(NSInteger)section target:(FoldawaySectionHeaderView *)headerView;

@end