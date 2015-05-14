//
//  UnberthingProcessView.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/05/23.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "UnberthingProcessView.h"
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
#define ProcessTableHeight      145

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

@interface UnberthingProcessView() <ListBoxSelectedDelegate>
{
    UILabel *m_planMoveBerthTimeLab;
    UILabel *m_planMoveBerthNoLab;
    
    UILabel *curBerthLab;
    
    TimeButton *leaveBerthTime;
    TimeButton *berthTime;
    
    CustomListBox *m_berthName;
    CustomListBox *m_berthPos;
    CustomListBox *m_berthCom;
    
    NSArray *m_berthComList;
    NSArray *m_berthComValueList;
    
    id<UnberthingProcessDelegate> m_delegate;
}
@end


@implementation UnberthingProcessView

@dynamic planMoveBerthTime, planMoveBerthNo;
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
        
        m_planMoveBerthTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(7, 0,DetailContentWidth-130, 35)];
        m_planMoveBerthTimeLab.backgroundColor = [UIColor clearColor];
        m_planMoveBerthTimeLab.textColor = DetailContentTextColor;
        m_planMoveBerthTimeLab.textAlignment = NSTextAlignmentLeft;
        m_planMoveBerthTimeLab.font = ContentFont;
        m_planMoveBerthTimeLab.text = @"计划移泊时间：";
        
        [planContent addSubview:m_planMoveBerthTimeLab];
        
        m_planMoveBerthNoLab = [[UILabel alloc] initWithFrame:CGRectMake(7, 35, DetailContentWidth-130, 35)];
        m_planMoveBerthNoLab.backgroundColor = [UIColor clearColor];
        m_planMoveBerthNoLab.textColor = DetailContentTextColor;
        m_planMoveBerthNoLab.textAlignment = NSTextAlignmentLeft;
        m_planMoveBerthNoLab.font = ContentFont;
        m_planMoveBerthNoLab.text = @"计划移泊泊位：";
        
        [planContent addSubview:m_planMoveBerthNoLab];
        
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
        
        UILabel *curBerthTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 105, 30)];
        curBerthTitle.backgroundColor = [UIColor clearColor];
        curBerthTitle.textColor = DetailContentTextColor;
        curBerthTitle.textAlignment = NSTextAlignmentRight;
        curBerthTitle.font = ContentFont;
        curBerthTitle.text = @"当前停靠泊位：";
        
        [processContent addSubview:curBerthTitle];
        [curBerthTitle release];
        
        curBerthLab = [[UILabel alloc] initWithFrame:CGRectMake(108, 5, 280, 30)];
        curBerthLab.backgroundColor = [UIColor clearColor];
        curBerthLab.textColor = DetailContentTextColor;
        curBerthLab.textAlignment = NSTextAlignmentLeft;
        curBerthLab.font = ContentFont;
        
        [processContent addSubview:curBerthLab];
        [curBerthLab release];
        
        UILabel *leaveBerthTimeTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 105, 30)];
        leaveBerthTimeTitle.backgroundColor = [UIColor clearColor];
        leaveBerthTimeTitle.textColor = DetailContentTextColor;
        leaveBerthTimeTitle.textAlignment = NSTextAlignmentRight;
        leaveBerthTimeTitle.font = ContentFont;
        leaveBerthTimeTitle.text = @"离开当前泊位时间：";
        
        [processContent addSubview:leaveBerthTimeTitle];
        [leaveBerthTimeTitle release];
        
        leaveBerthTime = [TimeButton buttonWithType:UIButtonTypeCustom];
        leaveBerthTime.frame = CGRectMake(108, 40, 310, 30);
        [processContent addSubview:leaveBerthTime];
        
        BusinessProcessButton *leaveBerthBtn = [BusinessProcessButton buttonWithTitle:@"离开泊位"];
        //王佳佳 5/30
        leaveBerthBtn.enabled=NO;
        //王佳佳 5/30
        [leaveBerthBtn setFrame:CGRectMake(330, 40, 90, 30)];
        [leaveBerthBtn addTarget:self action:@selector(leaveBerthingClick)
           forControlEvents:UIControlEventTouchUpInside];
        [processContent addSubview:leaveBerthBtn];
        
        UILabel *portDetailTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 75, 105, 30)];
        portDetailTitle.backgroundColor = [UIColor clearColor];
        portDetailTitle.textColor = DetailContentTextColor;
        portDetailTitle.textAlignment = NSTextAlignmentRight;
        portDetailTitle.font = ContentFont;
        portDetailTitle.text = @"移    泊：";
        
        [processContent addSubview:portDetailTitle];
        [portDetailTitle release];
        
        m_berthName = [CustomListBox buttonWithType:UIButtonTypeCustom];
        m_berthName.frame = CGRectMake(108, 75, 52, 30);
        m_berthName.delegate = self;
        [processContent addSubview:m_berthName];
        
        m_berthPos = [CustomListBox buttonWithType:UIButtonTypeCustom];
        m_berthPos.frame = CGRectMake(165, 75, 42, 30);
        [processContent addSubview:m_berthPos];
        
        UILabel *berthPosTitle = [[UILabel alloc] initWithFrame:CGRectMake(202, 75, 123, 30)];
        berthPosTitle.backgroundColor = [UIColor clearColor];
        berthPosTitle.textColor = DetailContentTextColor;
        berthPosTitle.textAlignment = NSTextAlignmentLeft;
        berthPosTitle.font = ContentFont;
        berthPosTitle.text = @"（00表示锚地）公司";
        [processContent addSubview:berthPosTitle];
        [berthPosTitle release];
        
        m_berthCom = [CustomListBox buttonWithType:UIButtonTypeCustom];
        m_berthCom.frame = CGRectMake(325, 75, 65, 30);
        [processContent addSubview:m_berthCom];
        
        UILabel *berthComTitle = [[UILabel alloc] initWithFrame:CGRectMake(395, 75, DetailContentWidth-395, 40)];
        berthComTitle.backgroundColor = [UIColor clearColor];
        berthComTitle.textColor = DetailContentTextColor;
        berthComTitle.textAlignment = NSTextAlignmentLeft;
        berthComTitle.font = [UIFont boldSystemFontOfSize:10];
        berthComTitle.numberOfLines=0;
        berthComTitle.text = @"如无泊位租用，无需修改";
        
        [processContent addSubview:berthComTitle];
        [berthComTitle release];
        
        UILabel *berthTimeTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 110, 105, 30)];
        berthTimeTitle.backgroundColor = [UIColor clearColor];
        berthTimeTitle.textColor = DetailContentTextColor;
        berthTimeTitle.textAlignment = NSTextAlignmentRight;
        berthTimeTitle.font = ContentFont;
        berthTimeTitle.text = @"停靠新的泊位时间：";
        
        [processContent addSubview:berthTimeTitle];
        [berthTimeTitle release];
        
        berthTime = [TimeButton buttonWithType:UIButtonTypeCustom];
        berthTime.frame = CGRectMake(108, 110, 217, 30);
        [processContent addSubview:berthTime];
        
        [processTable addSubview:processContent];
        
        BusinessProcessButton *berthBtn = [BusinessProcessButton buttonWithTitle:@"移   泊"];
        [berthBtn setFrame:CGRectMake(330, 110, 80, 30)];
        [berthBtn addTarget:self action:@selector(moveBerthingClick)
           forControlEvents:UIControlEventTouchUpInside];
        [processContent addSubview:berthBtn];
        
        [processContent release];
        
        [processTable release];
    }
    return self;
}

- (void)dealloc
{
    [m_planMoveBerthTimeLab release];
    [m_planMoveBerthNoLab release];
    
    [curBerthLab release];
    
    [leaveBerthTime release];
    [berthTime release];
    
    [m_berthName release];
    [m_berthPos release];
    [m_berthCom release];
    
    [super dealloc];
}

- (void) planCompleteClick
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(planCompleteClick)]) {
        [m_delegate planCompleteClick];
    }
}

- (void) leaveBerthingClick
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(leaveBerthingClick:)]) {
        [m_delegate leaveBerthingClick:leaveBerthTime.time];
    }
}

- (void) moveBerthingClick
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(moveBerthingClick:withBerthId:andBerthPos:andCompId:)]) {
        [m_delegate moveBerthingClick:berthTime.time
                          withBerthId:m_berthName.selectedItem
                          andBerthPos:m_berthPos.selectedValue
                            andCompId:m_berthCom.selectedValue];
    }
}

- (NSString *)planMoveBerthTime
{
    return m_planMoveBerthTimeLab.text;
}

-(void)setPlanMoveBerthTime:(NSString *)planMoveBerthTime
{
    if (planMoveBerthTime) {
        m_planMoveBerthTimeLab.text = [NSString stringWithFormat:@"%@%@",@"计划移泊时间：", planMoveBerthTime];
    }
}

- (NSString *)planMoveBerthNo
{
    return m_planMoveBerthNoLab.text;
}

-(void)setPlanMoveBerthNo:(NSString *)planMoveBerthNo
{
    if (planMoveBerthNo) {
        m_planMoveBerthNoLab.text = [NSString stringWithFormat:@"%@%@",@"计划移泊泊位：", planMoveBerthNo];
    }
}

- (void)setCurBerth:(NSString *)curBerth
{
    curBerthLab.text = curBerth;
}

-(NSString *)curBerth
{
    return curBerthLab.text;
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
