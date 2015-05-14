//
//  AlertView.h
//  GACloud
//
//  Created by lixiangai on 14-4-14.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AlertView : UIView<UITextViewDelegate>
{
    UIView          *contentView;
    UIScrollView    *whiteView;
    UIButton        *sureButton;
    
    UIImageView     *bgView;
    
    UILabel         *titleLab;
    UILabel         *messageLab;
}

- (id) initWithTitle:(NSString *)title andMessage : (NSString *)message;

- (void) addToView : (UIView *)view;

@end
