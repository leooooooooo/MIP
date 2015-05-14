//
//  FullCompanyCell.h
//  Contacts
//
//  Created by mengxianglei on 14-5-14.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TableCellHeight          (50.0)

#define BackGroundColor     [UIColor colorWithRed:244/255.0 green:249/255.0 blue:255/255.0 alpha:1.0]

@interface FullCompanyCell : UITableViewCell
{
    UILabel *m_titleLabel;
    
    UIImageView *m_arrowView;
}

@property (nonatomic, retain) NSString *title;

@end

