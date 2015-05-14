//
//  NavScrollController.h
//  MOA
//
//  Created by  on 13-1-31.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseScrollView;

//BaseScrollView的协议
@protocol BaseScrollViewDelegate <NSObject>

//TODO: scrollView是否到达关闭区域
- (void)scrollViewReachCloseZone:(BOOL)isReach;

//TODO: scrollView滑动到可关闭区域内,可将其关闭
- (void)scrollViewDidMoveToClose:(BaseScrollView *)scrollView;

@end

@protocol NavScrollControllerDelegate <NSObject>

@optional
- (void)closeRootControllerAction;

@end

@interface NavScrollController : UIViewController{
    
    NSMutableArray *_viewControllers;
    
    CGRect          _viewFrame;
    
    id<NavScrollControllerDelegate> navDelegate;
}
@property (nonatomic, readonly) NSArray *viewControllers;
@property (assign, nonatomic) id<NavScrollControllerDelegate> navDelegate;

//初始化方法
- (id)initWithViewFrame:(CGRect)rect withRootViewController:(UIViewController *)viewController;

//操作方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (UIViewController *)popViewControllerAnimated:(BOOL)animated;

- (void)changeRootViewController:(UIViewController *)viewController animated:(BOOL)animated;

//未实现
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)popToRootViewControllerAnimated:(BOOL)animated;

@end




//基于NavScrollController的UIScrollView

@interface BaseScrollView : UIScrollView <UIScrollViewDelegate>{
@private
    
    UIViewController    *_childViewController;
    
    id <BaseScrollViewDelegate> _baseDelegate;
    
    CGPoint             _previousPoint;
    
    CGFloat             _leftDistance;
    CGFloat             _rightDistance;
    
}
@property (nonatomic,readonly,assign)UIViewController    *childViewController;
@property (nonatomic,assign)    id baseDelegate;
@property (nonatomic,assign)    BaseScrollView *lastScrollView;//前一个scrollView即该视图的superView
@property (nonatomic,assign)    BaseScrollView *nextScrollView;//该视图的下一个scrollView
@property (nonatomic,assign)    CGRect  validZone;

- (void)setChildViewController:(UIViewController *)viewController;

//TODO: 设置加载的控制器可左移右移的距离;   默认:不可左移右移到某个位置
- (void)setOffsetDistance:(CGFloat)leftDistance right:(CGFloat)rightDistance;

@end





//UIViewController的类别扩展

typedef enum {
    
    DefaultType = 0,        //当没有子级scrollView时,左右移动,不可停留在预先设置的左点或右点,只能停留在初始位置
    //当有子级scrollView时,可以左右移动,停留在预先设置的左点或右点
    
    AvailableMoveType       //不管有无子级scrollView,都可以停留在预先设置的左点或右点
    
}ControllerType;

@interface UIViewController (NavScrollController)

//只读属性
@property (nonatomic,assign)   NavScrollController *navScrollController;
@property (nonatomic,assign)   BaseScrollView    *scrollView;//该控制器的BaseScorllView底板

//可读写
//@property (nonatomic,assign)   id <BaseScrollViewDelegate> baseDelegate;
@property (nonatomic,assign)   CGFloat  leftMoveDistance;//可以左移的距离
@property (nonatomic,assign)   CGFloat  rightMoveDistance;//可以右移的距离

@property (nonatomic,assign)   CGFloat  leftMoveEndDistance;//向左拖动截止距离
@property (nonatomic,assign)   CGFloat  rightMoveEndDistance;//向右拖动截止距离

@property (nonatomic,assign)   ControllerType    type;
@property (nonatomic,assign,readonly)   BOOL     isNextInitialize;

@property (nonatomic,assign) BOOL isSwiping;

- (void)presentViewControllerAfterSwipeRight;

@end