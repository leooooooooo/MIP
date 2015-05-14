//
//  OutwardProcessView.m
//  BusinessProcess
//
//  Created by mengxianglei on 14-5-22.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "OutwardProcessView.h"
#import "BusinessProcessButton.h"
#import "TimeButton.h"

#define FrameWidth              SCREEN_HEIGHT
#define FrameHeight             SCREEN_WIDTH - 20 - 44

#define TopBorderWidth          10
#define SideBorderWidth         10
#define SeparatorBorderWidth    5

#define TableWidth              FrameWidth - SideBorderWidth * 2

#define PlanTableHeight         70
#define ProcessTableHeight      110

#define LeftTitleWidth          40
#define DetailContentWidth      TableWidth - LeftTitleWidth

#define BorderColor             [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1.0]

#define LeftTitleTextColor      [UIColor whiteColor]
#define LeftTitleBgColor        [UIColor colorWithRed:136/255.0 green:164/255.0 blue:196/255.0 alpha:1.0]

#define DetailContentTextColor  [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0]
#define DetailContentBgColor    [UIColor colorWithRed:234/255.0 green:241/255.0 blue:247/255.0 alpha:1.0]

#define TextFieldBgImage        [UIImage imageNamed:@"bg_input_style3.png" imageBundle:publicResourceBundle]

#define TitleFont               [UIFont boldSystemFontOfSize:16.0]
#define ContentFont             [UIFont boldSystemFontOfSize:13.0]
#define InputFont               [UIFont boldSystemFontOfSize:13.0]

@interface OutwardProcessView()
{
    UILabel *m_planEnterPort;
    UILabel *m_planLeavePort;
    
    TimeButton *m_leadTime;
    TimeButton *m_leaveTime;
    
    InsetTextField *incompleteReason;
}
@end


@implementation OutwardProcessView

@dynamic planEnterPortTime, planLeavePortTime;

@synthesize delegate = m_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *planTable = [[UIView alloc] initWithFrame:CGRectZero];
        planTable.frame = CGRectMake(SideBorderWidth, TopBorderWidth, TableWidth, PlanTableHeight);
        planTable.backgroundColor = [UIColor clearColor];
        
        [self addSubview:planTable];
        
        UILabel *planTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LeftTitleWidth, PlanTableHeight)];
        planTitle.backgroundColor = LeftTitleBgColor;
        planTitle.textColor = LeftTitleTextColor;
        planTitle.textAlignment = NSTextAlignmentCenter;
        planTitle.font = TitleFont;
        planTitle.numberOfLines = 3;
        planTitle.text = @"计\n\n划";
        planTitle.layer.borderColor = [BorderColor CGColor];
        planTitle.layer.borderWidth = 1;
        
        [planTable addSubview:planTitle];
        
        [planTitle release];
        
        UIView *planContent = [[UIView alloc] initWithFrame:CGRectMake(LeftTitleWidth - 1, 0, DetailContentWidth + 1, PlanTableHeight)];
        planContent.backgroundColor = DetailContentBgColor;
        planContent.layer.borderColor = [BorderColor CGColor];
        planContent.layer.borderWidth = 1;
        
        m_planEnterPort = [[UILabel alloc] initWithFrame:CGRectMake(7, 0,DetailContentWidth-130, 35)];
        m_planEnterPort.backgroundColor = [UIColor clearColor];
        m_planEnterPort.textColor = DetailContentTextColor;
        m_planEnterPort.textAlignment = NSTextAlignmentLeft;
        m_planEnterPort.font = ContentFont;
        m_planEnterPort.text = @"计划进港时间：";
        
        [planContent addSubview:m_planEnterPort];
        
        m_planLeavePort = [[UILabel alloc] initWithFrame:CGRectMake(7, 35, DetailContentWidth-130, 35)];
        m_planLeavePort.backgroundColor = [UIColor clearColor];
        m_planLeavePort.textColor = DetailContentTextColor;
        m_planLeavePort.textAlignment = NSTextAlignmentLeft;
        m_planLeavePort.font = ContentFont;
        m_planLeavePort.text = @"计划离港时间：";
        
        [planContent addSubview:m_planLeavePort];
        
        [planTable addSubview:planContent];
        
        [planContent release];
        
        BusinessProcessButton *planCompleteBtn = [BusinessProcessButton buttonWithTitle:@"计划执行完毕"];
        [planCompleteBtn setFrame:CGRectMake(385, 20, 113, 30)];
        [planCompleteBtn.titleLabel setFont:ContentFont];
        [planCompleteBtn addTarget:self action:@selector(planCompleteClick)
                  forControlEvents:UIControlEventTouchUpInside];
        [planContent addSubview:planCompleteBtn];
        
        [planTable release];
        
        UIView *processTable = [[UIView alloc] initWithFrame:CGRectZero];
        processTable.frame = CGRectMake(SideBorderWidth, TopBorderWidth + PlanTableHeight + SeparatorBorderWidth, TableWidth, ProcessTableHeight);
        processTable.backgroundColor = [UIColor clearColor];
        
        [self addSubview:processTable];
        
        UILabel *processTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LeftTitleWidth, ProcessTableHeight)];
        processTitle.backgroundColor = LeftTitleBgColor;
        processTitle.textColor = LeftTitleTextColor;
        processTitle.textAlignment = NSTextAlignmentCenter;
        processTitle.font = TitleFont;
        processTitle.numberOfLines = 3;
        processTitle.text = @"处\n\n理";
        processTitle.layer.borderColor = [BorderColor CGColor];
        processTitle.layer.borderWidth = 1;
        
        [processTable addSubview:processTitle];
        
        [processTitle release];
        
        UIView *processContent = [[UIView alloc] initWithFrame:CGRectMake(LeftTitleWidth - 1, 0, DetailContentWidth + 1, ProcessTableHeight)];
        processContent.backgroundColor = DetailContentBgColor;
        processContent.layer.borderColor = [BorderColor CGColor];
        processContent.layer.borderWidth = 1;
        
        UILabel *leadTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 105, 30)];
        leadTimeLabel.backgroundColor = [UIColor clearColor];
        leadTimeLabel.textColor = DetailContentTextColor;
        leadTimeLabel.textAlignment = NSTextAlignmentRight;
        leadTimeLabel.font = ContentFont;
        leadTimeLabel.text = @"通知引水时间：";
        
        [processContent addSubview:leadTimeLabel];
        [leadTimeLabel release];
        
        m_leadTime = [TimeButton buttonWithType:UIButtonTypeCustom];
        m_leadTime.frame = CGRectMake(108, 5, 217, 30);
        [processContent addSubview:m_leadTime];
        
        UILabel *incompleteReasonTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 105, 30)];
        incompleteReasonTitle.backgroundColor = [UIColor clearColor];
        incompleteReasonTitle.textColor = DetailContentTextColor;
        incompleteReasonTitle.textAlignment = NSTextAlignmentRight;
        incompleteReasonTitle.font = ContentFont;
        incompleteReasonTitle.text = @"计划未兑现原因：";
        
        [processContent addSubview:incompleteReasonTitle];
        [incompleteReasonTitle release];
        
        incompleteReason = [[InsetTextField alloc] initWithFrame:CGRectMake(108, 40, 310, 30)];
       // incompleteReason.frame = CGRectMake(108, 40, 310, 30);
        incompleteReason.background = [TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
        incompleteReason.inset = CGPointMake(10, 0);
        incompleteReason.font = InputFont;
        incompleteReason.delegate=self;
        [processContent addSubview:incompleteReason];
        
        UILabel *berthTimeTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 75, 105, 30)];
        berthTimeTitle.backgroundColor = [UIColor clearColor];
        berthTimeTitle.textColor = DetailContentTextColor;
        berthTimeTitle.textAlignment = NSTextAlignmentRight;
        berthTimeTitle.font = ContentFont;
        berthTimeTitle.text = @"离港时间：";
        
        [processContent addSubview:berthTimeTitle];
        [berthTimeTitle release];
        
        m_leaveTime = [TimeButton buttonWithType:UIButtonTypeCustom];
        m_leaveTime.frame = CGRectMake(108, 75, 217, 30);
        [processContent addSubview:m_leaveTime];
        
        [processTable addSubview:processContent];
        
        BusinessProcessButton *shipLeaveBtn = [BusinessProcessButton buttonWithTitle:@"船舶离港"];
        [shipLeaveBtn setFrame:CGRectMake(330, 75, 80, 30)];
        [shipLeaveBtn addTarget:self action:@selector(shipLeaveClick)
           forControlEvents:UIControlEventTouchUpInside];
        [processContent addSubview:shipLeaveBtn];
        
        [processContent release];
        
        [processTable release];
        
        
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [incompleteReason resignFirstResponder];
    return YES;
}
- (void)dealloc
{
    [m_planEnterPort release];
    [m_planLeavePort release];
    
    [incompleteReason release];
    [m_leadTime release];
    [m_leaveTime release];
    
    [super dealloc];
}

- (void) planCompleteClick
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(planCompleteClickAction)]) {
        [m_delegate planCompleteClickAction];
    }
}

- (void) shipLeaveClick
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(shipLeaveClickAction:andLeadTime:andLeaveTime:)]) {
        [m_delegate shipLeaveClickAction:incompleteReason.text andLeadTime:m_leadTime.time andLeaveTime:m_leaveTime.time];
    }
}

- (NSString *)planEnterPortTime
{
    return m_planEnterPort.text;
}

-(void)setPlanEnterPortTime:(NSString *)planEnterPortTime
{
    if (planEnterPortTime) {
        m_planEnterPort.text = [NSString stringWithFormat:@"%@%@",@"计划进港时间： ", planEnterPortTime];
    }
}

- (NSString *)planLeavePortTime
{
    return m_planLeavePort.text;
}

-(void)setPlanLeavePortTime:(NSString *)planLeavePortTime
{
    if (planLeavePortTime) {
        m_planLeavePort.text = [NSString stringWithFormat:@"%@%@",@"计划离港时间： ", planLeavePortTime];
    }
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
