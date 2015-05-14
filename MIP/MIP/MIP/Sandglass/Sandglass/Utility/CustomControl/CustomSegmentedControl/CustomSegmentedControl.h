//
//  CustomSegmentedControl.h
//  DocTrans
//
//  Created by Sea on 13-10-15.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    
    SegmentIndexNotFound = -1
};

@interface CustomSegmentedControl : UIView {
    
    CALayer             *_backgroundLayer;
    
    CALayer             *_sliderLayer;
    
    NSMutableArray      *_buttonArrays;
}

/*!
 @function
 @abstract      设置自定义segmentedControl背景图片的属性
 
 @param         backgroundImage         需要设置的背景图片
 
 @result
 */
@property (nonatomic, retain) UIImage *backgroundImage;



/*!
 @function
 @abstract      设置按钮滑块背景图片的属性
 
 @param         sliderImage             需要设置的背景图片
 
 @result
 */
@property (nonatomic, retain) UIImage *sliderImage;


/*!
 @function
 @abstract      设置默认选中的按钮,默认值为0
 
 @param         selectedButtonIndex     需要设置默认选中的按钮序号
 
 @result
 */
@property (nonatomic, assign) NSInteger  selectedButtonIndex;

- (UIButton *)buttonAtIndex:(NSInteger)index;

- (UIButton *)insertButton;

- (UIButton *)insertButtonWithTarget:(id)target action:(SEL)action;


//设置默认选择项
- (void)setdefaultSelectButtonIndex:(NSInteger)index;


@end
