//
//  BusinessCheckBox.h
//  BusinessProcess
//
//  Created by lu_sicong on 2014/05/22.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCheckBox : UIButton
{
    BOOL m_checked;
    
    UIView *checkMark;
}

@property (nonatomic, assign) BOOL checked;

+ (BusinessCheckBox *)button;

@end
