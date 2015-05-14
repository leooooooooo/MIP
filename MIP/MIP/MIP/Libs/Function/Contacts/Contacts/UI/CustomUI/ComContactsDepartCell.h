//
//  ComContactsDepartCell.h
//  Contacts
//
//  Created by lu_sicong on 2014/04/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TableCellHeight          50.0

#define BackGroundColor     [UIColor colorWithRed:244/255.0 green:249/255.0 blue:255/255.0 alpha:1.0]

@interface ComContactsDepartCell : UITableViewCell
{
    BOOL m_isSelected;
    
    UILabel *m_titleLabel;
    
    UIImageView *m_arrowView;
}

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, retain) NSString *title;

@end
