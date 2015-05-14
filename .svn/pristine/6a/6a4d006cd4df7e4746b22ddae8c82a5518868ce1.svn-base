/*
     File: PaintingView.h
 Abstract: The class responsible for the finger painting. The class wraps the 
 CAEAGLLayer from CoreAnimation into a convenient UIView subclass. The view 
 content is basically an EAGL surface you render your OpenGL scene into.
  Version: 1.11
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
*/

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>


//CONSTANTS:

#define kBrushOpacity		1	//透明度
#define kBrushPixelStep		1	//间隔像素
#define kBrushScale			12//12	//比划粗细 越大越细
#define kBrushScaleLevel1	18	//比划粗细 越大越细
#define kBrushScaleLevel3	9//6	//比划粗细 越大越细
#define kLuminosity			0.75//饱和度
#define kSaturation			1.0	//亮度
#define kMaxPixelWithoutBezier		4.0	//最大的不用贝塞尔曲线划线的像素数量,
										//也就是当两个取样点之间的距离小于此像素时,采取均匀画点的方法
										//而当取样点之间的距离大于此像素时, 采取贝塞尔拟合的方式画点
										//经过实验, 最大像素在3到5之间的时候效果最明细; 但是依然对于快字和慢字体现出来的效果不一样

//add by gyf begin
#define kSmoothValueX		0.15	//贝塞尔曲线的K值X
#define kSmoothValueY		0.15	//贝塞尔曲线的K值Y
#define kSpeedScaleX2		4.0		//根据速度计算笔画粗细的二阶参数
#define kSpeedScaleX1		8.0		//根据速度计算笔画粗细的一阶参数
#define kSpeedScaleX0		1.0		//根据速度计算笔画粗细的一阶参数
#define kMaxRatioOfSpeedScale 2.5	//最细笔画和最粗笔画的比例
#define speedScale			500

#define kRed				0.0//46.0	//画笔颜色(红色)//蓝色：0,0,105   红色：196,0,0		黑色：0,0,0		绿色：0,106,0	紫色：35,0,144
#define kGreeen				0.0//77.0	//画笔颜色(绿色)
#define kBlue				105.0//120.0	//画笔颜色(蓝色)

#define kMinPointTouchPixel	3		//如果用户只是点一个点, 在只能取到一个点的情况下, 人工帮其补几个像素的点
#define kMaxScaleInteval	0.32	//最大的笔画粗细相差的间隔
#define kEraserSize			6		//橡皮擦与修正液的擦除轨迹大小

#define kSwitchReadStatusMargin     200     //中间下拉出签批状态的范围宽度
#define kMinTouchMoveDistanceForYToSwitchReadStatus     200     //最小的需要下拉的高度以使签批状态变换
//add by gyf end

//CLASS INTERFACES:
@protocol PaintViewDelegate

@optional
-(void)touchBegin;
-(void)touchFromBottomToTop;
-(void)noneDrawPath;
-(void)inMoveMargin;//进入移动区域
@end

@interface PaintingView : UIView 
{
@private
	// The pixel dimensions of the backbuffer
	GLint backingWidth;
	GLint backingHeight;
	
	EAGLContext *context;
	
	// OpenGL names for the renderbuffer and framebuffers used to render to this view
	GLuint viewRenderbuffer, viewFramebuffer;
	
	// OpenGL name for the depth buffer that is attached to viewFramebuffer, if it exists (0 if it does not exist)
	GLuint depthRenderbuffer;
	
	GLuint	brushTexture;
	CGPoint	location;
	CGPoint	previousLocation;
	Boolean	firstTouch;
	Boolean needsErase;	
	
	//add by gyf begin
	Boolean changeFlag;
	CGPoint prepreviousLocation;
	CGPoint nextLocation;
	NSTimeInterval previousTimeStamp;
	NSTimeInterval timeSincePrevious;
	GLfloat brushwidth;
	CGFloat scaleFactor;//笔画的粗细因数
	NSInteger pointCounts;//采样点的数量
	NSTimeInterval firstTimeStamp;//开始时间
	NSTimeInterval lastTimeStamp;//结束时间
	
	CGFloat changedScaleFactor;
	//CGFloat currentScale;//当前画面缩放比例
	
	BOOL isEndTouch;//是否结束了当前Touch
	
	NSMutableArray *recordPath;
	NSInteger currentRecordPathCount;
    
    NSMutableData*	lastRecord;
	
	CGFloat currentRed,currentBlue,currentGreen,currentAlpha;
	CGFloat currentScale;
	BOOL isRealZooming;//是否真的是在缩放
    
    id _paintViewDelegate;
	//add by gyf end
    CGPoint startPoint;//开始触点
    CGPoint previousPoint;
    BOOL isInCenterMargin;//是否所有的触摸都是在中间区域
    NSInteger maxRecordPathCount;//最大取消画笔数量
    
    NSMutableArray *undoStorkeImage;//存放取消画笔的每一笔的图片
    UIImage *currentDrawImage;//当前画笔的最新图片
    UIImageView *undoImageView;//单步取消背景
    GLubyte *buffer2;
    BOOL isEdit;//本页是否编辑
    CGFloat currentBorderX;//当前的边缘的像素
    BOOL isMoveMargin;//是否移动边缘
}

@property(nonatomic, readwrite) CGPoint location;
@property(nonatomic, readwrite) CGPoint previousLocation;

//add by gyf begin
@property Boolean changeFlag;
@property(nonatomic, readwrite) CGPoint prepreviousLocation;
@property(nonatomic, readwrite) CGPoint nextLocation;
@property(nonatomic, readwrite) GLfloat brushwidth;
@property(nonatomic, readwrite) CGFloat scaleFactor;
@property(nonatomic, readwrite) NSInteger pointCounts;
@property NSTimeInterval previousTimeStamp;
@property NSTimeInterval timeSincePrevious;
@property NSTimeInterval firstTimeStamp;
@property NSTimeInterval lastTimeStamp;

@property(nonatomic, readwrite) CGFloat changedScaleFactor;

@property(nonatomic, readwrite)  BOOL isEndTouch;
@property(nonatomic, readwrite) BOOL isRealZooming;
@property (nonatomic, assign) NSInteger currentBrushScaleLevel;
@property (nonatomic,readonly) BOOL isMoveMargin;
@property (nonatomic, assign) IBOutlet id <PaintViewDelegate> paintViewDelegate;

@property (nonatomic, readwrite) CGFloat currentBorderX;
//add by gyf end

- (void)erase;//清空页面
- (void) eraseForUndo;//为了单步取消的清空页面
- (void)setBrushColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

//add by gyf begin
- (void)setBrushColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue speed:(CGFloat)speed;
- (void)eraseWithTransparent;
//- (void)eraseWithWhite;
//add by gyf end

- (void)setBruchScale:(CGFloat)speed;

- (void) drawErase:(CGPoint)start toPoint:(CGPoint)end;

- (void) undoStoke;

- (void) refreshParticle;//为了使手写频率加速而做的透明笔画预渲染
- (void) setBruchScaleLevel:(NSInteger) level;//设置画笔的粗细，一共三级，第一级为较细（当放大画板两倍时缩小后笔触和普通三号字差不多大小；第二级为普通（在不缩放级别的时候写字）；第三级为较粗（笔粗放大两倍）。三级的比例是：0.5:1.0:2.0
//- (void)setScale:(CGFloat)scale;
- (void)refreshFrame;//重新刷新框架大小
//get image
-(UIImage *) glToUIImage;
//-(CGImageRef) glToCGImageRef;
//取消上一步画笔操作（新版，图片替代的方式，完美）
- (void) undoStokeForImage;
//获取当前最新画板图片
- (UIImage *) getCurrentImage;
//获取当前取消ImageView
- (UIImageView *)getUndoImageView;
//在后台保存单步取消的图片
//- (void)saveUndoImageInBackground;
- (void)eraseWithWhite;//用白色擦皮
- (BOOL)getIsEdit;//获取是否编辑状态
- (void)setIsEdit:(BOOL)isEditValue;//设置是否编辑状态
- (void) undoLastStoke;//取消最后一笔的操作
- (void)freeBuffer2;//释放图片缓存
@end
