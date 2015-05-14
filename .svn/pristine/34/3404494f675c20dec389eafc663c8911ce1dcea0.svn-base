//
//  NewPDFPaintController.h
//  MOA
//
//  Created by  on 11-12-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommonPDFScrollView.h"

#import "PDFDocument.h"


#define kAlertViewFlipConfirm             102
#define kAlertViewSignBack                1002

#import "PDFFuncToolbar.h"
#import "PDFBrowseToolbar.h"
#import "PDFSignToolbar.h"
#import "BottomBarView.h"
#import "BaseViewController.h"


FOUNDATION_EXPORT      NSString             *const kPDFInfoPermission;//PDF信息查看权限
FOUNDATION_EXPORT      NSString             *const kPDFCommitPermission;//PDF提交权限
FOUNDATION_EXPORT      NSString             *const kPDFSignPermission;//PDF签批权限
FOUNDATION_EXPORT      NSString             *const kPDFAccessoryPermission;//PDF附件权限
FOUNDATION_EXPORT      NSString             *const kPDFHelpPermission;//PDF帮助权限
FOUNDATION_EXPORT      NSString             *const kPDFCheckPermission;//PDF查看权限

typedef enum
{
    OFF = 0,
    ON
}PDFToolPermission;


@class CommonPDFScrollView;

@protocol PDFToolDelegate <NSObject>

@optional

- (void)tappedInPDFToolbar:(UIView *)toolbar infoButton:(UIButton *)button;

- (void)tappedInPDFToolbar:(UIView *)toolbar sendButton:(UIButton *)button;

- (void)tappedInPDFToolbar:(UIView *)toolbar backButton:(UIButton *)button;

- (void)tappedInPDFToolbar:(UIView *)toolbar startSignButton:(UIButton *)button;

- (void)tappedInPDFToolbar:(UIView *)toolbar endSignButton:(UIButton *)button;

- (void)tappedInPDFToolbar:(UIView *)toolbar accessoryButton:(UIButton *)button;

- (void)tappedInPDFToolbar:(UIView *)toolbar checkButton:(UIButton *)button;

@end


@protocol PDFViewDisplayDelegate <NSObject>

- (void)PDFViewInitializeTitleLabel:(UILabel *)label;

@end

@interface PDFToolViewController : UIViewController <UIAlertViewDelegate,PDFScrollViewDelegate,PDFFuncToolbarDelegate,PDFBrowseToolbarDelegate,PDFSignToolbarDelegate,BottomBarViewDelegate>
{
    id      _delegate;
    id      _displayDelegate;
    
	UIImageView *toolbarImageVIew;
	
    UIToolbar *pageToolBar;//下方直接翻页的工具栏
    UILabel *pageHighlightedLabel;//翻页时显示页码
    
    CommonPDFScrollView *pdfScrollView;

    NSInteger currentBrushColorIndex;//当前的画笔颜色

	BOOL isNeedEncrypt;		//pdf保存时，是否需要加密
    
    
    PDFDocument *document;
    
    UIImageView                 *backgroundView;
    UIImageView                 *helpImageView;
    
    UILabel                     *titleLabel;
    
    PDFFuncToolbar              *funcToolbar;
    PDFBrowseToolbar            *browseToolbar;
    PDFSignToolbar              *signToolbar;
    
    UIView                      *touchView; //按住移动视图
    UIImageView                 *touchImageView;
    
}

@property (nonatomic, assign) id <PDFToolDelegate> delegate;
@property (nonatomic, assign) id <PDFViewDisplayDelegate> displayDelegate;
@property (nonatomic, retain) PDFDocument *document;

- (id)initWithDocument:(PDFDocument *)doc;

//设置PDF工具栏的功能权限
- (void)setToolbarPermission:(PDFToolPermission)permission forKey:(NSString *)key;

- (void)startSign;
- (void)endSign;

- (void)savePDF;

- (void)dismissPDFToolViewController;

- (void)loadPDFDocument:(PDFDocument *)doc;

@end


