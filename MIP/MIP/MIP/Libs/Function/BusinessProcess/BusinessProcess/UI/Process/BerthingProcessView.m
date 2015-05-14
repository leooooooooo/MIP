//
//  BerthingProcessView.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/04.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BerthingProcessView.h"
#import "InsetTextField.h"
#import "BusinessProcessButton.h"
#import "CustomListBox.h"
#import "TimeButton.h"

#define FrameWidth              [[UIScreen mainScreen] bounds].size.height
#define FrameHeight             320-20-44

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

@interface BerthingProcessView() <ListBoxSelectedDelegate>
{
    UILabel *m_planEnterPort;
    UILabel *m_planLeavePort;
    
    CustomListBox *m_berthName;
    CustomListBox *m_berthPos;
    CustomListBox *m_berthCom;
    
    NSArray *m_berthComList;
    NSArray *m_berthComValueList;
    
    id<BerthingProcessDelegate> m_delegate;
    
    InsetTextField *incompleteReason;
    TimeButton *berthTime;
}
@end


@implementation BerthingProcessView

@dynamic planEnterPortTime, planLeavePortTime;
@dynamic berthNameList,berthPosList;
@dynamic berthNameValueList,berthPosValueList;

@synthesize berthComList = m_berthComList;
@synthesize berthComValueList = m_berthComValueList;

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
        
        UILabel *incompleteReasonTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 105, 30)];
        incompleteReasonTitle.backgroundColor = [UIColor clearColor];
        incompleteReasonTitle.textColor = DetailContentTextColor;
        incompleteReasonTitle.textAlignment = NSTextAlignmentRight;
        incompleteReasonTitle.font = ContentFont;
        incompleteReasonTitle.text = @"计划未兑现原因：";
        
        [processContent addSubview:incompleteReasonTitle];
        [incompleteReasonTitle release];
        
        incompleteReason = [[InsetTextField alloc] initWithFrame:CGRectMake(108, 5, 310, 30)];
        //incompleteReason.frame = CGRectMake(108, 5, 310, 30);
        incompleteReason.background = [TextFieldBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
        incompleteReason.inset = CGPointMake(10, 0);
        incompleteReason.font = InputFont;
        incompleteReason.delegate=self;
        [processContent addSubview:incompleteReason];
        
        UILabel *portDetailTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 105, 30)];
        portDetailTitle.backgroundColor = [UIColor clearColor];
        portDetailTitle.textColor = DetailContentTextColor;
        portDetailTitle.textAlignment = NSTextAlignmentRight;
        portDetailTitle.font = ContentFont;
        portDetailTitle.text = @"停靠泊位：";
        
        [processContent addSubview:portDetailTitle];
        [portDetailTitle release];
        
        m_berthName = [CustomListBox buttonWithType:UIButtonTypeCustom];
        m_berthName.frame = CGRectMake(108, 40, 52, 30);
        m_berthName.delegate = self;
        m_berthName.titleLabel.font = InputFont;
        m_berthName.maxRowCount = 3;
        [processContent addSubview:m_berthName];
        
        m_berthPos = [CustomListBox buttonWithType:UIButtonTypeCustom];
        m_berthPos.frame = CGRectMake(165, 40, 42, 30);
        m_berthPos.titleLabel.font = InputFont;
        m_berthPos.maxRowCount = 3;
        [processContent addSubview:m_berthPos];
        
        UILabel *berthPosTitle = [[UILabel alloc] initWithFrame:CGRectMake(202, 40, 123, 30)];
        berthPosTitle.backgroundColor = [UIColor clearColor];
        berthPosTitle.textColor = DetailContentTextColor;
        berthPosTitle.textAlignment = NSTextAlignmentLeft;
        berthPosTitle.font = ContentFont;
        berthPosTitle.text = @"（00表示锚地）公司";
        [processContent addSubview:berthPosTitle];
        [berthPosTitle release];
        
        m_berthCom = [CustomListBox buttonWithType:UIButtonTypeCustom];
        m_berthCom.frame = CGRectMake(325, 40, 65, 30);
        m_berthCom.titleLabel.font = InputFont;
        m_berthCom.maxRowCount = 3;
        [processContent addSubview:m_berthCom];
        
        UILabel *berthComTitle = [[UILabel alloc] initWithFrame:CGRectMake(395, 40, DetailContentWidth-395, 40)];
        berthComTitle.backgroundColor = [UIColor clearColor];
        berthComTitle.textColor = DetailContentTextColor;
        berthComTitle.textAlignment = NSTextAlignmentLeft;
        berthComTitle.font = [UIFont boldSystemFontOfSize:10];
        berthComTitle.numberOfLines=0;
        berthComTitle.text = @"如无泊位租用，无需修改";

        [processContent addSubview:berthComTitle];
        [berthComTitle release];
        
        UILabel *berthTimeTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 75, 105, 30)];
        berthTimeTitle.backgroundColor = [UIColor clearColor];
        berthTimeTitle.textColor = DetailContentTextColor;
        berthTimeTitle.textAlignment = NSTextAlignmentRight;
        berthTimeTitle.font = ContentFont;
        berthTimeTitle.text = @"靠泊时间：";
        
        [processContent addSubview:berthTimeTitle];
        [berthTimeTitle release];
        
        berthTime = [TimeButton buttonWithType:UIButtonTypeCustom];
        berthTime.frame = CGRectMake(108, 75, 217, 30);
        [processContent addSubview:berthTime];
        
        [processTable addSubview:processContent];
        
        BusinessProcessButton *berthBtn = [BusinessProcessButton buttonWithTitle:@"船舶靠泊"];
        [berthBtn setFrame:CGRectMake(330, 75, 80, 30)];
        [berthBtn addTarget:self action:@selector(berthingClick)
                  forControlEvents:UIControlEventTouchUpInside];
        [processContent addSubview:berthBtn];
        
        [processContent release];
        
        [processTable release];
        
        
    }
    return self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)dealloc
{
    [m_planEnterPort release];
    [m_planLeavePort release];
    
    [m_berthName release];
    [m_berthPos release];
    [m_berthCom release];
    
    [incompleteReason release];
    
    [super dealloc];
}

- (void) planCompleteClick
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(planCompleteClick)]) {
        [m_delegate planCompleteClick];
    }
}

- (void) berthingClick
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(berthingClick:withBerthId:andBerthPos:andCompId:andRemark:)]) {
        [m_delegate berthingClick:berthTime.time withBerthId:m_berthName.selectedItem andBerthPos:m_berthPos.selectedValue andCompId:m_berthCom.selectedValue andRemark:incompleteReason.text];
    }
}

- (NSString *)planEnterPortTime
{
    return m_planEnterPort.text;
}

-(void)setPlanEnterPortTime:(NSString *)planEnterPortTime
{
    if (planEnterPortTime) {
        m_planEnterPort.text = [NSString stringWithFormat:@"%@%@",@"计划进港时间：", planEnterPortTime];
    }
}

- (NSString *)planLeavePortTime
{
    return m_planLeavePort.text;
}

-(void)setPlanLeavePortTime:(NSString *)planLeavePortTime
{
    if (planLeavePortTime) {
        m_planLeavePort.text = [NSString stringWithFormat:@"%@%@",@"计划离港时间：", planLeavePortTime];
    }
}

-(void)setBerthNameList:(NSArray *)berthNameList
{
    [m_berthName bindingDataSource:berthNameList];
}

-(void)setBerthPosList:(NSArray *)berthPosList
{
    [m_berthPos bindingDataSource:berthPosList];
}

-(void)setBerthNameValueList:(NSArray *)berthNameValueList
{
    [m_berthName bindingDataValue:berthNameValueList];
}

-(void)setBerthPosValueList:(NSArray *)berthPosValueList
{
    [m_berthPos bindingDataValue:berthPosValueList];
}

- (void)selectedItemWithIndex:(NSInteger)index andTag:(NSInteger)tag
{
    if ([m_berthComList count] > index) {
        NSString *depart = [m_berthComList objectAtIndex:index];
        NSArray *tmpBerth = [[NSArray alloc] initWithObjects:depart,nil];
        NSString *deptCode = [m_berthComValueList objectAtIndex:index];
        NSArray *tmpBerthValue = [[NSArray alloc] initWithObjects:deptCode,nil];
        [m_berthCom bindingDataSource:tmpBerth];
        [m_berthCom bindingDataValue:tmpBerthValue];
        
        [tmpBerth release];
        [tmpBerthValue release];
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
