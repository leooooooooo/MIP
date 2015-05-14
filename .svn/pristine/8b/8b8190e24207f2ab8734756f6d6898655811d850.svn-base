//
//  CommonPDFScrollView.h
//  MOA
//
//  Created by  on 11-10-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaintingView.h"
#import "TiledPDFView.h"
@class TiledPDFView;
//add by gyf begin
@class PaintingView;
//add by gyf end
#define kInitSignScale  2.0     //初始化的签字画板缩放比例
#define kTurnPageMargin  120      //点击两边翻页的宽度
#define kSwitchReadStatusMargin     200     //中间下拉出签批状态的范围宽度
#define kMinTouchMoveDistanceForYToSwitchReadStatus     200     //最小的需要下拉的高度以使签批状态变换
#define kSwitchReadStatusTopMargin  160     //从上往下拉使签批状态变化的上面区域的高度
#define kPaintingViewTag            1001    //画板的Tag
#define kTiledPDFViewTag            1024    //切片的PDFView的Tag
#define kTiledPDFViewRemoveTag      1025    //需要移除的PDFView的Tag
#define kDelayTimer                 0.5     //翻页延时

@protocol PDFScrollViewDelegate

@optional

-(void)newPage;
-(void)drawTouchBegin;
-(void)touchFromTopToBottom;
-(void)drawTouchFromBottomToTop;
-(void)noneDrawPath;
-(void)touchInTheMiddle;//在屏幕中部点击
-(void)scrollTurnPageRefresh;
@end

@interface CommonPDFScrollView : UIScrollView <UIScrollViewDelegate,PaintViewDelegate,TiledPDFViewDelegate> {
    // The TiledPDFView that is currently front most
	//TiledPDFView *pdfView;
	// The old TiledPDFView that we draw on top of when the zooming stops
	//TiledPDFView *oldPDFView;
	
	// A low res image of the PDF page that is displayed until the TiledPDFView
	// renders its content.
	//UIImageView *backgroundImageView;
	
	
	// current pdf zoom scale
	CGFloat pdfScale;
	CGFloat pdfScaleWidth,initPdfScaleWidth,currentPdfScaleWidth;
	CGFloat pdfScaleHeight,initPdfScaleHeight,currentPdfScaleHeight;
	BOOL firstScale;
	
	CGPDFPageRef page;
	CGPDFDocumentRef pdf;
	
	//add by gyf begin
	//UIButton *nextButton;
	//UIButton *prevButton;
	//UILabel *pageLabel;
	int currentIdx;
	size_t pages;
	
	//PaintingView *drawingView;
	//PaintingView *oldDrawingView;
	//store painting pages
	NSMutableDictionary *paintingPages;
	//store painting images
	NSMutableDictionary *paintingImages;
    NSMutableDictionary *isFlipPages;//记录翻转页面效果的集合
	//add by gyf end
	
    //UIButton *prevButton;
	//UIButton *nextButton;
	//UILabel *pageLabel;
    
    //TiledPdfView的Frame大小
    CGRect tiledFrameRect;
    //是否需要DrawingView
    BOOL isNeedDrawingView;

    id<PDFScrollViewDelegate> scrollViewDelegate;
    
    BOOL isInCenterMargin;//是否所有的触摸都是在中间区域
    CGPoint previousPoint;//前一个触摸点
    CGPoint startPoint;//后一个触摸点
    BOOL isAutoScale;//是否自动放大
    BOOL isLandScape;//是否横屏
    float initScale;//转入签批状态初始放大倍数
    CGPoint initStartPoint;//转入签批状态文章定位位置
    BOOL isFirstSign;//是否第一次签批，如果第一次，则要放大，否则就不放大了
    UIImageView *undoImageView;//单步取消的ImageView
    BOOL hasCurrent;//本页是否现有画板
    NSInteger flipAngle;//翻转的角度 
    BOOL isLandscapePage;//本页是否为横页
    
    CGFloat moveMargin;//默认的移动边距
    
    NSTimer  *timer;//公用计时器
    
    //add by gao_yufeng begin 2012-6-7
    BOOL canOpen;//pdf文件是否可以打开
    //add by gao_yufeng end
}

@property int currentIdx;
@property size_t pages;

//@property (retain , nonatomic) IBOutlet PaintingView *drawingView;
@property (retain , nonatomic) NSMutableDictionary *paintingPages;
@property (retain , nonatomic) NSMutableDictionary *paintingImages;
@property (readonly , nonatomic) NSMutableDictionary *isFlipPages;

@property (nonatomic) CGPDFDocumentRef pdf;
@property (nonatomic, assign) id<PDFScrollViewDelegate> scrollViewDelegate;

//add by gao_yufeng begin 2012-6-7
@property (nonatomic, assign) BOOL canOpen;//pdf文件是否可以打开

@property (nonatomic, assign) CGFloat initPdfScaleWidth;
@property (nonatomic, assign) CGFloat currentPdfScaleWidth;
@property (nonatomic, assign) BOOL isFirstSign;
//add by gao_yufeng end
//add by gyf end

//add by gyf begin
- (id)initWithFrame:(CGRect)frame tiledFrame:(CGRect)tiledFrame pdfURL:(NSURL*)pdfURL needDrawingView:(BOOL)needDrawView delegate:(id <PDFScrollViewDelegate>)delegate;
-(IBAction)turnPage:(id)sender;
- (void)changePage:(BOOL)isNext;
- (void)resetCurrentViews:(BOOL)isZooming;
- (void)setNeedDrawingView:(BOOL)needDrawingView;//设置是否需要画板
- (void)removeDrawingView;//移除画板
- (void)restoreDrawingView;//恢复画板
//当签批和浏览状态切换时，放大并且定位在左上角，反之缩小到正常比例
- (void)setInitSignScale:(BOOL)isSign;
- (BOOL)getIsNeedDrawingView;//获取是否处于签批状态
-(void)changeOrientation:(UIInterfaceOrientation)toInterfaceOrientation;//横竖屏转换事件
-(void)didChangeOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;//横竖屏转换完触发
- (void)resetCurrentViewsForAllOrientation:(BOOL)isNewPage;//横竖屏都支持的初始化函数
- (void)turnToPage:(NSInteger)toPage;//翻页到
- (PaintingView *)getDrawingView;//获取画板
- (void)flipBackgroundImageView;//上下翻转图片
- (void)removeOldTiledPDFView;//删除旧的PDFView
//add by gyf end

//add by lch begin  7-19
- (void)reloadPDFView:(NSURL *)pdfURL;
//add by lch end    7-19

- (void)nextPage;
- (void)previousPage;

@end
