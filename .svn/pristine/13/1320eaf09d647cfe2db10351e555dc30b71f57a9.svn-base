//
/********************************************************************
 Author: li_xiangai
 Class description:SimpleSwitch
 *******************************************************/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface SimpleSwitch : UIControl<UIGestureRecognizerDelegate>
{
    UIImageView *backImage;
    UIButton *knobButton;
    CGRect knobFrameOn;
    CGRect knobFrameOff;
    BOOL on;
  
    UIImage *onImageNormal;
    UIImage *onImageSelected;
    
    UIImage *offImageNormal;
    UIImage *offImageSelected;
    
    UIImage *backImageNormal;
   
    

}
@property(assign,nonatomic) BOOL on;

@property(retain,nonatomic)  UIImage *onImageNormal;
@property(retain,nonatomic)UIImage *onImageSelected;

@property(retain,nonatomic)UIImage *offImageNormal;
@property(retain,nonatomic)UIImage *offImageSelected;

@property(retain,nonatomic)UIImage *backImageNormal;

- (void)setOn:(BOOL)on animated:(BOOL)animated;
- (id)initWithFrame:(CGRect)frame onNormalImage:(UIImage*)onImage1
    onSelectedImage:(UIImage*)onImage2 offNormalImage:(UIImage*)imageOff1
   offSelectedImage:(UIImage*)imageOff2 backImage:(UIImage*)backImage1;
@end
