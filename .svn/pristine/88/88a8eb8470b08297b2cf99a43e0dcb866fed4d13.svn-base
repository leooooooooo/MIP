//
//  ShipDetailView.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/09.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "ShipDetailView.h"

#define FrameWidth              self.frame.size.width
#define FrameHeight             self.frame.size.height

#define TopBorderWidth          10
#define SideBorderWidth         10

#define TableWidth              (FrameWidth - SideBorderWidth * 2)
#define CellHeight              35
#define CellTitleWidth          64.5
#define CellContentWidth        105
#define CellWidth               (CellTitleWidth + CellContentWidth)
#define RowCellCount            3

#define VoyageTableCell         [NSArray arrayWithObjects:@"中文船名", @"英文船名", @"性质", @"进口航次", @"出口航次", @"内外贸", @"来港", @"去港", @"预计到港时间", @"进口吃水", @"出口吃水", @"速/滞费", nil]

#define SummaryTableCell        [NSArray arrayWithObjects:@"国籍", @"呼号", @"航速", @"总吨", @"净吨", @"载重吨", @"长度", @"宽度", @"公分吨", @"船舶类型", @"舱口数", @"最大吃水", @"船公司", @"建造日期", nil]

#define ClientTableCell         [NSArray arrayWithObjects:@"简称", @"地址", @"电挂", @"电话", @"传真", @"二委", nil]

#define AboutTableCell          [NSArray arrayWithObjects:@"引水", @"检疫", @"开关仓", @"哨兵", @"熏蒸", nil]

#define LoadTableCellWidth      [NSArray arrayWithObjects:@"90", @"210", @"100", @"100", @"100", @"200", @"100", nil]
#define LoadTableCell           [NSArray arrayWithObjects:@"序号", @"装货名称", @"数量", @"单位", @"票数", @"装货公司", @"通关", nil]
#define UnloadTableCell         [NSArray arrayWithObjects:@"序号", @"卸货名称", @"数量", @"单位", @"票数", @"卸货公司", @"", nil]
#define LoadTableMinCount       3

#define LeftTitleWidth          40
#define DetailContentWidth      (TableWidth - LeftTitleWidth)

#define BorderColor             [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1.0]

#define LeftTitleTextColor      [UIColor whiteColor]
#define LeftTitleBgColor        [UIColor colorWithRed:136/255.0 green:164/255.0 blue:196/255.0 alpha:1.0]

#define CellTextColor           [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0]
#define CellTitleBgColor        [UIColor colorWithRed:234/255.0 green:241/255.0 blue:247/255.0 alpha:1.0]
#define CellContentBgColor      [UIColor whiteColor]

#define LeftTitleTextFont       [UIFont boldSystemFontOfSize:16]
#define CellTextFont            [UIFont boldSystemFontOfSize:14]

@implementation ShipDetailView

@synthesize arrVoyage = m_arrVoyage, arrSummary = m_arrSummary;
//@synthesize arrClient = m_arrClient, arrAbout = m_arrAbout;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
        m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, FrameWidth, FrameHeight)];
        
        [self addSubview:m_scrollView];
        
        CGFloat originY = TopBorderWidth;
        
        originY += [self createTable:@"航\n\n次" andCell:VoyageTableCell andOriginY:originY];
        
        originY += TopBorderWidth;
        
        originY += [self createTable:@"船\n\n舶\n\n概\n\n况" andCell:SummaryTableCell andOriginY:originY];
        
        originY += TopBorderWidth;
        
//        originY += [self createTable:@"委\n托\n人" andCell:ClientTableCell andOriginY:originY];
//
//        originY += TopBorderWidth;
//
//        originY += [self createTable:@"备注" andOriginY:originY];
//
//        originY += TopBorderWidth;
//
//        originY += [self createTable:@"相关\n\n信息" andCell:AboutTableCell andOriginY:originY];
//
//        originY += TopBorderWidth;
//
//        originY += [self createLoadInfoTable : originY];
//
//        originY += TopBorderWidth;
        
        m_scrollView.contentSize = CGSizeMake(FrameWidth,originY);
        
    }
    
    return self;
}

- (CGFloat) createTable : (NSString *)title andCell: (NSArray *)cellList andOriginY : (CGFloat) originY
{
    UIView *tmpTable = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    
    NSInteger rowCount =  ceil([cellList count] / 3.0);
    
    tmpTable.frame = CGRectMake(SideBorderWidth, originY, TableWidth + 1, CellHeight * rowCount + 1);
    tmpTable.backgroundColor = [UIColor clearColor];
    
    [m_scrollView addSubview:tmpTable];
    
    UIView *tmpTitle = [self createTableTitle:title andTableHeight:CellHeight * rowCount];
    
    [tmpTable addSubview:tmpTitle];
    
    UIView *cell = nil;
    
    NSInteger cellIndex = 0;
    
    NSInteger column = 0;
    
    NSInteger row = 0;
    
    for (NSString *cellTitle in cellList) {
        
        column = (cellIndex % 3);
        row = (cellIndex ++ / 3);
        
        CGRect frame = CGRectMake(LeftTitleWidth + CellWidth * column, CellHeight * row, CellWidth, CellHeight);
        
        cell = [self createCellView:cellTitle withFrame:frame];
        [tmpTable addSubview:cell];
        
    }
    
    for (column ++ ; column < 3; column++ ) {
        cell = [self createCellView:@"" withFrame:CGRectMake(LeftTitleWidth + CellWidth * column, CellHeight * row, CellWidth, CellHeight)];
        [tmpTable addSubview:cell];
    }
    
    return tmpTable.frame.size.height;
}

- (CGFloat) createTable : (NSString *)title andOriginY : (CGFloat) originY
{
    UIView *tmpTable = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    
    tmpTable.frame = CGRectMake(SideBorderWidth, originY, TableWidth + 1, CellHeight + 1);
    tmpTable.backgroundColor = [UIColor clearColor];
    
    [m_scrollView addSubview:tmpTable];
    
    UIView *tmpTitle = [self createTableTitle:title andTableHeight:CellHeight];
    
    [tmpTable addSubview:tmpTitle];
    
    UILabel *tmpContent = [[UILabel alloc] initWithFrame:CGRectMake(LeftTitleWidth, 0, 900 + 1, CellHeight + 1)];
    tmpContent.backgroundColor = CellTitleBgColor;
    tmpContent.textColor = CellTextColor;
    tmpContent.textAlignment = NSTextAlignmentLeft;
    tmpContent.font = CellTextFont;
    tmpContent.layer.borderColor = [BorderColor CGColor];
    tmpContent.layer.borderWidth = 1;
    
    [tmpTable addSubview:tmpContent];
    
    [tmpContent release];
    
    return tmpTable.frame.size.height;
}

- (UIView *) createTableTitle : (NSString *)title andTableHeight : (CGFloat) height
{
    UILabel *titleView = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, LeftTitleWidth + 1, height + 1)] autorelease];
    titleView.backgroundColor = LeftTitleBgColor;
    titleView.textColor = LeftTitleTextColor;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = LeftTitleTextFont;
    titleView.numberOfLines = 0;
    titleView.text = title;
    titleView.layer.borderColor = [BorderColor CGColor];
    titleView.layer.borderWidth = 1;
    
    return titleView;
}

- (UIView *) createCellView : (NSString *)title withFrame : (CGRect) frame
{
    UIView *cellView = [[[UIView alloc] initWithFrame:frame] autorelease];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CellTitleWidth + 1, CellHeight + 1)];
    titleLabel.backgroundColor = CellTitleBgColor;
    titleLabel.textColor = CellTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = CellTextFont;
    titleLabel.layer.borderColor = [BorderColor CGColor];
    titleLabel.layer.borderWidth = 1;
    titleLabel.text = title;
    titleLabel.numberOfLines = 2;
    
    [cellView addSubview:titleLabel];
    
    [titleLabel release];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellTitleWidth, 0, CellContentWidth + 1, CellHeight + 1)];
    contentLabel.backgroundColor = CellContentBgColor;
    contentLabel.textColor = CellTextColor;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = CellTextFont;
    contentLabel.layer.borderColor = [BorderColor CGColor];
    contentLabel.layer.borderWidth = 1;
    contentLabel.numberOfLines = 2;
    
    [cellView addSubview:contentLabel];
    
    [contentLabel release];
    
    return cellView;
}

- (CGFloat) createLoadInfoTable : (CGFloat) originY
{
    UIView *tmpTable = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    
    CGFloat tableHeight = CellHeight * (LoadTableMinCount + 1);
    
    tmpTable.frame = CGRectMake(SideBorderWidth, originY, TableWidth + 1, tableHeight * 2 + 1);
    tmpTable.backgroundColor = [UIColor clearColor];
    
    tmpTable.backgroundColor = [UIColor redColor];
    
    [m_scrollView addSubview:tmpTable];
    
    UIView *tmpTitle = [self createTableTitle:@"载\n\n货\n\n信\n\n息" andTableHeight:(tableHeight * 2)];
    
    [tmpTable addSubview:tmpTitle];
    
    CGFloat contentOriginY = 0.0;
    
    UIView *loadTable = [self createLoadTable:LoadTableCell andOriginY:contentOriginY];
    [tmpTable addSubview:loadTable];
    contentOriginY += loadTable.frame.size.height;
    
    UIView *unloadTable = [self createLoadTable:UnloadTableCell andOriginY:contentOriginY];
    [tmpTable addSubview:unloadTable];
    
    return tmpTable.frame.size.height;
}

- (UIView *) createLoadTable : (NSArray *)titleList andOriginY : (CGFloat) originY
{
    UIView *loadTable = [[[UIView alloc] initWithFrame:CGRectMake(LeftTitleWidth, originY, 900, CellHeight * (LoadTableMinCount + 1))] autorelease];
    
    UIView *loadTitle = [self createLoadTableTitle:titleList];
    [loadTable addSubview:loadTitle];
    
    for (int row = 1; row <= LoadTableMinCount; row++) {
        UIView *loadCell = [self createLoadTableCell:row];
        [loadTable addSubview:loadCell];
    }
    
    return loadTable;
}

- (UIView *) createLoadTableTitle : (NSArray *)titleList
{
    UIView *titleView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 900, CellHeight + 1)] autorelease];
    
    CGFloat originX = 0.0;
    
    NSInteger index = 0;
    
    for (NSString *strWidth in LoadTableCellWidth) {
        
        CGFloat width = [strWidth floatValue];
        
        NSString *title = [titleList objectAtIndex:index ++ ];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX, 0, width + 1, CellHeight + 1)];
        titleLabel.backgroundColor = CellTitleBgColor;
        titleLabel.textColor = CellTextColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = CellTextFont;
        titleLabel.layer.borderColor = [BorderColor CGColor];
        titleLabel.layer.borderWidth = 1;
        titleLabel.text = title;
        
        [titleView addSubview:titleLabel];
        
        [titleLabel release];
        
        originX += width;
    }
    
    return titleView;
}

- (UIView *) createLoadTableCell : (NSInteger) row
{
    UIView *contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, CellHeight * (row), 900, CellHeight + 1)] autorelease];
    
    CGFloat originX = 0.0;
    
    NSInteger index = 0;
    
    for (NSString *strWidth in LoadTableCellWidth) {
        
        CGFloat width = [strWidth floatValue];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX, 0, width + 1, CellHeight + 1)];
        
        if (index++ == 0) {
            contentLabel.backgroundColor = CellTitleBgColor;
            contentLabel.text = [NSString stringWithFormat:@"%d",row];
        }else {
            contentLabel.backgroundColor = CellContentBgColor;
        }
        
        contentLabel.textColor = CellTextColor;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.font = CellTextFont;
        contentLabel.layer.borderColor = [BorderColor CGColor];
        contentLabel.layer.borderWidth = 1;
        
        [contentView addSubview:contentLabel];
        
        [contentLabel release];
        
        originX += width;
    }
    
    return contentView;
}

- (void)setArrVoyage:(NSArray *)arrVoyage
{
    [self setData:arrVoyage forTableIndex:0];
}

- (void)setArrSummary:(NSArray *)arrSummary
{
    [self setData:arrSummary forTableIndex:1];
}

- (void) setData : (NSArray *) aData forTableIndex : (NSInteger) tableIndex
{
    NSInteger index = 0;
    
    UIView *voyageTable = [m_scrollView.subviews objectAtIndex:tableIndex];
    for (UIView *subView in voyageTable.subviews) {
        if (index >= [aData count]) {
            return;
        }
        
        if (![subView isKindOfClass:[UILabel class]]) {
            UILabel *textLabel = [subView.subviews objectAtIndex:1];
            textLabel.text = [aData objectAtIndex:index ++ ];
        }
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
