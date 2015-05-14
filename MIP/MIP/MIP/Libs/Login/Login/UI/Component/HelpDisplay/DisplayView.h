/********************************************************************
 Author: li_xiangai
 Class description:DisplayView
 *******************************************************/
#import <UIKit/UIKit.h>

@class PageControl;

@interface DisplayView : UIView
{
    UIScrollView        *displaySrollView;      //滚动视图
    PageControl         *pageControl;           //页码控制视图
}

@property(nonatomic,retain) UIScrollView *displaySrollView;
@property(nonatomic,retain) PageControl *pageControl;
@end
