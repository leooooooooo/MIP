//
//  BottomItemView.h
//  Sandglass
//
//  Created by kangqijun on 14-4-15.
//
//

#import <UIKit/UIKit.h>

@interface BottomItemView : UIView
{
    UIImageView   *bgImageView;
    
    UILabel       *nameLab;
    
    UIButton      *itemButton;
}

@property (retain, nonatomic) UIImageView   *bgImageView;

@property (retain, nonatomic) UILabel       *nameLab;

@property (retain, nonatomic) UIButton      *itemButton;

@end
