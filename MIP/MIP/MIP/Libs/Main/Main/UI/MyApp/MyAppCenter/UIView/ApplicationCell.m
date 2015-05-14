//
//  ApplicationListCell.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/13.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ApplicationCell.h"
#import "UIButton+ImageWithLabel.h"

#define AppInfoFrameWidth       255
#define AppInfoFrameHeight      70

#define FrameBorderWidth        1
#define FrameBorderColor        [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0]

#define BackGroundImage         [UIImage imageNamed:@"warehouse_bg_2.png" imageBundle:myAppCenterBundle]

#define IconFrame               CGRectMake(10, 10, 50, 50)
#define LeftFrameWidth          70

#define TitleColor              [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0]
#define TitleFont               [UIFont boldSystemFontOfSize:18]
#define SubTitleColor           [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0]
#define SubTitleFont            [UIFont systemFontOfSize:12]

#define BOTTOM_ORIGIN_X(VIEW) (VIEW.frame.origin.x + VIEW.frame.size.width)
#define BOTTOM_ORIGIN_Y(VIEW) (VIEW.frame.origin.y + VIEW.frame.size.height)

@implementation ApplicationCell

@synthesize m_delegate, downloadButton, addToDesktopButton, m_appIndex = appIndex;

@synthesize m_appIsChecked = appIsChecked;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

//
//        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AppInfoFrameWidth, AppInfoFrameHeight)];
//        bgView.image = BackGroundImage;
//        [self addSubview:bgView];
//        [bgView release];
        
        appIconImg = [[UIImageView alloc] initWithFrame:IconFrame];
        appIconImg.backgroundColor = [UIColor clearColor];
        [self addSubview:appIconImg];
            
        //应用名称
        appNameLab = [[UILabel alloc] initWithFrame:CGRectMake(LeftFrameWidth, 13,
                                                               AppInfoFrameWidth - LeftFrameWidth, 19)];
        appNameLab.backgroundColor = [UIColor clearColor];
        appNameLab.textColor = TitleColor;
        appNameLab.font = TitleFont;
        [self addSubview:appNameLab];
        
        appDownAddLab = [[UILabel alloc] initWithFrame:CGRectMake(140, 5,
                                                                        26, 11)];
        appDownAddLab.textAlignment = NSTextAlignmentCenter;
        appDownAddLab.text = @"已下载";
        appDownAddLab.textColor = [UIColor whiteColor];
        appDownAddLab.font = [UIFont boldSystemFontOfSize:8];
        [appDownAddLab setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"y_b.png" imageBundle:myAppCenterBundle]]];
        [self addSubview:appDownAddLab];
        
        //应用发布时间
        appPublishTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(LeftFrameWidth, BOTTOM_ORIGIN_Y(appNameLab) + 5,
                                                                      AppInfoFrameWidth - LeftFrameWidth, 13)];
        appPublishTimeLab.backgroundColor = [UIColor clearColor];
        appPublishTimeLab.textColor = SubTitleColor;
        appPublishTimeLab.font = SubTitleFont;
        [self addSubview:appPublishTimeLab];
        
        //应用版本号
        appVersionLab = [[UILabel alloc] initWithFrame:CGRectMake(LeftFrameWidth, BOTTOM_ORIGIN_Y(appPublishTimeLab) + 2,
                                                                  AppInfoFrameWidth - LeftFrameWidth, 13)];
        appVersionLab.backgroundColor = [UIColor clearColor];
        appVersionLab.textColor = SubTitleColor;
        appVersionLab.font = SubTitleFont;
        [self addSubview:appVersionLab];
        
        //分割线
        UIImageView *headLine = [[UIImageView alloc] initWithFrame:CGRectMake(260, 8, 1, 52)];
        headLine.image = [UIImage imageNamed:@"y_l.png" imageBundle:myAppCenterBundle];
        [self addSubview:headLine];
        [headLine release];
        
        //各种按钮
        downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadButton addTarget:self action:@selector(downloadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [downloadButton setImage:[UIImage imageNamed:@"y_icon_1.png" imageBundle:myAppCenterBundle] withTitle:@"下载" forState:UIControlStateNormal];
        [downloadButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [downloadButton setFrame:CGRectMake(270,10, 60, 60)];
        [self addSubview:downloadButton];
        
        //更新按钮
        updateToDesktopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [updateToDesktopButton addTarget:self action:@selector(updateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [updateToDesktopButton setImage:[UIImage imageNamed:@"y_icon_4.png" imageBundle:myAppCenterBundle] withTitle:@"更新" forState:UIControlStateNormal];
        [updateToDesktopButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [updateToDesktopButton setFrame:CGRectMake(210, 10, 60, 60)];
        [self addSubview:updateToDesktopButton];
        
        //添加按钮
        addToDesktopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addToDesktopButton addTarget:self action:@selector(addAppliButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        addToDesktopButton.frame = CGRectMake(200, 93, 90, 40);
        [addToDesktopButton setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
        [addToDesktopButton setBackgroundImage:[UIImage imageNamed:@"AlertButton_bg.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        [addToDesktopButton setTitle:@"添加" forState:UIControlStateNormal];
        addToDesktopButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        addToDesktopButton.hidden = YES;
        
        [self addSubview:addToDesktopButton];

    }
    return self;
}

- (void) downloadButtonClicked
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(downLoadApplicationWithIndex:)]) {
        [m_delegate downLoadApplicationWithIndex:appIndex];
    }
}

- (void) updateButtonClicked
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(updateApplicationWithIndex:)]) {
        [m_delegate updateApplicationWithIndex:appIndex];
    }
}

- (void) addAppliButtonClicked
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(addApplicationWithCell:)]) {
        [m_delegate addApplicationWithCell:self];
    }
}

- (UIImage *)m_imgAppIcon
{
    return appIconImg.image;
}

- (void)setM_imgAppIcon:(UIImage *)m_imgAppIcon
{
    appIconImg.image = m_imgAppIcon;
}

- (NSString *)m_strAppName
{
    return appNameLab.text;
}

- (void)setM_strAppName:(NSString *)m_strAppName
{
    appNameLab.text = m_strAppName;
    appNameLab.frame = [self calculateFrameWithTextLabel:appNameLab];
    CGRect tmpRect = appDownAddLab.frame;
    tmpRect.origin.x = BOTTOM_ORIGIN_X(appNameLab);
    appDownAddLab.frame = tmpRect;
}

- (NSString *)m_strAppPublishTime
{
    return appPublishTimeLab.text;
}

- (void)setM_strAppPublishTime:(NSString *)m_strAppPublishTime
{
    appPublishTimeLab.text = m_strAppPublishTime;
}

- (NSString *)m_strAppVersion
{
    return appVersionLab.text;
}

- (void)setM_strAppVersion:(NSString *)m_strAppVersion
{
    appVersionLab.text = m_strAppVersion;
}

- (void)setM_appIsChecked:(BOOL)m_appIsChecked
{
    appIsChecked = m_appIsChecked;
    if (appIsChecked) {
        [addToDesktopButton setTitle:@"移除" forState:UIControlStateNormal];
    }else {
        [addToDesktopButton setTitle:@"添加" forState:UIControlStateNormal];
    }
}

-(CGRect)calculateFrameWithTextLabel:(UILabel *) textLabel {
    CGSize tmpSize = [textLabel.text sizeWithFont:textLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    CGRect tmpFrame = textLabel.frame;
    tmpFrame.size.height = tmpSize.height;
    tmpFrame.size.width = tmpSize.width;
    return tmpFrame;
}

- (void)dealloc
{
    [appNameLab release];
    [appDownAddLab release];
    [appPublishTimeLab release];
    [appVersionLab release];
    [appIconImg release];
    [super dealloc];
}

@end
