//
//  CommonUtility.h
//  GLPaint
//
//  Created by 陶杰 on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#define kSmoothValueX		0.15	//贝塞尔曲线的K值X
#define kSmoothValueY		0.15	//贝塞尔曲线的K值Y

#define kButtonWidth		64		//按钮宽度
#define kButtonHeight		64		//按钮高度


#define kPageLabelY			64		//页码的Y值（相对底部）


//以下是签批界面和画板的横竖屏像素
#define kDrawingScrollViewWidthLandscape    984//1014.0    //横屏的时候画板的宽度
#define kDrawingScrollViewWidthPortait      320//678.0//758.0     //竖屏的时候画板的宽度

#define kDrawingScrollViewPDFHeightLandscape   240.0  //PDF为横版时的高度

#define kDrawingScrollViewHeightLandscape   748.0     //横屏的时候画板的高度
#define kDrawingScrollViewHeightPortait     514     //竖屏的时候的画板高度
#define kDrawingScrollViewMargin            60.0       //画板左右下方的边距
//lixiangai 画板适配
#define kDrawingScrollViewTopMargin        (([[UIDevice currentDevice].systemVersion doubleValue]>=7.0)? 20 : 10)      //画板上方的边距
//end
//翻转角度
#define kDrawingScrollViewFlip0             0         //不翻转
#define kDrawingScrollViewFlip90            1         //翻转90度，向右
#define kDrawingScrollViewFlip180           2         //翻转180度，向下
#define kDrawingScrollViewFlip270           3         //翻转270度，向左

#define kPublicPassword                     @"Comprise"

#define kPDFReaderStyle1Bundle              @"PDFReaderStyle1.bundle"


@interface PaintUtility : NSObject {

}

+ (CGPoint)getNagetivePointByCurrentPoints:(CGPoint)currentPoint previousPoint:(CGPoint)previousPoint;
+ (CGPoint)getPostivePointByCurrentPoints:(CGPoint)currentPoint previousPoint:(CGPoint)previousPoint;
+ (void)computeBezierControlPointBy4PointsP0:(CGPoint)p0 p1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 c1:(CGPoint *)c1 c2:(CGPoint *)c2;

+ (UIImage*) imageBlackToTransparent:(UIImage*) image;

+ (NSString *)createUUID;

//图片合并，将两个图片合并成一个图片
+ (UIImage *)addTwoImageToOne:(UIImage *) oneImg twoImage:(UIImage *) twoImg;

//将PNG文件写入Document目录下，以FileName为文件名
+ (void)writePNGFileToFileName:(NSString *)fileName image:(UIImage *)image;

+(UIImage *)imageNamedFromContentFile:(NSString *)fileName;

@end
