//
//  SettingView.h
//  Setting
//
//  Created by kangqijun on 13-11-7.
//  Copyright (c) 2013年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "SettingListCell.h"
#import "ChangePassWordView.h"
#import "ClearFileView.h"
#import "PersonInfoView.h"

@protocol SettingViewDelegate <NSObject>

@optional
- (void)changePassword:(NSMutableArray *)_arr;

- (void)settingCheckNewVersion;

- (void)settingCleanCacheFile;

- (void)settingBlindAccountWith:(BOOL)_isBlind with:(SettingSwitch *)chooseSwitch;

- (void)giveUpBlind;

- (void)settingAutoLoginWith:(BOOL)_isAuto;

-(void)settingHeadImage;

-(void)setPersonInfoWithTelephone:(NSString *)tel email:(NSString *)mail;

-(void)setPersonDetailInfoWithTel:(NSString *)tel duty:(NSString *)duty bakTel:(NSString *)bakTel officeTel:(NSString *)officeTel bakOfficeTel : (NSString *)bakOfficeTel perEmail:(NSString *)perEmail;

@end

@class DeviceBindView;

@interface SettingView : BaseView <UITableViewDelegate,UITableViewDataSource,SettingListCellDelegate,ClearFileViewDelegate>
{
    UIButton            *closeButton;
    ChangePassWordView  *changePassWordView;
    UITableView         *setTableView;
    
    NSMutableArray      *settingList;
    BOOL                isBlind;             //绑定&解绑
    
    SettingSwitch       *blindSwitch; //开关
    
    id <SettingViewDelegate> m_delegate;
    
    PersonInfoView      *personView;
    
    UIImage             *headerImage;
    
    UIButton            *backBtn;
    
    UIView              *upgradeAlert;
    
    DeviceBindView      *bindView;
}

@property (retain, nonatomic) UIButton            *closeButton;

@property (retain, nonatomic) UITableView         *setTableView;

@property (retain, nonatomic) id <SettingViewDelegate> m_delegate;

@property (retain, nonatomic) NSString         *password;

@property (retain, nonatomic) SettingSwitch       *blindSwitch;

@property (readonly, nonatomic) UITextField         *passwordTextField;

@property (retain, nonatomic) UIImage             *headerImage;

@property (retain, nonatomic) UIButton            *backBtn;

//移出修改密码视图
- (void)removeChangePassWordView;

- (void)showOperateFinish:(NSString *)msg;

- (void)personHeaderImage:(UIImage *)image;

- (void)setPersonInfoSuccess;

- (void) deviceBindComplete;

@end
