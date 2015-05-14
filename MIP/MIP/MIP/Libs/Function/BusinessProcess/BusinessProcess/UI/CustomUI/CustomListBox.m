//
//  CustomListBox.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/08.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "CustomListBox.h"
#import "PopListTableViewController.h"
#import "SuspendController.h"

#define RowHeight       20
#define MaxRowCount     5

#define BgImage         [UIImage imageNamed:@"bg_input_style3.png" imageBundle:publicResourceBundle]
#define ArrowImage      [UIImage imageNamed:@"icon_arrow_down_style1.png" imageBundle:publicResourceBundle]

#define ArrowTag        1001


@interface CustomListBox() <ListBoxSelectDelegate, SuspendControllerDelegate>
{
    PopListTableViewController *_tableCtrl;
    
    SuspendController *suspendCtrl;
}

@end

@implementation CustomListBox
@synthesize selectedItem = m_selectedItem, selectedValue = m_selectedValue;
@synthesize delegate = m_delegate;
@synthesize maxRowCount = m_maxRowCount;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundImage:[BgImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
//        [self setBackgroundImage:[BgImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self setTitleColor:[UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:ArrowImage];
        arrow.frame = CGRectMake(frame.size.width - 24, (frame.size.height - 10) / 2, 16, 10);
        arrow.tag = ArrowTag;
        [self addSubview:arrow];
        [arrow release];
        
        [self addTarget:self action:@selector(showPopList) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    UIView *tmpView = [self viewWithTag:ArrowTag];
    tmpView.frame = CGRectMake(frame.size.width - 24, (frame.size.height - 10) / 2, 16, 10);
}

- (void)dealloc
{
    [m_itemList release];
    [m_valueList release];
    
    [_tableCtrl release];
    
    [super dealloc];
}

- (void) bindingDataSource : (NSArray *)itemList
{
    m_itemList = [itemList retain];
    m_valueList = m_itemList;
    
    if (_tableCtrl) {
        _tableCtrl.dataArr = m_itemList;
        [_tableCtrl.tableView reloadData];
    }
    
    [self selectedWithIndex:0];
}

- (void) bindingDataValue : (NSArray *)valueList
{
    m_valueList = [valueList retain];
    m_selectedValue = [m_valueList objectAtIndex:[m_itemList indexOfObject:m_selectedItem]];
}


- (void) showPopList
{
    if (!_tableCtrl) {
        _tableCtrl = [[PopListTableViewController alloc] initWithStyle:UITableViewStylePlain];
        _tableCtrl.dataArr = m_itemList;
        _tableCtrl.delegate = self;
        _tableCtrl.maxRowCount = m_maxRowCount;
    }
    
    //计算内容视图的位置
    CGPoint point = [self.superview convertPoint:self.center toView:self.superview.superview];
    
    UIView *forFrame = self.superview;
    
    while (![forFrame.superview.superview isKindOfClass:[UIWindow class]]) {
        
        point = [forFrame.superview convertPoint:point toView:forFrame.superview.superview];
        
        NSLog(@"x=%f,y=%f",point.x,point.y);
        
        forFrame = forFrame.superview;
        
    }
    
    CGRect rect = self.frame;
    
    rect.origin.x = point.x ;
    rect.origin.y = point.y ;
    
    rect.origin.x = point.x - rect.size.width / 2;
    rect.origin.y = point.y + rect.size.height / 2 - 1;
    
    _tableCtrl.tableFrame = rect;
    
    suspendCtrl = [[SuspendController alloc] initWithContentViewController:_tableCtrl];
    suspendCtrl.suspendDelegate = self;
    
    [suspendCtrl show];
}

- (void)selectedWithIndex:(NSInteger)index
{
    if ([m_itemList count] > index) {
        m_selectedItem = [m_itemList objectAtIndex:index];
    }
    if ([m_valueList count] > index) {
        m_selectedValue = [m_valueList objectAtIndex:index];
    }
    if (!m_selectedItem) {
        return;
    }
    
    [self setTitle:m_selectedItem forState:UIControlStateNormal];
    
    if (suspendCtrl) {
        [suspendCtrl dismiss];
    }
    
    if (m_delegate &&
        [m_delegate respondsToSelector:@selector(selectedItemWithIndex:andTag:)])
    {
        [m_delegate selectedItemWithIndex:index andTag:self.tag];
    }
}

- (void)dismissAction
{
    suspendCtrl = nil;
}

- (void)setMaxRowCount:(NSInteger)maxRowCount
{
    m_maxRowCount = maxRowCount;
    _tableCtrl.maxRowCount = m_maxRowCount;
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
