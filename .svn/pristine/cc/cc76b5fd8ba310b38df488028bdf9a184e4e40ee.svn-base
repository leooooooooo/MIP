//
//  PDFFuncToolbar.h
//  MOA_PDF
//
//  Created by Sea on 13-11-5.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFFuncToolbar;

@protocol PDFFuncToolbarDelegate <NSObject>

@optional // Delegate protocols

- (void)tappedInFuncToolbar:(PDFFuncToolbar *)toolbar backButton:(UIButton *)button;
- (void)tappedInFuncToolbar:(PDFFuncToolbar *)toolbar infoButton:(UIButton *)button;
- (void)tappedInFuncToolbar:(PDFFuncToolbar *)toolbar sendButton:(UIButton *)button;
- (void)tappedInFuncToolbar:(PDFFuncToolbar *)toolbar helpButton:(UIButton *)button;
- (void)tappedInFuncToolbar:(PDFFuncToolbar *)toolbar rotateButton:(UIButton *)button;
- (void)tappedInFuncToolbar:(PDFFuncToolbar *)toolbar accessoryButton:(UIButton *)button;
- (void)tappedInFuncToolbar:(PDFFuncToolbar *)toolbar checkButton:(UIButton *)button;

@end

@interface PDFFuncToolbar : UIImageView {
    
    UIButton            *backButton;
    UIButton            *infoButton;
    UIButton            *sendButton;
    UIButton            *helpButton;
    UIButton            *rotateButton;
    UIButton            *accessoryButton;
    UIButton            *checkButton;
}

@property (nonatomic, assign) id <PDFFuncToolbarDelegate> delegate;

@property (nonatomic, retain, readonly) UIButton            *backButton;
@property (nonatomic, retain, readonly) UIButton            *infoButton;
@property (nonatomic, retain, readonly) UIButton            *sendButton;
@property (nonatomic, retain, readonly) UIButton            *helpButton;
@property (nonatomic, retain, readonly) UIButton            *rotateButton;
@property (nonatomic, retain, readonly) UIButton            *accessoryButton;
@property (nonatomic, retain, readonly) UIButton            *checkButton;

- (void)setFuncButtonEnable:(BOOL)enable;

- (void)setButton:(UIButton *)button enable:(BOOL)enable;

@end
