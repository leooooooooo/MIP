//
//  JobProcessView.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "JobProcessView.h"
#import "InsetTextField.h"
#import "BusinessProcessButton.h"
#import "CustomListBox.h"
#import "BusinessCheckBox.h"
#import "TimeButton.h"
#import "AlertView.h"
#define FrameWidth              568
#define FrameHeight             320-20-44

#define TopBorderWidth          10
#define SideBorderWidth         10

#define TableWidth              FrameWidth - SideBorderWidth * 2

#define ProcessTableHeight      245
#define ButtonTableHeight       70

#define CellHeight              35

#define LeftTitleWidth          40
#define DetailContentWidth      TableWidth - LeftTitleWidth

#define TitleCellWidth          95
#define SmallTitleCellWidth     75
#define SmallCellWidth          120
#define LargeCellWidth          195

#define LeftBtnCellWidth        113
#define RightBtnCellWidth       105

#define BorderColor         [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0]

#define LeftTitleTextColor  [UIColor whiteColor]
#define LeftTitleBgColor    [UIColor colorWithRed:136/255.0 green:164/255.0 blue:196/255.0 alpha:1.0]

#define TitleCellBgColor    [UIColor colorWithRed:234/255.0 green:241/255.0 blue:247/255.0 alpha:1.0]

#define TitleTextColor      [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0]
#define ContentTextColor    [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1.0]
#define ContentBgColor      [UIColor whiteColor]

#define TitleCellTextFont   [UIFont boldSystemFontOfSize:16]
#define DetailCellTextFont  [UIFont boldSystemFontOfSize:13]

#define TextFieldBgImage    [UIImage imageNamed:@"bg_input_style3.png" imageBundle:publicResourceBundle]

@interface JobProcessView()
{
    UILabel *curBerthLab;
    InsetTextField *unloadMarginLab;
    UILabel *unloadCountLab;
    UILabel *totalStopTimeLab;
    InsetTextField *todayUnloadCountLab;
    InsetTextField *todayStopTimeLab;
    TimeButton *unloadStartTimeLab;
    TimeButton *unloadEndTimeLab;
    TimeButton *loadingStartTimeLab;
    TimeButton *loadingEndTimeLab;
    
    BusinessProcessButton *unloadStart;
    BusinessProcessButton *unloadEnd;
    BusinessProcessButton *loadingStart;
    BusinessProcessButton *loadingEnd;
    
    BusinessCheckBox *unloadStartCheck;
    BusinessCheckBox *unloadEndCheck;
    BusinessCheckBox *loadingStartCheck;
    BusinessCheckBox *loadingEndCheck;
}

@end

@implementation JobProcessView

@synthesize delegate = m_delegate;

@dynamic curBerth, unloadMargin, unloadCount, totalStopTime, todayUnloadCount, todayStopTime;
@dynamic unloadStartTime, unloadEndTime, loadingStartTime, loadingEndTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, FrameWidth, FrameHeight + 20)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.contentSize = CGSizeMake(FrameWidth, ProcessTableHeight + ButtonTableHeight + TopBorderWidth * 2);
        [self addSubview:scrollView];
        
        UIView *processTable = [[UIView alloc] initWithFrame:CGRectZero];
        processTable.frame = CGRectMake(SideBorderWidth, TopBorderWidth, TableWidth, ProcessTableHeight);
        processTable.backgroundColor = [UIColor clearColor];
        
        [scrollView addSubview:processTable];
        
        UILabel *processTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LeftTitleWidth, ProcessTableHeight+1)];
        processTitle.backgroundColor = LeftTitleBgColor;
        processTitle.textColor = LeftTitleTextColor;
        processTitle.textAlignment = NSTextAlignmentCenter;
        processTitle.font = TitleCellTextFont;
        processTitle.numberOfLines = 7;
        processTitle.text = @"载\n\n货\n\n信\n\n息";
        processTitle.layer.borderColor = [BorderColor CGColor];
        processTitle.layer.borderWidth = 1;
        
        [processTable addSubview:processTitle];
        
        [processTitle release];
        
        UIView *processContent = [[UIView alloc] initWithFrame:CGRectMake(LeftTitleWidth - 1, 0, DetailContentWidth + 1, ProcessTableHeight + 1)];
        processContent.backgroundColor = [UIColor whiteColor];
        processContent.layer.borderColor = [BorderColor CGColor];
        processContent.layer.borderWidth = 1;
        [processTable addSubview:processContent];
        
        [self createLabel:@"当前靠停泊位" withFrame:CGRectMake(0,0,TitleCellWidth,CellHeight)
             andSuperView:processContent];
        
        UIView *berthView = [[UIView alloc] initWithFrame:CGRectMake(TitleCellWidth,0,SmallCellWidth+1,CellHeight+1)];
        berthView.layer.borderColor = [BorderColor CGColor];
        berthView.layer.borderWidth = 1;
        
        curBerthLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SmallCellWidth-10, CellHeight)];
        curBerthLab.backgroundColor = [UIColor clearColor];
        curBerthLab.textColor = ContentTextColor;
        curBerthLab.font = DetailCellTextFont;
        
        [berthView addSubview:curBerthLab];
        
        [processContent addSubview:berthView];
        
        [berthView release];
        
        [self createLabel:@"卸货余吨"
                withFrame:CGRectMake(TitleCellWidth + SmallCellWidth,0,SmallTitleCellWidth,CellHeight)
             andSuperView:processContent];
        
        unloadMarginLab = [[InsetTextField alloc] initWithFrame:CGRectZero];
        unloadMarginLab.frame = CGRectMake(TitleCellWidth + SmallCellWidth + SmallTitleCellWidth, 0, LeftBtnCellWidth+1, CellHeight+1);
        unloadMarginLab.background = [TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        unloadMarginLab.inset = CGPointMake(10, 0);
        unloadMarginLab.textColor = ContentTextColor;
        unloadMarginLab.font = DetailCellTextFont;
        [processContent addSubview:unloadMarginLab];
        
        UIView *saveMarginBtnView = [[UIView alloc] initWithFrame:CGRectZero];
        saveMarginBtnView.frame = CGRectMake(TitleCellWidth + SmallCellWidth + SmallTitleCellWidth + LeftBtnCellWidth, 0, RightBtnCellWidth+1, CellHeight+1);
        saveMarginBtnView.layer.borderColor = [BorderColor CGColor];
        saveMarginBtnView.layer.borderWidth = 1;
        
        [processContent addSubview:saveMarginBtnView];
        
        BusinessProcessButton *saveMargin = [BusinessProcessButton buttonWithTitle:@"余吨保存"];
        saveMargin.frame = CGRectMake(2, 2, saveMarginBtnView.frame.size.width - 4, saveMarginBtnView.frame.size.height - 4);
        [saveMarginBtnView addSubview:saveMargin];
        [saveMargin addTarget:self action:@selector(saveMarginValue) forControlEvents:UIControlEventTouchUpInside];
        
        [saveMarginBtnView release];
        
        [self createLabel:@"船舶考核信息" withFrame:CGRectMake(0,CellHeight,TitleCellWidth,CellHeight * 2)
             andSuperView:processContent];
        
        UIView *assessmentView = [[UIView alloc] initWithFrame:CGRectMake(TitleCellWidth,CellHeight,SmallCellWidth+1,CellHeight * 2 + 1)];
        assessmentView.layer.borderColor = [BorderColor CGColor];
        assessmentView.layer.borderWidth = 1;
        
        UILabel *unloadCountTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 55, CellHeight)];
        unloadCountTitle.backgroundColor = [UIColor clearColor];
        unloadCountTitle.textColor = TitleTextColor;
        unloadCountTitle.font = DetailCellTextFont;
        unloadCountTitle.text = @"卸船数：";
        [assessmentView addSubview:unloadCountTitle];
        [unloadCountTitle release];
        
        UILabel *totalTimeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, CellHeight, 55, CellHeight)];
        totalTimeTitle.backgroundColor = [UIColor clearColor];
        totalTimeTitle.textColor = TitleTextColor;
        totalTimeTitle.font = DetailCellTextFont;
        totalTimeTitle.text = @"总停时：";
        [assessmentView addSubview:totalTimeTitle];
        [totalTimeTitle release];
        
        unloadCountLab = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 55, CellHeight)];
        unloadCountLab.backgroundColor = [UIColor clearColor];
        unloadCountLab.textColor = ContentTextColor;
        unloadCountLab.font = DetailCellTextFont;
        unloadCountLab.text = @"0";
        [assessmentView addSubview:unloadCountLab];
        
        totalStopTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(65, CellHeight, 55, CellHeight)];
        totalStopTimeLab.backgroundColor = [UIColor clearColor];
        totalStopTimeLab.textColor = ContentTextColor;
        totalStopTimeLab.font = DetailCellTextFont;
        totalStopTimeLab.text = @"0";
        [assessmentView addSubview:totalStopTimeLab];
        
        [processContent addSubview:assessmentView];
        
        [assessmentView release];
        
        [self createLabel:@"今日卸船数\n\n今日停时"
                withFrame:CGRectMake(TitleCellWidth + SmallCellWidth, CellHeight, SmallTitleCellWidth,CellHeight * 2)
             andSuperView:processContent];
        
        todayUnloadCountLab = [[InsetTextField alloc] initWithFrame:CGRectZero];
        todayUnloadCountLab.frame = CGRectMake(TitleCellWidth + SmallCellWidth + SmallTitleCellWidth, CellHeight, LeftBtnCellWidth+1, CellHeight+1);
        todayUnloadCountLab.background = [TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        todayUnloadCountLab.inset = CGPointMake(10, 0);
        todayUnloadCountLab.textColor = ContentTextColor;
        todayUnloadCountLab.font = DetailCellTextFont;
        todayUnloadCountLab.text = @"0";
        
        [processContent addSubview:todayUnloadCountLab];
        
        todayStopTimeLab = [[InsetTextField alloc] initWithFrame:CGRectZero];
        todayStopTimeLab.frame = CGRectMake(TitleCellWidth + SmallCellWidth + SmallTitleCellWidth, CellHeight * 2, LeftBtnCellWidth+1, CellHeight+1);
        todayStopTimeLab.background = [TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        todayStopTimeLab.inset = CGPointMake(10, 0);
        todayStopTimeLab.textColor = ContentTextColor;
        todayStopTimeLab.font = DetailCellTextFont;
        todayStopTimeLab.text = @"0";
        [processContent addSubview:todayStopTimeLab];
        
        UIView *confirmAssessmentBtnView = [[UIView alloc] initWithFrame:CGRectZero];
        confirmAssessmentBtnView.frame = CGRectMake(TitleCellWidth + SmallCellWidth + SmallTitleCellWidth + LeftBtnCellWidth, CellHeight, RightBtnCellWidth+1, CellHeight * 2+1);
        confirmAssessmentBtnView.layer.borderColor = [BorderColor CGColor];
        confirmAssessmentBtnView.layer.borderWidth = 1;
        
        [processContent addSubview:confirmAssessmentBtnView];
        
        BusinessProcessButton *confirmAssessment = [BusinessProcessButton buttonWithTitle:@"确认考核信息"];
        confirmAssessment.frame = CGRectMake(2, 2, confirmAssessmentBtnView.frame.size.width - 4, confirmAssessmentBtnView.frame.size.height - 4);
        [confirmAssessmentBtnView addSubview:confirmAssessment];
        [confirmAssessment addTarget:self action:@selector(confirmAssessmentValue) forControlEvents:UIControlEventTouchUpInside];
        
        [confirmAssessmentBtnView release];
        
        [self createLabel:@"卸货开始时间" withFrame:CGRectMake(0,CellHeight * 3,TitleCellWidth,CellHeight)
             andSuperView:processContent];
        
        unloadStartTimeLab = [TimeButton buttonWithType:UIButtonTypeCustom];
        unloadStartTimeLab.frame = CGRectMake(TitleCellWidth, CellHeight * 3, LargeCellWidth+1, CellHeight+1);
        [processContent addSubview:unloadStartTimeLab];
        
        UIView *unloadStartBtnView = [[UIView alloc] initWithFrame:CGRectZero];
        unloadStartBtnView.frame = CGRectMake(TitleCellWidth + LargeCellWidth, CellHeight*3, LeftBtnCellWidth+1, CellHeight+1);
        unloadStartBtnView.layer.borderColor = [BorderColor CGColor];
        unloadStartBtnView.layer.borderWidth = 1;
        
        [processContent addSubview:unloadStartBtnView];
        
        unloadStart = [BusinessProcessButton buttonWithTitle:@"卸货开始"];
        unloadStart.frame = CGRectMake(2, 2, unloadStartBtnView.frame.size.width - 4, unloadStartBtnView.frame.size.height - 4);
        [unloadStartBtnView addSubview:unloadStart];
        [unloadStart addTarget:self action:@selector(unloadStarting) forControlEvents:UIControlEventTouchUpInside];
        unloadStart.enabled = NO;
        
        [unloadStartBtnView release];
        
        UIView *unloadStartConfirmView = [[UIView alloc] initWithFrame:CGRectZero];
        unloadStartConfirmView.frame = CGRectMake(TitleCellWidth + LargeCellWidth + LeftBtnCellWidth, CellHeight * 3, RightBtnCellWidth+1, CellHeight+1);
        unloadStartConfirmView.layer.borderColor = [BorderColor CGColor];
        unloadStartConfirmView.layer.borderWidth = 1;
        
        unloadStartCheck = [BusinessCheckBox button];
        unloadStartCheck.frame = CGRectMake(0, 0, 130, 40);
        [unloadStartConfirmView addSubview:unloadStartCheck];
        [unloadStartCheck addTarget:self action:@selector(unloadStartingConfirm:) forControlEvents:UIControlEventTouchUpInside];
        
        [processContent addSubview:unloadStartConfirmView];
        
        [unloadStartConfirmView release];
        
        [self createLabel:@"卸货结束时间" withFrame:CGRectMake(0,CellHeight * 4,TitleCellWidth,CellHeight)
             andSuperView:processContent];
        
        unloadEndTimeLab = [TimeButton buttonWithType:UIButtonTypeCustom];
        unloadEndTimeLab.frame = CGRectMake(TitleCellWidth, CellHeight * 4, LargeCellWidth+1, CellHeight+1);
        [processContent addSubview:unloadEndTimeLab];
        
        UIView *unloadEndBtnView = [[UIView alloc] initWithFrame:CGRectZero];
        unloadEndBtnView.frame = CGRectMake(TitleCellWidth + LargeCellWidth, CellHeight*4, LeftBtnCellWidth+1, CellHeight+1);
        unloadEndBtnView.layer.borderColor = [BorderColor CGColor];
        unloadEndBtnView.layer.borderWidth = 1;
        
        [processContent addSubview:unloadEndBtnView];
        
        unloadEnd = [BusinessProcessButton buttonWithTitle:@"卸货结束"];
        unloadEnd.frame = CGRectMake(2, 2, unloadEndBtnView.frame.size.width - 4, unloadEndBtnView.frame.size.height - 4);
        [unloadEndBtnView addSubview:unloadEnd];
        [unloadEnd addTarget:self action:@selector(unloadEnding) forControlEvents:UIControlEventTouchUpInside];
        unloadEnd.enabled = NO;
        
        [unloadEndBtnView release];
        
        UIView *unloadEndConfirmView = [[UIView alloc] initWithFrame:CGRectZero];
        unloadEndConfirmView.frame = CGRectMake(TitleCellWidth + LargeCellWidth + LeftBtnCellWidth, CellHeight*4, RightBtnCellWidth+1, CellHeight+1);
        unloadEndConfirmView.layer.borderColor = [BorderColor CGColor];
        unloadEndConfirmView.layer.borderWidth = 1;
        
        unloadEndCheck = [BusinessCheckBox button];
        unloadEndCheck.frame = CGRectMake(0, 0, 130, 40);
        [unloadEndConfirmView addSubview:unloadEndCheck];
        [unloadEndCheck addTarget:self action:@selector(unloadEndingConfirm:) forControlEvents:UIControlEventTouchUpInside];
        
        [processContent addSubview:unloadEndConfirmView];
        
        [unloadEndConfirmView release];
        
        [self createLabel:@"装货开始时间" withFrame:CGRectMake(0,CellHeight * 5,TitleCellWidth,CellHeight)
             andSuperView:processContent];
        
        loadingStartTimeLab = [TimeButton buttonWithType:UIButtonTypeCustom];
        loadingStartTimeLab.frame = CGRectMake(TitleCellWidth, CellHeight * 5, LargeCellWidth+1, CellHeight+1);
        [processContent addSubview:loadingStartTimeLab];
        
        UIView *loadingStartBtnView = [[UIView alloc] initWithFrame:CGRectZero];
        loadingStartBtnView.frame = CGRectMake(TitleCellWidth + LargeCellWidth, CellHeight*5, LeftBtnCellWidth+1, CellHeight+1);
        loadingStartBtnView.layer.borderColor = [BorderColor CGColor];
        loadingStartBtnView.layer.borderWidth = 1;
        
        [processContent addSubview:loadingStartBtnView];
        
        loadingStart = [BusinessProcessButton buttonWithTitle:@"装货开始"];
        loadingStart.frame = CGRectMake(2, 2, loadingStartBtnView.frame.size.width - 4, loadingStartBtnView.frame.size.height - 4);
        [loadingStartBtnView addSubview:loadingStart];
        [loadingStart addTarget:self action:@selector(loadingStarting) forControlEvents:UIControlEventTouchUpInside];
        loadingStart.enabled = NO;
        
        [loadingStartBtnView release];
        
        UIView *loadingStartConfirmView = [[UIView alloc] initWithFrame:CGRectZero];
        loadingStartConfirmView.frame = CGRectMake(TitleCellWidth + LargeCellWidth + LeftBtnCellWidth, CellHeight*5, RightBtnCellWidth+1, CellHeight+1);
        loadingStartConfirmView.layer.borderColor = [BorderColor CGColor];
        loadingStartConfirmView.layer.borderWidth = 1;
        
        loadingStartCheck = [BusinessCheckBox button];
        loadingStartCheck.frame = CGRectMake(0, 0, 130, 40);
        [loadingStartConfirmView addSubview:loadingStartCheck];
        [loadingStartCheck addTarget:self action:@selector(loadingStartingConfirm:) forControlEvents:UIControlEventTouchUpInside];
        
        [processContent addSubview:loadingStartConfirmView];
        
        [loadingStartConfirmView release];
        
        [self createLabel:@"装货结束时间" withFrame:CGRectMake(0,CellHeight * 6,TitleCellWidth,CellHeight)
             andSuperView:processContent];
      
        loadingEndTimeLab = [TimeButton buttonWithType:UIButtonTypeCustom];
        loadingEndTimeLab.frame = CGRectMake(TitleCellWidth, CellHeight * 6, LargeCellWidth+1, CellHeight+1);
        [processContent addSubview:loadingEndTimeLab];
        
        UIView *loadingEndBtnView = [[UIView alloc] initWithFrame:CGRectZero];
        loadingEndBtnView.frame = CGRectMake(TitleCellWidth + LargeCellWidth, CellHeight*6, LeftBtnCellWidth+1, CellHeight+1);
        loadingEndBtnView.layer.borderColor = [BorderColor CGColor];
        loadingEndBtnView.layer.borderWidth = 1;
        
        [processContent addSubview:loadingEndBtnView];
        
        loadingEnd = [BusinessProcessButton buttonWithTitle:@"装货结束"];
        loadingEnd.frame = CGRectMake(2, 2, loadingEndBtnView.frame.size.width - 4, loadingEndBtnView.frame.size.height - 4);
        [loadingEndBtnView addSubview:loadingEnd];
        [loadingEnd addTarget:self action:@selector(loadingEnding) forControlEvents:UIControlEventTouchUpInside];
        loadingEnd.enabled = NO;
        
        [loadingEndBtnView release];
        
        UIView *loadingEndConfirmView = [[UIView alloc] initWithFrame:CGRectZero];
        loadingEndConfirmView.frame = CGRectMake(TitleCellWidth + LargeCellWidth + LeftBtnCellWidth, CellHeight*6, RightBtnCellWidth+1, CellHeight+1);
        loadingEndConfirmView.layer.borderColor = [BorderColor CGColor];
        loadingEndConfirmView.layer.borderWidth = 1;
        
        loadingEndCheck = [BusinessCheckBox button];
        loadingEndCheck.frame = CGRectMake(0, 0, 130, 40);
        [loadingEndConfirmView addSubview:loadingEndCheck];
        [loadingEndCheck addTarget:self action:@selector(loadingEndingConfirm:) forControlEvents:UIControlEventTouchUpInside];
        
        [processContent addSubview:loadingEndConfirmView];
        
        [loadingEndConfirmView release];
        
        [processContent release];
        
        UIView *btnTable = [[UIView alloc] initWithFrame:CGRectMake(SideBorderWidth, ProcessTableHeight + TopBorderWidth, TableWidth, ButtonTableHeight)];
        btnTable.layer.borderColor = [BorderColor CGColor];
        btnTable.layer.borderWidth = 1;
        btnTable.backgroundColor = TitleCellBgColor;
        
        BusinessProcessButton *errorHandlingBtn = [BusinessProcessButton buttonWithTitle:@"错误处理"];
        errorHandlingBtn.frame = CGRectMake(137, 20, 122, 30);
        [btnTable addSubview:errorHandlingBtn];
        [errorHandlingBtn addTarget:self action:@selector(errorHandling) forControlEvents:UIControlEventTouchUpInside];
        
        BusinessProcessButton *removeJobPrecessBtn = [BusinessProcessButton buttonWithTitle:@"不是装卸作业船舶"];
        removeJobPrecessBtn.frame = CGRectMake(289, 20, 122, 30);
        [btnTable addSubview:removeJobPrecessBtn];
        [removeJobPrecessBtn addTarget:self action:@selector(removeJobPrecess) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:btnTable];
        [btnTable release];
        
    }
    return self;
}

- (void) createLabel:(NSString *)title withFrame : (CGRect) frame andSuperView: (UIView *)view
{
    frame.size.width += 1;
    frame.size.height += 1;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:frame];
    
    titleLab.backgroundColor = TitleCellBgColor;
    titleLab.layer.borderColor = [BorderColor CGColor];
    titleLab.layer.borderWidth = 1;
    titleLab.font = DetailCellTextFont;
    titleLab.textColor = TitleTextColor;
    titleLab.text = title;
    titleLab.textAlignment = UITextAlignmentCenter;
    titleLab.numberOfLines = 0;

    [view addSubview:titleLab];
    
    [titleLab release];
}

- (void) addCheckBoxView : (CGRect) frame andSuperView: (UIView *)view
{
    UIView *checkBoxView = [[UIView alloc] initWithFrame:frame];
    checkBoxView.layer.borderColor = [BorderColor CGColor];
    checkBoxView.layer.borderWidth = 1;
    
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(30, 8, 24, 24)];

    circle.layer.borderColor = [BorderColor CGColor];
    circle.layer.borderWidth = 1;
    
    [checkBoxView addSubview:circle];
}

- (void) saveMarginValue
{
    NSLog(@"saveMarginValue");

    NSString *margin = unloadMarginLab.text;
    
    if (!margin || margin.length == 0) {
        [self showErrorAlert:@"请输入卸货余吨"];
    }
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(saveMarginValue:)]) {
        [m_delegate saveMarginValue:margin];
    }
}

- (void) confirmAssessmentValue
{
    NSLog(@"%@",curBerthLab.text);
    if(!curBerthLab.text)
    {
        AlertView *alert=[[AlertView alloc] initWithTitle:@"提示" andMessage:@"当前泊位为空,不可进行确认信息考核！"];
        
        [alert addToView:self];
        
        [alert release];
        return;
    }
    
    
    NSString *unloadCount = todayUnloadCountLab.text;
    NSString *todayStopTime = todayStopTimeLab.text;
    
    if (!unloadCount || unloadCount.length == 0) {
        [self showErrorAlert:@"请输入今日卸船数"];
    }
    
    if (!todayStopTime || todayStopTime.length == 0) {
        [self showErrorAlert:@"请输入今日停时"];
    }
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(confirmAssessment:andStopTime:)]) {
        [m_delegate confirmAssessment:unloadCount andStopTime:todayStopTime];
    }
}

- (void) unloadStartingConfirm:(id)sender
{
    NSLog(@"unloadStartingConfirm");
    
    NSString *unloadStartTimeStr = unloadStartTimeLab.time;
    
    if (!unloadStartTimeStr || unloadStartTimeStr.length == 0) {
        [self showErrorAlert:@"请设定卸货开始时间"];
        ((BusinessCheckBox *)sender).checked = NO;
        return;
    }
    
    unloadStart.enabled = ((BusinessCheckBox *)sender).checked;
}

- (void) unloadStarting
{
    NSString *unloadStartTimeStr = unloadStartTimeLab.time;
    
    NSLog(@"unloadStarting:%@",unloadStartTimeStr);
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(saveUnloadStartTime:)]) {
        [m_delegate saveUnloadStartTime:unloadStartTimeStr];
    }
}

- (void) unloadEndingConfirm:(id)sender
{
    NSLog(@"unloadEndingConfirm");
    
    NSString *unloadStartTimeStr = unloadStartTimeLab.time;
    
    if (!unloadStartTimeStr || unloadStartTimeStr.length == 0) {
        [self showErrorAlert:@"请设定卸货开始时间"];
        ((BusinessCheckBox *)sender).checked = NO;
        return;
    }
    
    NSString *unloadEndTimeStr = unloadEndTimeLab.time;
    
    if (!unloadEndTimeStr || unloadEndTimeStr.length == 0) {
        [self showErrorAlert:@"请设定卸货结束时间"];
        ((BusinessCheckBox *)sender).checked = NO;
        return;
    }
    
    unloadEnd.enabled = ((BusinessCheckBox *)sender).checked;
}

- (void) unloadEnding
{
    NSString *unloadStartTimeStr = unloadStartTimeLab.time;
    
    NSString *unloadEndTimeStr = unloadEndTimeLab.time;
    
    NSLog(@"unloadStarting:%@\n unloadEnding:%@",unloadStartTimeStr,unloadEndTimeStr);
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(saveUnloadStartTime:withUnloadEndTime:)]) {
        [m_delegate saveUnloadStartTime:unloadStartTimeStr withUnloadEndTime:unloadEndTimeStr];
    }
}

- (void) loadingStartingConfirm:(id)sender
{
    NSLog(@"loadingStartingConfirm");
    
    NSString *loadingStartTimeStr = loadingStartTimeLab.time;
    
    if (!loadingStartTimeStr || loadingStartTimeStr.length == 0) {
        [self showErrorAlert:@"请设定装货开始时间"];
        ((BusinessCheckBox *)sender).checked = NO;
        return;
    }
    
    loadingStart.enabled = ((BusinessCheckBox *)sender).checked;
}

- (void) loadingStarting
{
    NSString *loadingStartTimeStr = loadingStartTimeLab.time;
    
    NSLog(@"loadingStarting:%@",loadingStartTimeStr);
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(saveloadStartTime:)]) {
        [m_delegate saveloadStartTime:loadingStartTimeStr];
    }
}

- (void) loadingEndingConfirm:(id)sender
{
    NSLog(@"loadingEndingConfirm");
    
    NSString *loadingStartTimeStr = loadingStartTimeLab.time;
    
    if (!loadingStartTimeStr || loadingStartTimeStr.length == 0) {
        [self showErrorAlert:@"请设定装货开始时间"];
        ((BusinessCheckBox *)sender).checked = NO;
        return;
    }
    
    NSString *loadingEndTimeStr = loadingEndTimeLab.time;
    
    if (!loadingEndTimeStr || loadingEndTimeStr.length == 0) {
        [self showErrorAlert:@"请设定装货结束时间"];
        ((BusinessCheckBox *)sender).checked = NO;
        return;
    }
    
    loadingEnd.enabled = ((BusinessCheckBox *)sender).checked;
}

- (void) loadingEnding
{
    NSString *loadingStartTimeStr = loadingStartTimeLab.time;
    
    NSString *loadingEndTimeStr = loadingEndTimeLab.time;
    
    NSLog(@"loadingStarting:%@\n loadingEnding:%@",loadingStartTimeStr, loadingEndTimeStr);
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(saveloadStartTime:withLoadEndTime:)]) {
        [m_delegate saveloadStartTime:loadingStartTimeStr withLoadEndTime:loadingEndTimeStr];
    }
}

- (void) errorHandling
{
    NSLog(@"errorHandling");
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(saveErrorHandling)]) {
        [m_delegate saveErrorHandling];
    }
}

- (void) removeJobPrecess
{
    NSLog(@"removeJobPrecess");
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(saveNonLoadUnloadShip)]) {
        [m_delegate saveNonLoadUnloadShip];
    }
}

- (void) showErrorAlert : (NSString *) title
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(showErrorAlert:)]) {
        [m_delegate showErrorAlert:title];
    }
}

- (NSString *) getCurTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *curTime = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    return curTime;
}

- (void)setCurBerth:(NSString *)curBerth
{
    curBerthLab.text = curBerth;
}

-(NSString *)curBerth
{
    return curBerthLab.text;
}

- (void)setUnloadMargin:(NSString *)unloadMargin
{
    if (unloadMargin && unloadMargin.length > 0) {
        unloadMarginLab.text = unloadMargin;
        return;
    }
    
    unloadMarginLab.text = @"0";
}

-(NSString *)unloadMargin
{
    return unloadMarginLab.text;
}

- (void)setUnloadCount:(NSString *)unloadCount
{
    if (unloadCount && unloadCount.length > 0) {
        unloadCountLab.text = unloadCount;
        return;
    }
    
    unloadCountLab.text = @"0";
}

-(NSString *)unloadCount
{
    return unloadCountLab.text;
}

- (void)setTotalStopTime:(NSString *)totalStopTime
{
    if (totalStopTime && totalStopTime.length > 0) {
        totalStopTimeLab.text = totalStopTime;
        return;
    }
    
    totalStopTimeLab.text = @"0";
}

-(NSString *)totalStopTime
{
    return totalStopTimeLab.text;
}

- (void)setTodayUnloadCount:(NSString *)todayUnloadCount
{
    todayUnloadCountLab.text = todayUnloadCount;
}

-(NSString *)todayUnloadCount
{
    return todayUnloadCountLab.text;
}

-(void)setTodayStopTime:(NSString *)todayStopTime
{
    todayStopTimeLab.text = todayStopTime;
}

- (NSString *)todayStopTime
{
    return todayStopTimeLab.text;
}

- (void)setUnloadStartTime:(NSString *)unloadStartTime
{
    unloadStartTimeLab.time = unloadStartTime;
}

- (NSString *)unloadStartTime
{
    return unloadStartTimeLab.time;
}

- (void)setUnloadEndTime:(NSString *)unloadEndTime
{
    unloadEndTimeLab.time = unloadEndTime;
}

- (NSString *)unloadEndTime
{
    return unloadEndTimeLab.time;
}

- (void)setLoadingStartTime:(NSString *)loadingStartTime
{
    loadingStartTimeLab.time = loadingStartTime;
}

- (NSString *)loadingStartTime
{
    return loadingStartTimeLab.time;
}

- (void)setLoadingEndTime:(NSString *)loadingEndTime
{
    loadingEndTimeLab.time = loadingEndTime;
}

- (NSString *)loadingEndTime
{
    return loadingEndTimeLab.time;
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
