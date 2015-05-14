//
//  BusinessLevelTwoView.m
//  BusinessProcess
//
//  Created by wanghao on 14-3-12.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessProcessLevelTwoView.h"
#import "TabButton.h"
#import "BusinessDefine.h"
#import "InsetTextField.h"
#import "CustomListBox.h"
#import "BusinessProcessButton.h"
#import "TimeButton.h"

//#define FrameWidth              self.frame.size.width
//#define FrameHeight             self.frame.size.height

#define FrameWidth              (SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH)
#define FrameHeight             (SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_WIDTH : SCREEN_HEIGHT)

#define TitleBgHeight           44
#define NavBarHeight            20

#define TopBorderWidth          5
#define LeftShadowWidth         15
#define LeftBorderWidth         13
#define ContentFrameWidth       FrameWidth
#define ContentFrameHeight      FrameHeight - NavBarHeight
#define SideBorderWidth         10

#define TableCellHeight         20

#define SearchCellTitleWidth    (FrameWidth == 480 ? 80 : 95)
#define SearchCellContentWidth  (FrameWidth == 480 ? 120 : 135)
#define SearchCellHeight        20
#define SearchButtonCellWidth   (FrameWidth == 480 ? 60 : 88)
#define SearchButtonBorder      (FrameWidth == 480 ? 10 : 19)

#define BackGroundViewFrame     CGRectMake(-15, 0, FrameWidth, FrameHeight)
#define BackGroundImage         [UIImage imageNamed:@"bg.png" imageBundle:businessProcessBundle]

#define WhiteBgViewFrame        CGRectMake(0, NavBarHeight + TitleBgHeight - 3, FrameWidth, FrameHeight-NavBarHeight)

#define TitleBgImage            [UIImage imageNamed:@"titleBar_bg.png" imageBundle:businessProcessBundle]
#define TitleBgViewFrame        CGRectMake(0, NavBarHeight, ContentFrameWidth, TitleBgHeight)
#define TitleViewFrame          CGRectMake(0, NavBarHeight, ContentFrameWidth, TitleBgHeight)
#define TitleLabelViewFrame     CGRectMake(0, 0, ContentFrameWidth, TitleBgHeight - 3)

#define TabButtonFrame          CGRectMake(((FrameHeight > FrameWidth ? FrameHeight : FrameWidth) / 2) - 85, 5, 170, 30)

#define TabBtnBackGroundImage   [UIImage imageNamed:@"title_qh_1.png" imageBundle:contactsBundle]
#define TabBtnStateOnImage      [UIImage imageNamed:@"title_qh_2.png" imageBundle:contactsBundle]

#define BackButtonImage         [UIImage imageNamed:@"t_back.png" imageBundle:mainBundle]
#define BackButtonFrame         CGRectMake(10, NavBarHeight+5, 40, 30)

#define TableTitleViewFrame     CGRectMake(SideBorderWidth, TopBorderWidth, ContentFrameWidth - SideBorderWidth * 2, TableCellHeight)
#define TableContentViewFrame   CGRectMake(SideBorderWidth, TopBorderWidth + TableCellHeight - 1, ContentFrameWidth - SideBorderWidth * 2, ContentFrameHeight - TopBorderWidth - TitleBgHeight- TableCellHeight - 10 - 1)


#define BorderColor             [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1.0]

#define CellTextColor           [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0]
#define CellTitleBgColor        [UIColor colorWithRed:234/255.0 green:241/255.0 blue:247/255.0 alpha:1.0]
#define CellTextFont            [UIFont boldSystemFontOfSize:18]

#define TextFieldBgImage        [UIImage imageNamed:@"bg_input_style3.png" imageBundle:publicResourceBundle]

@interface BusinessProcessLevelTwoView() <TabButtonDelegate>
{
    NSInteger m_selectedTabIndex;
    
    UIView *m_searchView;
    
    TimeButton *m_beginTime;
    
    TimeButton *m_endTime;
    
    InsetTextField *m_shipName;
    
    InsetTextField *m_voyage;
    
    CustomListBox  *m_jobCom;
    
    CustomListBox  *m_audit;
    
    NSArray *m_jobComNameList;
    
    NSArray *m_jobComIdList;
}

@end

@implementation BusinessProcessLevelTwoView
@synthesize m_beginTime;
@synthesize m_endTime;

@synthesize delegate = m_delegate;

@synthesize jobComNameList = m_jobComNameList, jobComIdList = m_jobComIdList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *whiteBgView = [[UIView alloc] initWithFrame:WhiteBgViewFrame];
        whiteBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteBgView];
        [whiteBgView release];
        
        UIImageView *titleBgView = [[UIImageView alloc] initWithImage:[TitleBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:(UIImageResizingModeStretch)]];
        titleBgView.frame = TitleBgViewFrame;
        [self addSubview:titleBgView];
        [titleBgView release];
        
        m_titleView = [[UIView alloc] initWithFrame:TitleViewFrame];
        [self addSubview:m_titleView];

        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = BackButtonFrame;
        [backButton setBackgroundImage:BackButtonImage forState:UIControlStateNormal];
        [backButton addTarget:self
                       action:@selector(closeView)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];

        [self setProcessType:BusinessLargeCommission andProcessTypeName:nil];

        m_tableContentView = [[UIView alloc] initWithFrame:TableContentViewFrame];
        [whiteBgView addSubview:m_tableContentView];
        
        m_tableTitleView = [[UIView alloc] initWithFrame:TableTitleViewFrame];
        [whiteBgView addSubview:m_tableTitleView];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

//键盘显示
- (void)keyboardWillShow
{
    keyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    [self addGestureRecognizer:keyboardTap];
}

//键盘隐藏
- (void)keyboardWillHidden
{
    [self removeGestureRecognizer:keyboardTap];
    [keyboardTap release];
}

- (void) hiddenKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void) setTableTitleView : (UIView *)view
{
    for (UIView *tmpView in m_tableTitleView.subviews) {
        [tmpView removeFromSuperview];
    }
    
    [m_tableTitleView addSubview:view];
}

- (void) setTableContentView : (UIView *)view
{
    for (UIView *tmpView in m_tableContentView.subviews) {
        [tmpView removeFromSuperview];
    }
    
    [m_tableContentView addSubview:view];
}

- (CGRect)tableViewFrame
{
    CGRect tableFrame = m_tableContentView.frame;
    tableFrame.origin.x = 0;
    tableFrame.origin.y = 0;
    
    return tableFrame;
}

- (void)setProcessType:(NSInteger)processType andProcessTypeName : (NSString *) processTypeName
{
    for (UIView *tmpSubView in m_titleView.subviews)
    {
        [tmpSubView removeFromSuperview];
    }

    if (processType == BusinessLargeCommission)
    {
        m_tableTitleView.frame = TableTitleViewFrame;
        m_tableContentView.frame = TableContentViewFrame;

        [self createSearchView];

        TabButton *tabBtn = [[TabButton alloc] initWithFrame:TabButtonFrame
                                             andButtonTitles:@"有船作业",@"无船作业", nil];
        
        tabBtn.backGroundImage = TabBtnBackGroundImage;
        tabBtn.buttonBackGroundImage = TabBtnStateOnImage;
        
        tabBtn.delegate = self;
        [m_titleView addSubview:tabBtn];
        
        [tabBtn release];
    }
    else
    {
        m_tableTitleView.frame = TableTitleViewFrame;
        m_tableContentView.frame = TableContentViewFrame;

        UILabel *titleLab = [[UILabel alloc] initWithFrame:TitleLabelViewFrame];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont boldSystemFontOfSize:24];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = processTypeName;
        
        [m_titleView addSubview:titleLab];
        
        [titleLab release];
        
        [m_searchView removeFromSuperview];
        [m_searchView release];
        m_searchView = nil;
    }
    
}

- (void) dealloc
{
    [m_titleView release];
    [m_tableTitleView release];
    [m_tableContentView release];
    [m_searchView release];
    [tabNameLbl release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [super dealloc];
}

- (void) closeView
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(closeBtnClick)]) {
        [m_delegate closeBtnClick];
    }
}

- (void)clickTagButtonWithBtnTag:(NSInteger)tagIndex
{
    m_selectedTabIndex = tagIndex;
    
    [self createSearchView];
    
    if (tagIndex == 0) {
        tabNameLbl.text = @"有船作业申请";
    }else {
        tabNameLbl.text = @"无船作业申请";
    }
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(tabButtonClick:)]) {
        [m_delegate tabButtonClick:tagIndex];
    }
}

- (void)createSearchView
{
    if (m_searchView) {
        [m_searchView removeFromSuperview];
        [m_searchView release];
        m_searchView = nil;
    }
    
    m_searchView = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateFormat stringFromDate:[NSDate date]];
    
    CGFloat originY = 0.0;
    
    UILabel *startTimeLabel = [self createSearchCellTitle:@"开始时间" withFrame:CGRectMake(0, originY, SearchCellTitleWidth + 1, SearchCellHeight + 1)];
    
    [m_searchView addSubview:startTimeLabel];
    
    m_beginTime = [TimeButton buttonWithType:UIButtonTypeCustom];
    m_beginTime.frame = CGRectMake(SearchCellTitleWidth, originY, SearchCellContentWidth + 1, SearchCellHeight + 1);
    m_beginTime.time = today;
    
//    [[UIButton alloc] initWithFrame:CGRectZero];
//    m_beginTime.frame = CGRectMake(SearchCellTitleWidth, originY, SearchCellContentWidth + 1, SearchCellHeight + 1);
//    [m_beginTime setBackgroundImage:[TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(5,10,5,10)] forState:(UIControlStateNormal)];
//    m_beginTime.titleLabel.font = [UIFont systemFontOfSize:10.0];
//    [m_beginTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    m_beginTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    m_beginTime.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
//    m_beginTime.tag = 1000;
//    [m_beginTime addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventTouchUpInside];
    [m_searchView addSubview:m_beginTime];
//    [m_beginTime setTitle:today forState:UIControlStateNormal];
    
    UILabel *endTimeLabel = [self createSearchCellTitle:@"结束时间" withFrame:CGRectMake(SearchCellTitleWidth + SearchCellContentWidth, originY, SearchCellTitleWidth + 1, SearchCellHeight + 1)];
    
    [m_searchView addSubview:endTimeLabel];
    
    m_endTime = [TimeButton buttonWithType:UIButtonTypeCustom];
    m_endTime.frame = CGRectMake(SearchCellTitleWidth * 2 + SearchCellContentWidth, originY, SearchCellContentWidth + 1, SearchCellHeight + 1);
    m_endTime.time = today;

//    m_endTime = [[UIButton alloc] initWithFrame:CGRectZero];
//    m_endTime.frame = CGRectMake(SearchCellTitleWidth * 2 + SearchCellContentWidth, originY, SearchCellContentWidth + 1, SearchCellHeight + 1);
//    [m_endTime setBackgroundImage:[TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(5,10,5,10)] forState:(UIControlStateNormal)];
//    m_endTime.titleLabel.font = [UIFont systemFontOfSize:10.0];
//    [m_endTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    m_endTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    m_endTime.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
//    m_endTime.tag = 1001;
//    [m_endTime addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventTouchUpInside];
    [m_searchView addSubview:m_endTime];
//    [m_endTime setTitle:today forState:UIControlStateNormal];
    
    originY += SearchCellHeight;
    
    [self addSubview:m_searchView];
    
    if (m_selectedTabIndex == 0) {
    
        UILabel *shipNameLabel = [self createSearchCellTitle:@"船名" withFrame:CGRectMake(0, originY, SearchCellTitleWidth + 1, SearchCellHeight + 1)];
        
        [m_searchView addSubview:shipNameLabel];
        
        if (!m_shipName) {
            
            m_shipName = [[InsetTextField alloc] initWithFrame:CGRectZero];
            
            m_shipName.background = [TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(5,10,5,10)];
            m_shipName.inset = CGPointMake(20, 0);
        }
        
        m_shipName.frame = CGRectMake(SearchCellTitleWidth, originY, SearchCellContentWidth+1, SearchCellHeight +1);
        
        [m_searchView addSubview:m_shipName];
        
        UILabel *voyageLabel = [self createSearchCellTitle:@"航次" withFrame:CGRectMake(SearchCellTitleWidth + SearchCellContentWidth, originY, SearchCellTitleWidth + 1, SearchCellHeight + 1)];
        
        [m_searchView addSubview:voyageLabel];
        
        if (!m_voyage) {
            m_voyage = [[InsetTextField alloc] initWithFrame:CGRectZero];
            
            m_voyage.background = [TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(5,10,5,10)];
            m_voyage.inset = CGPointMake(20, 0);
        }
        
        m_voyage.frame = CGRectMake(SearchCellTitleWidth * 2 + SearchCellContentWidth, originY, SearchCellContentWidth + 1, SearchCellHeight +1);
        
        [m_searchView addSubview:m_voyage];
        
        originY += SearchCellHeight;
        
    }
    else
    {
        [m_shipName removeFromSuperview];
        [m_voyage removeFromSuperview];
    }
    
    UILabel *jobComLabel = [self createSearchCellTitle:@"作业公司" withFrame:CGRectMake(0, originY, SearchCellTitleWidth + 1, SearchCellHeight + 1)];
    
    [m_searchView addSubview:jobComLabel];
    
    if (!m_jobCom) {
        m_jobCom = [[CustomListBox alloc] initWithFrame:CGRectZero];
        
    }
    
    m_jobCom.frame = CGRectMake(SearchCellTitleWidth, originY, SearchCellContentWidth+1, SearchCellHeight +1);
    
    [m_searchView addSubview:m_jobCom];
    
    UILabel *blankTitleLabel = [self createSearchCellTitle:@"审核状态" withFrame:CGRectMake(SearchCellTitleWidth + SearchCellContentWidth, originY, SearchCellTitleWidth + 1, SearchCellHeight + 1)];
    
    [m_searchView addSubview:blankTitleLabel];
    
    if (!m_audit) {
        m_audit = [[CustomListBox alloc] initWithFrame:CGRectZero];
        
        [m_audit bindingDataSource:[NSArray arrayWithObjects:@"未审核",@"已审核", nil]];
        [m_audit bindingDataValue:[NSArray arrayWithObjects:@"0", @"1", nil]];
    }
    
    m_audit.frame = CGRectMake(SearchCellTitleWidth * 2 + SearchCellContentWidth, originY, SearchCellContentWidth+1, SearchCellHeight +1);
    
    [m_searchView addSubview:m_audit];
    
    [m_searchView bringSubviewToFront:m_endTime];
    [m_searchView bringSubviewToFront:m_voyage];
    
    originY += SearchCellHeight;
    
    UIView *confirmView = [[UIView alloc] initWithFrame:CGRectZero];
    confirmView.frame = CGRectMake((SearchCellTitleWidth + SearchCellContentWidth) * 2, 0, SearchButtonCellWidth, originY + 1);
    confirmView.backgroundColor = [UIColor clearColor];
    confirmView.layer.borderColor = [BorderColor CGColor];
    confirmView.layer.borderWidth = 1;
    [m_searchView addSubview:confirmView];
    
    BusinessProcessButton *confirmBtn = [BusinessProcessButton buttonWithTitle:@"确定"];
    confirmBtn.frame = CGRectMake(SearchButtonBorder, (originY - SearchCellHeight)/2, SearchButtonCellWidth - SearchButtonBorder * 2, SearchCellHeight);
    [confirmBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmView addSubview:confirmBtn];
    
    [confirmView release];
    
    tabNameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    tabNameLbl.font = [UIFont systemFontOfSize:13];
    tabNameLbl.backgroundColor = [UIColor clearColor];
    tabNameLbl.textAlignment = NSTextAlignmentLeft;
    tabNameLbl.text = @"有船作业申请";
    
    [m_searchView addSubview:tabNameLbl];
    
    tabNameLbl.frame = CGRectMake(SideBorderWidth, originY, 120, SearchCellHeight);
    
    originY += SearchCellHeight;
    
    m_searchView.frame = CGRectMake(SideBorderWidth, TitleBgHeight + TopBorderWidth + NavBarHeight, ContentFrameWidth, originY);
    
    [self addSubview:m_searchView];
    
    CGRect titleFrame = TableTitleViewFrame;
    titleFrame.origin.y += m_searchView.frame.size.height + 1;
    m_tableTitleView.frame = titleFrame;
    
    CGRect contentFrame = TableContentViewFrame;
    contentFrame.origin.y += m_searchView.frame.size.height + 1;
    contentFrame.size.height -= m_searchView.frame.size.height;
    m_tableContentView.frame = contentFrame;
    
}

- (BOOL)checkStartTime:(NSString *)startTime EndTime:(NSString *)endTime
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];

    NSDate *date1 = [df dateFromString:startTime];
    NSDate *date2 = [df dateFromString:endTime];

    [df release];

    switch ([date1 compare:date2]) {
        case NSOrderedSame:
            return YES;
        case NSOrderedAscending:
            return YES;
        case NSOrderedDescending:
            return NO;
        default:
            return NO;;
    }
}

- (void) searchBtnClick
{
    BOOL isDateOK =[self checkStartTime:m_beginTime.time
                                EndTime:m_endTime.time];
    if (!isDateOK)
    {
        if (m_delegate &&[m_delegate respondsToSelector:@selector(showAlert:withMsg:)]) {
            [m_delegate showAlert:@"请调整日期!" withMsg:nil];
        }
        
        return;
    }
    if (m_delegate && [m_delegate respondsToSelector:@selector(search:)]) {
        NSMutableDictionary *dKeys = [[[NSMutableDictionary alloc] init] autorelease];
        
        [dKeys setObject:(m_beginTime.time?m_beginTime.time:@"")
                  forKey:@"beginDate"];
        [dKeys setObject:(m_endTime.time?m_endTime.time:@"") forKey:@"endDate"];
        [dKeys setObject:(m_shipName.text?m_shipName.text:@"") forKey:@"shipName"];
        [dKeys setObject:(m_voyage.text?m_voyage.text:@"") forKey:@"voyage"];
        [dKeys setObject:(m_jobCom.selectedValue?m_jobCom.selectedValue:@"") forKey:@"jobCompanyId"];
        [dKeys setObject:(m_audit.selectedValue?m_audit.selectedValue:@"") forKey:@"auditMark"];
        
        [m_delegate search:dKeys];
    }
}


- (UILabel *)createSearchCellTitle:(NSString *)title withFrame : (CGRect)frame
{
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
    titleLabel.backgroundColor = CellTitleBgColor;
    titleLabel.textColor = CellTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.layer.borderColor = [BorderColor CGColor];
    titleLabel.layer.borderWidth = 1;
    titleLabel.text = title;
    
    return titleLabel;
}

- (void)setJobComNameList:(NSArray *)jobComNameList
{
    m_jobComNameList = jobComNameList;
    
    [m_jobCom bindingDataSource:jobComNameList];
}

- (void)setJobComIdList:(NSArray *)jobComIdList
{
    m_jobComIdList = jobComIdList;
    
    [m_jobCom bindingDataValue:jobComIdList];
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
