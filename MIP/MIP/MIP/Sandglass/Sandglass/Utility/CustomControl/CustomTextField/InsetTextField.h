//
//  InsetTextField.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/24.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetTextField : UITextField
{
    CGPoint inset;
    CGPoint clearButtonInset;
}

@property (nonatomic, assign) CGPoint inset;
@property (nonatomic, assign) CGPoint clearButtonInset;

@end
