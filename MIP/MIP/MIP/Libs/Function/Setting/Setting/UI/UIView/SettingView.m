//
//  SettingView.m
//  Setting
//
//  Created by kangqijun on 13-11-7.
//  Copyright (c) 2013年 kangqijun. All rights reserved.
//

#import "SettingView.h"
#import "CustomAlertView.h"
#import "CustomNewAlertView.h"
#import "ClearFileView.h"
#import "DeviceBindView.h"

#define FrameWidth          [UIScreen mainScreen].bounds.size.width
#define FrameHeight         [UIScreen mainScreen].bounds.size.height

#define BackGroundColor     [UIColor colorWithRed:244/255.0 green:249/255.0 blue:255/255.0 alpha:1.0]
#define SelectedBgColor     [UIColor colorWithRed:221/255.0 green:243/255.0 blue:255/255.0 alpha:1.0]

#define TitleTextFrame      CGRectMake(65, 0, 190, 50)
#define TitleTextColor      [UIColor whiteColor]
#define TitleTextFont       [UIFont boldSystemFontOfSize:22]

@implementation SettingView

@synthesize headerImage;

@synthesize closeButton, setTableView, m_delegate, password, blindSwitch, passwordTextField;

@synthesize backBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, FrameWidth, 53.5)];
        navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
        [self addSubview:navBarImg];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:TitleTextFrame];
        titleLab.text = @"个人设置";
        titleLab.textAlignment = UITextAlignmentCenter;
        titleLab.textColor = TitleTextColor;
        titleLab.font = [UIFont boldSystemFontOfSize:22];
        titleLab.backgroundColor = [UIColor clearColor];
        [navBarImg addSubview:titleLab];
        [titleLab release];
        
        [navBarImg release];
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"t_back.png" imageBundle:mainBundle] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(5, 25, 60, 39.5);
        [self addSubview:backBtn];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, FrameWidth, FrameHeight)];
        contentView.backgroundColor = BackGroundColor;
        
        settingList = [[NSMutableArray alloc] init];
        
        NSArray *titleArr = [NSArray arrayWithObjects:@"个人信息",@"修改密码",@"是否自动登录",@"绑定设备信息",@"检查版本升级",@"清除本地缓存数据", nil];
        NSArray *detailArr = [NSArray arrayWithObjects:@"个人的联系方式与邮箱",@"修改用户密码",@"开启后下次启动时自动登录",@"绑定设备",@"手动检查有新版本",@"清除本地的缓存数据", nil];
        
        for (int i=0; i < [titleArr count]; i++)
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:[titleArr objectAtIndex:i] forKey:@"title"];
            [dic setObject:[detailArr objectAtIndex:i] forKey:@"detail"];
            [settingList addObject:dic];
            [dic release];
        }
        
        setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, FrameWidth, FrameHeight - 50 - 20) style:UITableViewStylePlain];
        setTableView.backgroundColor = [UIColor clearColor];
        setTableView.delegate = self;
        setTableView.dataSource = self;
        setTableView.bounces = NO;
        
#ifdef __IPHONE_7_0
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
        {
            setTableView.separatorInset = UIEdgeInsetsZero;
        }
#endif
        
        [contentView addSubview:setTableView];
        
        [setTableView reloadData];
        
        [self addSubview:contentView];
        [contentView release];
        
        self.isNeedNetworkMonitor = YES;
        
    }
    return self;
}

//关闭按钮事件
- (void)closeSettingView
{
    [self removeFromSuperview];
}
/*********************************************************************
 Function description:清除文件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
-(void)clearOver
{
    [self showOperateFinish:@"清理完成"];


}

/*********************************************************************
 Function description:清除文件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)showOperateFinish:(NSString *)msg {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];
    [alert release];
    
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
//    
////    bgImageView.image = [UIImage imageNamed:@"bg_alert_style1.png" imageBundle:publicResourceBundle];
////    
////    CustomAlertView *alertView = [[CustomAlertView alloc] initWithBackgroundView:bgImageView];
////
//    CustomNewAlertView *alertView = [[CustomNewAlertView alloc] initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    
//    //描述信息
//    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, bgImageView.frame.size.width, 50)];
//    titleLab.text = @"提示";
//    titleLab.font = [UIFont boldSystemFontOfSize:22];
//    titleLab.textAlignment = UITextAlignmentCenter;
//    [titleLab setTextColor:[UIColor whiteColor]];
//    [titleLab setBackgroundColor:[UIColor clearColor]];
//    [alertView addTheview:titleLab];
//    [titleLab release];
//    
//    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 360, 80)];
//    contentLab.text = msg;
//    contentLab.font = [UIFont boldSystemFontOfSize:16];
//    contentLab.numberOfLines = 2;
//    contentLab.textAlignment = UITextAlignmentCenter;
//    [contentLab setTextColor:[UIColor colorWithHex:@"474747"]];
//    [contentLab setBackgroundColor:[UIColor whiteColor]];
//    [alertView addTheview:contentLab];
//    [contentLab release];
//        
//    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [doneButton setTitle:@"确定" forState:UIControlStateNormal];
//    [doneButton setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
//    [doneButton setBackgroundImage:[UIImage imageNamed:@"button_blue_style1.png" imageBundle:publicResourceBundle] forState:UIControlStateNormal];
//    doneButton.frame = CGRectMake(20, 140, 360, 40);
//    [alertView addButton:doneButton];
//    
//    [alertView show:self];
//    
//    [bgImageView release];
//    [alertView release];
    
    
}

/*********************************************************************
 Function description:升级点击事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)updateNewVersion:(id)sender
{
    [upgradeAlert removeFromSuperview];
    
    //保存升级提示是否已经提示的标示
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults synchronize];
    
    //NSString *updateURL = [userDefaults objectForKey:kLastVersionURL];
    
    //1确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"http://218.92.115.55/MobilePlatform/Update.aspx"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //2建立请求NSMutableURLRequest（post需要用这个）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //网络访问超时时间
    [request setTimeoutInterval:20.0f];
    //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
    [request setHTTPMethod:@"POST"];
    //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
    NSString *bodyStr = [NSString stringWithFormat:@"AppName=%@&DeviceType=iOS&Build=%@",@"MYLYGPORT",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    //将nstring转换成nsdata
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"body data %@", body);
    [request setHTTPBody:body];
    
    //这里是非代理的异步请求，异步请求并不会阻止主线程的继续执行，不用等待网络请结束。
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError * error) {
        //这段块代码只有在网络请求结束以后的后续处理。
        
        if (data != nil) {  //接受到数据，表示工作正常
            //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *Update = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            NSLog(@"%@", Update);
            
            if([[Update objectForKey:@"Update"]isEqualToString:@"Yes"])
            {
                NSString *Url = [Update objectForKey:@"Url"];
                UIWebView *up = [[UIWebView alloc]init];
                NSURL *url =[NSURL URLWithString:Url];
                NSURLRequest *request =[NSURLRequest requestWithURL:url];
                [up loadRequest:request];
                [self addSubview:up];
                NSLog(@"开始更新",nil);
                [up release];
            }
            else
            {
                //alert = [[UIAlertView alloc]initWithTitle:@"更新" message:@"当前已经是最新版本" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            }
        }
        else
        {
            if(data == nil && error == nil)    //没有接受到数据，但是error为nil。。表示接受到空数据。
            {
                // alert = [[UIAlertView alloc]initWithTitle:@"更新失败" message:@"更新失败，网络超时" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            }
            else
            {
                //alert = [[UIAlertView alloc]initWithTitle:@"更新失败" message:error.localizedDescription delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                NSLog(@"%@", error.localizedDescription);  //请求出错。
            }
        }
        
        
    }];
    
}

/*********************************************************************
 Function description:显示版本更新提示事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)showUpdataViewWithType:(UpdateType)_type
{
    upgradeAlert = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.6;
    [upgradeAlert addSubview:bgView];
    [bgView release];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 320, 200)];
    contentView.backgroundColor = [UIColor clearColor];
    [upgradeAlert addSubview:contentView];
    [contentView release];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    bgImageView.image = [UIImage imageNamed:@"upgrade_box.png" imageBundle:loginBundle];
    [contentView addSubview:bgImageView];
    [bgImageView release];
    
    //描述信息
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, upgradeAlert.frame.size.width, 50)];
    titleLab.text = @"升级更新";
    titleLab.font = [UIFont boldSystemFontOfSize:22];
    titleLab.textAlignment = UITextAlignmentCenter;
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:titleLab];
    [titleLab release];
    
    UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, 280, 85)];
    contentTextView.editable = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *updateLog = [userDefaults objectForKey:kVersionUpdateLog];
    
    contentTextView.text = updateLog;
    contentTextView.font = [UIFont boldSystemFontOfSize:16];
    [contentTextView setTextColor:[UIColor colorWithHex:@"474747"]];
    [contentTextView setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:contentTextView];
    //[contentTextView release];
    
    if (_type == UpdateType_Force) //强制更新
    {
        UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        updateButton.frame = CGRectMake(150, 135, 140, 40);
        [updateButton setTitle:@"确定" forState:UIControlStateNormal];
        [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [updateButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        [updateButton addTarget:self action:@selector(updateNewVersion:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:updateButton];
    }
    else if(_type == UpdateType_NoUpdate)
    {
        contentTextView.text=@"\n当前为最新版本！";
        contentTextView.font=[UIFont systemFontOfSize:22.0];
        contentTextView.textAlignment=UITextAlignmentCenter;
        UIButton *noUpdateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [noUpdateButton setTitle:@"确定" forState:UIControlStateNormal];
        [noUpdateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [noUpdateButton setBackgroundImage:[UIImage imageNamed:@"button_q.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        noUpdateButton.frame = CGRectMake(95, 130, 130, 35);
        [noUpdateButton addTarget:self action:@selector(noUpdateNewVersion:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:noUpdateButton];
    }
    else//普通升级
    {
        UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        updateButton.frame = CGRectMake(20, 135, 130, 35);
        [updateButton setTitle:@"确定" forState:UIControlStateNormal];
        [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [updateButton setBackgroundImage:[UIImage imageNamed:@"button_r.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        [updateButton addTarget:self action:@selector(updateNewVersion:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:updateButton];
        
        UIButton *noUpdateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [noUpdateButton setTitle:@"取消" forState:UIControlStateNormal];
        [noUpdateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [noUpdateButton setBackgroundImage:[UIImage imageNamed:@"button_q.png" imageBundle:loginBundle] forState:UIControlStateNormal];
        noUpdateButton.frame = CGRectMake(170, 135, 130, 35);
        [noUpdateButton addTarget:self action:@selector(noUpdateNewVersion:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:noUpdateButton];
    }
    [contentTextView release];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:upgradeAlert];
    
    [self exChangeOut:contentView dur:0.3];
    
    [upgradeAlert release];
}

/*********************************************************************
 Function description:暂不升级点击事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)noUpdateNewVersion:(id)sender
{
    if (upgradeAlert) {
        [upgradeAlert removeFromSuperview];
    }
}


-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}

/*********************************************************************
 Function description:暂不绑定事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)noBlindDevice:(id)sender
{
    if (m_delegate)
    {
        [m_delegate giveUpBlind];
    }
    
    [bindView removeFromSuperview];
    [bindView release];
    bindView = nil;
}

/*********************************************************************
 Function description:绑定确认事件
 Parameter: sender
 Return value: N/A
 Author: kangqijun
 Remark: override
 *********************************************************************/
- (void)blindDevice:(id)sender
{
    if (m_delegate)
    {
        [m_delegate settingBlindAccountWith:isBlind with:self.blindSwitch];
    }
}

#pragma mark - SettingListCellDelegate
- (void)checkNewVersion
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *newVersion = [userDefaults objectForKey:kLastVersion];
    
    newVersion = [newVersion stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (newVersion == nil || (newVersion != nil && [newVersion isEqualToString:currentVersion]) || (newVersion != nil && [newVersion isEqualToString:@""])||([newVersion compare:currentVersion]))
    {
        [self showUpdataViewWithType:UpdateType_NoUpdate];
    }
    else
    {
        [self showUpdataViewWithType:UpdateType_Normal];
    }
    
}


- (void)cleanCacheFile
{
    ClearFileView *fileView = [[ClearFileView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748) delegate:self];
    [self addSubview:fileView];
    [fileView release];
    
    
    //废除
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
//    bgImageView.image = [UIImage imageNamed:@"login_alertBg.png" imageBundle:loginBundle];
//    
////    CustomAlertView *alertView = [[CustomAlertView alloc] initWithBackgroundView:bgImageView];
//     CustomNewAlertView *alertView = [[CustomNewAlertView alloc] initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    
//    //描述信息
//    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 360, 90)];
//    titleLab.text = @"是否清除本地缓存的所有数据?";
//    titleLab.numberOfLines = 2;
//    titleLab.font = [UIFont boldSystemFontOfSize:14];
//    titleLab.textAlignment = UITextAlignmentCenter;
//    [titleLab setTextColor:[UIColor blackColor]];
//    [titleLab setBackgroundColor:[UIColor whiteColor]];
//    [alertView addTheview:titleLab];
//    [titleLab release];
//
//    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancelButton.frame = CGRectMake(20, 140, 170, 40);
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelButton setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
//    [cancelButton setBackgroundImage:[UIImage imageNamed:@"AlertButton_bg.png" imageBundle:loginBundle] forState:UIControlStateNormal];
//
//    [alertView addButton:cancelButton];
//    
//    
//    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    sureButton.frame = CGRectMake(210, 140, 170, 40);
//    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
//    [sureButton setTitleColor:[UIColor colorWithHex:@"3b6f92"] forState:UIControlStateNormal];
//    [sureButton setBackgroundImage:[UIImage imageNamed:@"AlertButton_bg.png" imageBundle:loginBundle] forState:UIControlStateNormal];
//    [sureButton addTarget:self action:@selector(cleanFile:) forControlEvents:UIControlEventTouchUpInside];
//    [alertView addButton:sureButton];
//        
//    [alertView show:self];
//    
//    [bgImageView release];
//
//    [alertView release];
}

- (void)blindAccountWith:(BOOL)_isBlind with:(SettingSwitch *)chooseSwitch
{
    self.blindSwitch = chooseSwitch;
    
    isBlind = _isBlind;
    
    bindView = [[DeviceBindView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748) delegate:self withIsBind:isBlind];
    [self addSubview:bindView];

}


- (void)setAutoLoginWith:(BOOL)_isAuto
{
    if (m_delegate)
    {
        [m_delegate settingAutoLoginWith:_isAuto];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [settingList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FoldawayCell";
    
    SettingListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[SettingListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = [indexPath row];
    
    cell.m_delegate = self;
    
    NSDictionary *dic = [settingList objectAtIndex:[indexPath row]];
    
    [cell loadCellDataWith:dic];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == [indexPath row])//修改密码
    {
        changePassWordView = [[ChangePassWordView alloc] initWithFrame:self.frame];
        [changePassWordView.sureButton addTarget:self action:@selector(sendChangePassWordRequest:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:changePassWordView];
        [changePassWordView.oldWordTextField becomeFirstResponder];
        [changePassWordView release];
    }
    else if (0 == [indexPath row])//个人信息
    {
        personView = [[PersonInfoView alloc] initWithFrame:self.frame];
        
        [self setPersonHeaderImage];
        
        [personView.sureButton addTarget:self action:@selector(sureToChangePersonInfo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:personView];
    }
}

- (void)personHeaderImage:(UIImage *)image
{
    self.headerImage = image;
}

- (void)setPersonHeaderImage
{
    if (self.headerImage != nil)
    {
        personView.headerImageView.image = self.headerImage;
        
        return;
    }
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    NSString *username1 = [userDef objectForKey:LASTLOGINUSERNAMEKEY];
    
    if (username1)
    {
        if ([userDef objectForKey:username1])
        {
            NSString *str = [userDef objectForKey:username1];
            
            if (isValid(str))
            {
                UIImage *image = [UIImage imageWithContentsOfFile:str];
                
                if (image)
                {
                    personView.headerImageView.image = image;
                    
                    return;
                }
            }
        }
    }
    
    personView.headerImageView.image = [UIImage imageNamed:@"login_defaultHeader.png" imageBundle:loginBundle];
}

//修改个人信息
- (void)sureToChangePersonInfo
{
    NSString *telephone = [personView.telephoneField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [personView.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *duty = [personView.dutyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *bakTel = [personView.bakTelField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *officeTel = [personView.officeTelField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *bakOfficeTel = [personView.bakOfficeTelField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *perEmail = [personView.perEmailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    
    NSString *msg = nil;
    
    if (telephone == nil || [telephone isEqualToString:@""] ||
             email == nil || [email isEqualToString:@""] )
    {
        msg = @"个人信息不能为空，请重新输入!";
    }
    else if ([telephone isEqualToString:[Userinfo shareUserinfo].telephone] &&
             [email isEqualToString:[Userinfo shareUserinfo].email] &&
             [duty isEqualToString:[Userinfo shareUserinfo].duty] &&
             [bakTel isEqualToString:[Userinfo shareUserinfo].bakTel] &&
             [officeTel isEqualToString:[Userinfo shareUserinfo].officeTel] &&
             [bakOfficeTel isEqualToString:[Userinfo shareUserinfo].bakOfficeTel] &&
             [perEmail isEqualToString:[Userinfo shareUserinfo].perEmail])
    {
        msg = @"个人信息未更改，请重新输入!";
    }
    
    if (msg != nil)
    {
        [self showOperateFinish:msg];
        
        return;
    }
    
    if (m_delegate)
    {
//        if (!([telephone isEqualToString:[Userinfo shareUserinfo].telephone] &&
//            [email isEqualToString:[Userinfo shareUserinfo].email]))
//        {
//            [m_delegate setPersonInfoWithTelephone:telephone email:email];
//        }
//        else if (!([duty isEqualToString:[Userinfo shareUserinfo].duty] &&
//                 [bakTel isEqualToString:[Userinfo shareUserinfo].bakTel] &&
//                 [officeTel isEqualToString:[Userinfo shareUserinfo].officeTel] &&
//                 [bakOfficeTel isEqualToString:[Userinfo shareUserinfo].bakOfficeTel] &&
//                 [perEmail isEqualToString:[Userinfo shareUserinfo].perEmail]))
//        {
           [m_delegate setPersonDetailInfoWithTel:telephone duty:duty bakTel:bakTel officeTel:officeTel bakOfficeTel:bakOfficeTel perEmail:perEmail];
//        }
    }
}

//修改个人信息成功
- (void)setPersonInfoSuccess
{
    [Userinfo shareUserinfo].telephone = personView.telephoneField.text;
    [Userinfo shareUserinfo].email = personView.emailField.text;
    
    [Userinfo shareUserinfo].duty = personView.dutyField.text;
    [Userinfo shareUserinfo].bakTel = personView.bakTelField.text;
    [Userinfo shareUserinfo].officeTel = personView.officeTelField.text;
    [Userinfo shareUserinfo].bakOfficeTel = personView.bakOfficeTelField.text;
    [Userinfo shareUserinfo].perEmail = personView.perEmailField.text;
    
    [personView keyboardWillHidden];
    [personView removeFromSuperview];
}

- (void) deviceBindComplete
{
    [bindView removeFromSuperview];
    [bindView release];
    bindView = nil;
}

//修改密码
- (void)sendChangePassWordRequest:(id)sender
{
    NSString *newsWord = [changePassWordView.newsWordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *reNewWord = [changePassWordView.reNewWordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *msg = nil;
    
    if (changePassWordView.oldWordTextField.text == nil || [changePassWordView.oldWordTextField.text isEqualToString:@""])
    {
        msg = @"旧密码不能为空";
    }
    else if (newsWord == nil || [newsWord isEqualToString:@""] ||
             reNewWord == nil || [reNewWord isEqualToString:@""] )
    {
        msg = @"新密码不能为空";
    }
    else if (![newsWord isEqualToString:reNewWord])
    {
        msg = @"两次输入的新密码不相同，请重新输入";
    }
    else if ([changePassWordView.oldWordTextField.text isEqualToString:newsWord])
    {
        msg = @"旧密码和新密码不能相同，请重新输入";
    }
    else if (!((newsWord.length > 6 || newsWord.length == 6) && (newsWord.length < 15 || newsWord.length == 15)))
    {
        msg = @"新密码不符合要求，请输入6-15个字符！";
    }
    
    if (msg != nil)
    {
        [self showOperateFinish:msg];
        /*
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
         */
    }
    else
    {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:changePassWordView.newsWordTextField.text];
        [arr addObject:changePassWordView.oldWordTextField.text];
        
        if (m_delegate)
        {
            [m_delegate changePassword:arr];
        }
        
        [arr release];
    }
}

//移出修改密码视图
- (void)removeChangePassWordView
{
    [changePassWordView closeChangePassWordView];
}

- (void)dealloc
{
    [settingList release];
    [setTableView release];
    [personView release];
    [super dealloc];
}

-(UITextField *)passwordTextField
{
    return bindView.passwordTextField;
}

- (void)updateInterfaceWithNetworkStatus: (NetworkStatus)status
{
    
    UITableViewCell *modifyPassword = [setTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    UITableViewCell *cell = [setTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    UIControl *autoLoginSwitch = ((SettingListCell *)cell).chooseSwitch;
    
    cell = [setTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    UIControl *bindSwitch = ((SettingListCell *)cell).chooseSwitch;
    
    cell = [setTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    UIButton *updateButton = ((SettingListCell *)cell).toolButton;
    
    
    switch (status)
    {
        case NotReachable:
        {
            modifyPassword.alpha = 0.5;
            modifyPassword.userInteractionEnabled = NO;
            autoLoginSwitch.enabled = NO;
            bindSwitch.enabled = NO;
            updateButton.enabled = NO;
            break;
        }
            
        case ReachableViaWWAN:
        {
            modifyPassword.userInteractionEnabled = YES;
            modifyPassword.alpha = 1.0;
            autoLoginSwitch.enabled = YES;
            bindSwitch.enabled = YES;
            updateButton.enabled = YES;

            break;
        }
        case ReachableViaWiFi:
        {
            modifyPassword.userInteractionEnabled = YES;
            modifyPassword.alpha = 1.0;
            autoLoginSwitch.enabled = YES;
            bindSwitch.enabled = YES;
            updateButton.enabled = YES;
            break;
        }
    }
}
@end
