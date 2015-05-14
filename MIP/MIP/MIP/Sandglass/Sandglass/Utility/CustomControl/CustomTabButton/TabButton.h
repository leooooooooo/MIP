//
//  TabButton.h
//  Contacts
//
//  Created by lu_sicong on 2014/03/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabButtonDelegate <NSObject>

- (void) clickTagButtonWithBtnTag:(NSInteger) tagIndex;

@end

@interface TabButton : UIView
{
    NSArray        *m_buttonTitlesArray;
    
    NSInteger       m_btnCount;
    
    id              m_selectedBtn;
    
    UIImageView    *m_btnBgImgView;
    
    UIImageView    *m_bgImageView;
    
    __weak id<TabButtonDelegate> m_delegate;
}

@property (nonatomic, weak) id<TabButtonDelegate> delegate;

@property (nonatomic, retain) UIImage *backGroundImage;

@property (nonatomic, retain) UIImage *buttonBackGroundImage;

- (id) initWithFrame:(CGRect)frame andButtonTitles:(NSString *)button1Title,...;

- (id) initWithFrame:(CGRect)frame andButtonTitleList:(NSArray *)buttonTitles;

@end
