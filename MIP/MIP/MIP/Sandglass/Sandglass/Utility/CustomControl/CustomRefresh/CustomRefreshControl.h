
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	PullRefreshNormal = 0,
    PullRefreshPulling,
	PullRefreshLoading,	
} PullRefreshState;

typedef enum{
	PushRefreshNormal = 0,
    PushRefreshPushing,
	PushRefreshLoading,
} PushRefreshState;

@protocol CustomRefreshControlDelegate;
@interface CustomRefreshControl : NSObject {
	
	id _delegate;
	PullRefreshState footerState;
	PushRefreshState headerState;

    UIView *_headerView;//下拉刷新的展示视图
	UILabel *_headerLastUpdatedLabel;//显示更新时间的UILabel
	UILabel *_headerStatusLabel;//显示当前下拉状态的UILabel
	CALayer *_headerArrowImage;//下拉刷新的指示箭头
	UIActivityIndicatorView *_headerActivityView;//下拉刷新时,加载中的指示器
    BOOL    _headerLoading;//是否正在加载数据
    
    
	UIView  *_footerView;
	UILabel *_footerLastUpdatedLabel;
	UILabel *_footerStatusLabel;
	CALayer *_footerArrowImage;
	UIActivityIndicatorView *_footerActivityView;
    BOOL    _footerLoading;
    
    
    UIView  *_autoFooterView;
    UILabel *_autoFooterStatusLabel;
    UIActivityIndicatorView *_autoFooterActivityView;
    BOOL    _autoFooterLoading;

}

//TODO: 刷新控件的属性配置

@property (nonatomic,assign) id <CustomRefreshControlDelegate> delegate;


//TODO: 上拉手动刷新视图及属性
@property (nonatomic, assign, readonly) UIView  *headerView;
@property (nonatomic, assign, readonly) UILabel *headerStatusLabel;
@property (nonatomic, assign, readonly) UILabel *headerLastUpdatedLabel;
@property (nonatomic, assign, readonly) UIActivityIndicatorView *headerActivityView;
@property (nonatomic, assign, readonly) CALayer *headerArrowImage;
@property (nonatomic, assign, readonly) BOOL    headerLoading;//下拉刷新是否正在加载数据中


//TODO: 下拉手动加载视图及属性
@property (nonatomic, assign, readonly) BOOL    footerLoading;//上拉刷新是否正在加载数据中


//TODO: 下拉自动加载视图及属性
@property (nonatomic, assign, readonly) UIView  *autoFooterView;
@property (nonatomic, assign, readonly) UILabel *autoFooterStatusLabel;
@property (nonatomic, assign, readonly) UIActivityIndicatorView *autoFooterActivityView;
@property (nonatomic, assign, readonly) BOOL    autoFooterLoading;

//TODO: 下拉刷新
- (UIView *)createHeaderViewWithFrame:(CGRect)frame;//创建下拉刷新的视图

- (void)refreshHeaderLastUpdatedDate;//获取上次下拉的刷新时间,通过refreshTableHeaderDataSourceLastUpdated:代理方法获取

- (void)refreshScrollViewDataSourceDidFinishedHeaderLoading:(UIScrollView *)scrollView;//用户复位表视图,并获取上次下拉刷新的更新时间



//TODO: 上拉刷新
- (UIView *)createFooterViewWithFrame:(CGRect)frame;//创建上拉刷新的视图

- (void)refreshFooterLastUpdatedDate;//获取上次上拉的刷新时间,通过refreshTableFooterDataSourceLastUpdated:代理方法获取

- (void)refreshScrollViewDataSourceDidFinishedFooterLoading:(UIScrollView *)scrollView;//用户复位表视图,并获取上次上拉刷新的更新时间


//TODO: 自动上拉刷新
- (UIView *)createAutoFooterViewWithFrame:(CGRect)frame;//创建上拉到阀值时,自动加载的视图
- (void)autoRefreshScrollViewDataSourceDidFinishedFooterLoading:(UIScrollView *)scrollView;


//TODO:必须要调用的方法
- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;//手指屏幕上不断拖动调用此方法
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;//当用户停止拖动，并且手指从屏幕中拿开的的时候调用此方法

@end
@protocol CustomRefreshControlDelegate

@optional

- (void)refreshTableHeaderDidTriggerRefresh:(CustomRefreshControl*)view;//下拉手指松开时的刷新事件

- (NSDate*)refreshTableHeaderDataSourceLastUpdated:(CustomRefreshControl*)view;//下拉时需要获取上次更新时间


- (void)refreshTableFooterDidTriggerRefresh:(CustomRefreshControl*)view;//上拉手指松开时的刷新事件

- (NSDate*)refreshTableFooterDataSourceLastUpdated:(CustomRefreshControl*)view;//上拉时需要获取上次更新时间

//TODO: 当UIScrollView将要滚到底部还剩    kReachToBottomMargin    距离时,将对触发一次这个方法
- (void)autoRefreshTableFooterDidTriggerRefresh:(CustomRefreshControl*)view;
@end
