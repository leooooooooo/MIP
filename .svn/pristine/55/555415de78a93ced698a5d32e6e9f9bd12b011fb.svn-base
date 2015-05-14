//
//  SGSwitch.h
//  Sandglass
//
//  Created by sea on 13-11-21.
//
//

#import <UIKit/UIKit.h>

enum {
    SGControlStateNormal       = 0,                     //已实现
    SGControlStateHighlighted  = 1 << 0,                //已实现
    SGControlStateDisabled     = 1 << 1,
    SGControlStateSelected     = 1 << 2,
};
typedef NSUInteger SGControlState;


@class CALayer;

@interface SGSwitch : UIControl<UIGestureRecognizerDelegate> {
    
    UIImageView         *_backgroundView;
    
    CALayer             *_slider;
}

@property(nonatomic,getter=isOn) BOOL on;

@property(nonatomic,retain) UIImage *backgroundImage;

- (void)setOnImage:(UIImage *)image forState:(SGControlState)state;
- (void)setOffImage:(UIImage *)image forState:(SGControlState)state;


- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
