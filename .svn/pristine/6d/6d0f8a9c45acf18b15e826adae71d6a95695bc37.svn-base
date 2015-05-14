//
//  PDFSignToolbar.h
//  MOA_PDF
//
//  Created by Sea on 13-11-5.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFSignToolbar;

@protocol PDFSignToolbarDelegate <NSObject>

@optional // Delegate protocols

- (void)tappedInSignToolbar:(PDFSignToolbar *)toolbar endSignButton:(UIButton *)button;

- (void)tappedInSignToolbar:(PDFSignToolbar *)toolbar colorButton:(UIButton *)button color:(UIColor *)color;

- (void)tappedInSignToolbar:(PDFSignToolbar *)toolbar sizeButton:(UIButton *)button size:(float)size;
- (void)tappedInSignToolbar:(PDFSignToolbar *)toolbar sizeButton:(UIButton *)button level:(NSInteger)level;

- (void)tappedInSignToolbar:(PDFSignToolbar *)toolbar clearButton:(UIButton *)button;
- (void)tappedInSignToolbar:(PDFSignToolbar *)toolbar eraseButton:(UIButton *)button;

- (void)tappedInSignToolbar:(PDFSignToolbar *)toolbar undoButton:(UIButton *)button;
- (void)tappedInSignToolbar:(PDFSignToolbar *)toolbar redoButton:(UIButton *)button;

@end

@interface PDFSignToolbar : UIView {
    
    UIImageView         *penBackground;
    
    UIButton            *endSignButton;
    
    UIButton            *currentColorButton;
    UIButton            *redColorButton;
    UIButton            *greenColorButton;
    UIButton            *blueColorButton;
    UIButton            *blackColorButton;
    
    UIButton            *currentSizeButton;
    UIButton            *weeSizeButton;
    UIButton            *normalSizeButton;
    UIButton            *boldSizeButton;
    
    UIButton            *clearButton;
    UIButton            *eraseButton;
    
    UIButton            *undoButton;
    UIButton            *redoButton;
    
}

@property (nonatomic, assign) id <PDFSignToolbarDelegate> delegate;

@property (nonatomic, assign) NSInteger size;
-(void)setcurrentColorButton:(int)value;

@end
