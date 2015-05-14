//
//  SettingListCell.h
//  Setting
//
//  Created by kangqijun on 13-11-7.
//  Copyright (c) 2013年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingSwitch.h"

#define AUTOLOGINKEY               @"autoLogin"

@protocol SettingListCellDelegate <NSObject>

@optional
- (void)checkNewVersion;
- (void)cleanCacheFile;
- (void)blindAccountWith:(BOOL)_isBlind with:(SettingSwitch *)chooseSwitch;
- (void)setAutoLoginWith:(BOOL)_isAuto;

@end

@interface SettingListCell : UITableViewCell<SwitchChangeDelegate>
{
    UILabel       *titleLab;     //内容信息
    UILabel       *detailLab;    //描述信息
    
    UIImageView   *boultImage;   //箭头
    SettingSwitch *chooseSwitch; //开关
    UIButton      *toolButton;   //功能按钮
    
    id<SettingListCellDelegate> m_delegate;
}

@property (retain, nonatomic) id<SettingListCellDelegate> m_delegate;

@property (nonatomic, retain) SettingSwitch *chooseSwitch;
@property (nonatomic, retain) UIButton *toolButton;

//加载数据
- (void)loadCellDataWith:(NSDictionary *)_dic;

@end
