//
//  SettingListCell.m
//  Setting
//
//  Created by kangqijun on 13-11-7.
//  Copyright (c) 2013年 kangqijun. All rights reserved.
//

#import "SettingListCell.h"

#define BackGroundColor     [UIColor colorWithRed:244/255.0 green:249/255.0 blue:255/255.0 alpha:1.0]
#define SelectedBgColor     [UIColor colorWithRed:221/255.0 green:243/255.0 blue:255/255.0 alpha:1.0]

@implementation SettingListCell

@synthesize m_delegate;

@synthesize chooseSwitch;
@synthesize toolButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BackGroundColor;
        
        //内容信息
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 12, 210, 18)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:titleLab];
        
        //描述信息
        detailLab = [[UILabel alloc] initWithFrame:CGRectMake(9, 32, 240, 16)];
        detailLab.backgroundColor = [UIColor clearColor];
        detailLab.textColor = [UIColor grayColor];
        detailLab.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:detailLab];
        
        //开关
        chooseSwitch = [[SettingSwitch alloc] initWithFrame:CGRectMake(250, 18.5, 57, 23)];
        chooseSwitch.delegate = self;
        chooseSwitch.on = NO;
        [self addSubview:chooseSwitch];
        chooseSwitch.hidden = YES;
        
        //功能按钮
        toolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [toolButton addTarget:self action:@selector(toolButtonClick) forControlEvents:UIControlEventTouchUpInside];
        toolButton.frame = CGRectMake(230, 15, 80, 30);
        [toolButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        toolButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [toolButton setBackgroundImage:[[UIImage imageNamed:@"button.png" imageBundle:settingBundle] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [self addSubview:toolButton];
        toolButton.hidden = YES;
    }
    return self;
}

//加载数据
- (void)loadCellDataWith:(NSDictionary *)_dic
{
    titleLab.text = [_dic objectForKey:@"title"];
    detailLab.text = [_dic objectForKey:@"detail"];
    
    switch (self.tag)
    {
        case 0://个人信息
        {
            boultImage.hidden = NO;
            chooseSwitch.hidden = YES;
            toolButton.hidden = YES;
            
            break;
        }
            
        case 1://修改密码
        {
            boultImage.hidden = NO;
            chooseSwitch.hidden = YES;
            toolButton.hidden = YES;
            break;
        }
        case 2://自动登陆
        {
            boultImage.hidden = YES;
            chooseSwitch.hidden = NO;
            toolButton.hidden = YES;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            BOOL autoLogin = [userDefaults boolForKey:AUTOLOGINKEY];
            chooseSwitch.on = autoLogin;
            break;
        }
        case 3://绑定设备
        {
            boultImage.hidden = YES;
            chooseSwitch.hidden = NO;
            toolButton.hidden = YES;
            
            Userinfo *userinfo = [Userinfo shareUserinfo];
            if (userinfo.bindCode == BindStatues_isBind)
            {
                chooseSwitch.on = YES;
            }
            else
            {
                chooseSwitch.on = NO;
            }
            
            break;
        }
        case 4://检查更新
        {
            boultImage.hidden = YES;
            chooseSwitch.hidden = YES;
            toolButton.hidden = NO;
            [toolButton setTitle:@"检查更新" forState:UIControlStateNormal];
            break;
        }
        case 5://清理数据
        {
            boultImage.hidden = YES;
            chooseSwitch.hidden = YES;
            toolButton.hidden = NO;
            [toolButton setTitle:@"清理数据" forState:UIControlStateNormal];
            break;
        }
            
        default:
            break;
    }
}

//开关事件
- (void)switchChange:(id)sender
{
    SettingSwitch *switchButton = (SettingSwitch *)sender;
    
    switch (self.tag)
    {
        case 2: //自动登陆
        {
            if (m_delegate)
            {
                [m_delegate setAutoLoginWith:switchButton.on];
            }
            
            break;
        }
        case 3: //绑定设备
        {
            if (m_delegate)
            {
                [m_delegate blindAccountWith:switchButton.on with:switchButton];
            }
            
            break;
        }
            
        default:
            break;
    }
}

//按钮事件
- (void)toolButtonClick
{
    switch (self.tag)
    {
        case 4: //检查更新
        {
            if (m_delegate)
            {
                [m_delegate checkNewVersion];
            }
            
            break;
        }
        case 5: //清理数据
        {
            
            if (m_delegate)
            {
                [m_delegate cleanCacheFile];
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.backgroundColor = SelectedBgColor;
    }else {
        self.backgroundColor = BackGroundColor;
    }
    
}


- (void)dealloc
{
    [titleLab release];
    [detailLab release];
    [boultImage release];
    [super dealloc];
}

@end
