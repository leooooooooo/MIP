//
//  TabBarItemView.h
//  GACloud
//
//  Created by kangqijun on 14-3-17.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarItemView : UIView
{
    UIImageView   *bgImageView;
    
    UILabel       *nameLab;
    
    UIButton      *itemButton;
}

@property (retain, nonatomic) UIImageView   *bgImageView;

@property (retain, nonatomic) UILabel       *nameLab;

@property (retain, nonatomic) UIButton      *itemButton;

@end
