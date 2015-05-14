//
//  ApplicationListCell.h
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/13.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

@protocol AppcationListCellDelegate <NSObject>

- (void) downLoadApplicationWithIndex:(NSInteger)index;

- (void) updateApplicationWithIndex:(NSInteger)index;

- (void) addApplicationWithCell:(id)cell;

@end

@interface ApplicationCell : UITableViewCell
{
    UIImageView   *appIconImg;              //应用图标
    UILabel       *appNameLab;              //应用名称
    UILabel       *appPublishTimeLab;       //应用发布时间
    UILabel       *appVersionLab;           //应用版本号
    
    NSInteger       appIndex;               //单元格编号
    BOOL          appIsChecked;             //应用是否已添加
    UILabel       *appDownAddLab;           //已下载安装
    
    UIButton      *downloadButton;          //下载安装按钮
    UIButton      *addToDesktopButton;      //添加按钮
    UIButton      *updateToDesktopButton;   //更新按钮
    
    id<AppcationListCellDelegate> m_delegate;
}

@property (assign, nonatomic) id<AppcationListCellDelegate> m_delegate;

@property (nonatomic, retain) UIImage *m_imgAppIcon;

@property (nonatomic, retain) NSString *m_strAppName;

@property (nonatomic, retain) NSString *m_strAppPublishTime;

@property (nonatomic, retain) NSString *m_strAppVersion;

@property (nonatomic) BOOL m_appIsChecked;

@property (nonatomic) NSInteger m_appIndex;

@property (nonatomic, retain) UIButton *downloadButton;

@property (nonatomic, retain) UIButton *addToDesktopButton;



@end
