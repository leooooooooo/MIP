//
//  BaseView.h
//  MIP
//
//  Created by Sea on 13-9-3.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImage+CustomExtensions.h"
#import "UIButton+CustomExtensions.h"

@class CALayer;

@interface BaseView : UIView {
    
    CALayer         *_backgroundLayer;
}

/*!
 @function
 @abstract      设置视图背景图片的属性
 
 @param         backgroundImage         需要设置的背景图片
 
 @result
 */
@property (nonatomic, retain) UIImage *backgroundImage;


@end