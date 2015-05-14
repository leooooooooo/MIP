//
//  MyDesktopView.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/13.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "MsgCenterView.h"
#import "MessageClassButton.h"
#import "MessageListButton.h"
#import "WeiboButton.h"
#import "CustomRefreshControl.h"

#define TileBaseX               3
#define TileBaseY               100 - 100

#define PageSeparatorInset      100

#define BaseTag                 120

#define ColumnMaxTileCount      3
#define BaseButtonSize          2

@interface MsgCenterView () <CustomRefreshControlDelegate, UIScrollViewDelegate>
{
    CustomRefreshControl        *_customRefreshControl;
}

@end

@implementation MsgCenterView

@synthesize delegate = m_delegate;

@synthesize m_messageCenterView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        CGRect bgViewFrame = CGRectMake(0, 50, frame.size.width, frame.size.height);
        UIView *bgView = [[UIView alloc] initWithFrame:bgViewFrame];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        CGRect subViewFrame = CGRectMake(0, 55, frame.size.width, frame.size.height - 100);
        
        m_messageCenterView = [[UIScrollView alloc] initWithFrame:subViewFrame];
        
//        m_messageCenterView.pagingEnabled = YES;
        
        m_messageCenterView.contentSize = CGSizeMake(frame.size.width, 568 + 80);
        
        m_messageCenterView.showsHorizontalScrollIndicator = NO;
        
        m_messageCenterView.delegate = self;
        
        [self addSubview:m_messageCenterView];
        
        m_listTiles = [[NSMutableDictionary alloc] init];
        
        _customRefreshControl = [[CustomRefreshControl alloc] init];
        
        UIView *headerView = [_customRefreshControl createHeaderViewWithFrame:CGRectMake(0.0f, -170.0f, self.frame.size.width, 170.0f)];
        
        _customRefreshControl.delegate = self;
        
        [m_messageCenterView addSubview:headerView];
        
        [_customRefreshControl refreshHeaderLastUpdatedDate];
    }
    return self;
}

- (void) dealloc
{
    [m_listTiles release];
    
    [m_messageCenterView release];
    
    m_delegate = nil;
    
    _customRefreshControl.delegate = nil;
    [_customRefreshControl release];
    
    [super dealloc];
}

- (void) addBaseTileButton
{
    CGRect tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset, 304, 110);
    
    //今日待办
    [self createBaseTileButtonWithBtnIcon:1 withBtnTitle:@"今日待办" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset + 110 + TileSeparatorInset, 120, 90);

    //未读邮件
    [self createBaseTileButtonWithBtnIcon:2 withBtnTitle:@"未读邮件" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset + 110 + TileSeparatorInset + 90 + TileSeparatorInset, 120, 90);

    //未读通告
    [self createBaseTileButtonWithBtnIcon:3 withBtnTitle:@"未读通告" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset + 120 + TileSeparatorInset, TileBaseY + TileSeparatorInset + 110 + TileSeparatorInset, 179, 185);

    //RTX消息
    [self createBaseTileButtonWithBtnIcon:4 withBtnTitle:@"RTX消息" withFrame:tileFrame];

    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset + 110 + TileSeparatorInset + 90 + TileSeparatorInset + 90 + TileSeparatorInset, 149.5, 110);
    
    //网上公文
    [self createBaseTileButtonWithBtnIcon:5 withBtnTitle:@"网上公文" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset + 149.5 + TileSeparatorInset, TileBaseY + TileSeparatorInset + 110 + TileSeparatorInset + 90 + TileSeparatorInset + 90 + TileSeparatorInset, 149.5, 110);
    
    //集团新闻
    [self createBaseTileButtonWithBtnIcon:6 withBtnTitle:@"集团新闻" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset + 110 + TileSeparatorInset + 90 + TileSeparatorInset + 90 + TileSeparatorInset + 110 + TileSeparatorInset, 175, 185);
    
    //云之家动态
    [self createBaseTileButtonWithBtnIcon:7 withBtnTitle:@"云之家动态" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset + 175 + TileSeparatorInset, TileBaseY + TileSeparatorInset + 110 + TileSeparatorInset + 90 + TileSeparatorInset + 90 + TileSeparatorInset + 110 + TileSeparatorInset, 123, 58);
    
    //我的粉丝
    [self createBaseTileButtonWithBtnIcon:8 withBtnTitle:@"我的粉丝" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset + 175 + TileSeparatorInset, TileBaseY + TileSeparatorInset + 110 + TileSeparatorInset + 90 + TileSeparatorInset + 90 + TileSeparatorInset + 110 + TileSeparatorInset + 58 + TileSeparatorInset, 123, 58);
    
    //我的关注
    [self createBaseTileButtonWithBtnIcon:9 withBtnTitle:@"我的关注" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset + 175 + TileSeparatorInset, TileBaseY + TileSeparatorInset + 110 + TileSeparatorInset + 90 + TileSeparatorInset + 90 + TileSeparatorInset + 110 + TileSeparatorInset + 58 + TileSeparatorInset + 58 + TileSeparatorInset, 123, 58);
    
    //我的微博
    [self createBaseTileButtonWithBtnIcon:10 withBtnTitle:@"我的微博" withFrame:tileFrame];
}

- (void) createBaseTileButtonWithBtnIcon : (NSInteger) index
                            withBtnTitle : (NSString *) btnTitle
                               withFrame : (CGRect) frame
{
    MessageButton *baseBtn = nil;
    
    if ([btnTitle isEqualToString:@"未读邮件"] ||
        [btnTitle isEqualToString:@"RTX消息"] ||
        [btnTitle isEqualToString:@"网上公文"]) {
        
        baseBtn = [[MessageClassButton alloc] initWithFrame:frame];
        
    }else if ([btnTitle isEqualToString:@"未读通告"]) {
        baseBtn = [[MessageClassButton alloc] initWithFrame:frame];
        [m_listTiles setObject:baseBtn forKey:btnTitle];
    }else if ([btnTitle isEqualToString:@"我的粉丝"] ||
              [btnTitle isEqualToString:@"我的关注"] ||
              [btnTitle isEqualToString:@"我的微博"]) {
        
        baseBtn = [[WeiboButton alloc] initWithFrame:frame];
        [m_listTiles setObject:baseBtn forKey:btnTitle];
    }
    else {
        baseBtn = [[MessageListButton alloc] initWithFrame:frame];
        [m_listTiles setObject:baseBtn forKey:btnTitle];
    }
    
    NSString *iconName = [NSString stringWithFormat:@"xx_%d.png",index];
    
    baseBtn.appIcon = [UIImage imageNamed:iconName imageBundle:mainBundle];
    
    [m_messageCenterView addSubview:baseBtn];
    
    [baseBtn addTarget:self action:@selector(clickMsgTileButton:) forControlEvents:UIControlEventTouchUpInside];
    
    baseBtn.strBtnTitle = btnTitle;
    
    baseBtn.tag = index + BaseTag;
    
    [baseBtn release];
}

- (void) clickMsgTileButton : (id) sender
{
    MessageButton *appBtn = (MessageButton *)sender;
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(clickMsgTileButton:)]) {
        [m_delegate clickMsgTileButton:(appBtn.tag - BaseTag)];
    }
}

- (void) setNewsTitle : (NSArray *)titleList withClassName : (NSString *)className
{
    NSString *keyName = nil;
    
    if ([className isEqualToString:@"云之家微博"]) {
        keyName = @"云之家动态";
    }else if ([className isEqualToString:@"我的待办"]){
        keyName = @"今日待办";
    }else if ([className isEqualToString:@"集团要闻"]){
        keyName = @"集团新闻";
    }else if ([className isEqualToString:@"通知公告"]){
        keyName = @"未读通告";
    }else {
        keyName = className;
    }
    
    id tmpBtn = [m_listTiles objectForKey:keyName];
    
    if ([tmpBtn isKindOfClass:[MessageListButton class]]) {
        MessageListButton *msgButton = [m_listTiles objectForKey:keyName];
        msgButton.newsArr = titleList;
    }else if ([tmpBtn isKindOfClass:[MessageClassButton class]]) {
        if ([((MessageClassButton *)tmpBtn).strBtnTitle isEqualToString:@"未读通告"]) {
            ((MessageClassButton *)tmpBtn).strBtnTitle = [NSString stringWithFormat:@"%@ %d",((MessageClassButton *)tmpBtn).strBtnTitle,titleList.count];
        }
    }else {
        WeiboButton *msgButton = [m_listTiles objectForKey:keyName];
        msgButton.newsArr = titleList;
    }
}

#pragma mark -
#pragma mark ScrollView Move Methods
//scrollView拖拽开始事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_customRefreshControl refreshScrollViewDidScroll:scrollView];
}
//scrollView拖拽结束事件
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_customRefreshControl refreshScrollViewDidEndDragging:scrollView];
}

//下拉更新结束后，调用，用于scrollView复位
- (void)doneLoadingHeaderTableViewData{
	
	[_customRefreshControl refreshScrollViewDataSourceDidFinishedHeaderLoading:m_messageCenterView];
}

- (void)refreshTableHeaderDidTriggerRefresh:(CustomRefreshControl*)view {
    //发送刷新请求
    if (m_delegate && [m_delegate respondsToSelector:@selector(refreshMsgView)]) {
        [m_delegate refreshMsgView];
    }
}

- (NSDate*)refreshTableHeaderDataSourceLastUpdated:(CustomRefreshControl*)view {
    
    return [NSDate date];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
