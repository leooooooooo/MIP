//
//  BusinessLevelTwoCell.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/02.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CellHeight                  20

@interface BusinessLevelTwoCell : UITableViewCell
{
    UIView *m_customBtnView;
}

@property (nonatomic, retain) UIView *customBtnView;

- (void) setFrameWithWidthList : (NSArray *) widthList;

- (void) addText : (NSArray *)textList;

@end
