//
//  PDFBrowseToolbar.h
//  MOA_PDF
//
//  Created by Sea on 13-11-5.
//  Copyright (c) 2013年 Sea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFBrowseToolbar;

@protocol PDFBrowseToolbarDelegate <NSObject>

@optional // Delegate protocols

- (void)tappedInSignToolbar:(PDFBrowseToolbar *)toolbar startSignButton:(UIButton *)button;

- (void)tappedInSignToolbar:(PDFBrowseToolbar *)toolbar previousButton:(UIButton *)button;

- (void)tappedInSignToolbar:(PDFBrowseToolbar *)toolbar nextButton:(UIButton *)button;
@end

@interface PDFBrowseToolbar : UIView {
    
    UIButton        *startSignButton;
    
    UIButton        *previousButton;
    UIButton        *nextButton;
}

@property (nonatomic, assign) id <PDFBrowseToolbarDelegate> delegate;

@property (nonatomic, retain,readonly) UIButton        *startSignButton;
@property (nonatomic, retain,readonly) UIButton        *previousButton;
@property (nonatomic, retain,readonly) UIButton        *nextButton;

@end
