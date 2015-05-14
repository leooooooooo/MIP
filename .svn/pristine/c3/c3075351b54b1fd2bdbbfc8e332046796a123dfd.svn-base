/********************************************************************
 Author: li_xiangai
 Class description:DisplayView
 *******************************************************/
#import "DisplayView.h"
#import "PageControl.h"

#define PAGECONTROL_HEIGHT   18
@implementation DisplayView

@synthesize displaySrollView;
@synthesize pageControl;

/*********************************************************************
 Function description:初始化视图
 Parameter: frame
 Return value: id
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
//#warning pageControl高度18可以替换为宏定义
        
        displaySrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-PAGECONTROL_HEIGHT)];
        
        displaySrollView.pagingEnabled = YES;
        displaySrollView.showsHorizontalScrollIndicator = NO;
        displaySrollView.showsVerticalScrollIndicator = NO;
        displaySrollView.scrollsToTop = NO;
        displaySrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:displaySrollView];
        
        pageControl = [[PageControl alloc] initWithFrame:CGRectMake(frame.origin.x, frame.size.height-PAGECONTROL_HEIGHT, frame.size.width,PAGECONTROL_HEIGHT)];
        pageControl.backgroundColor = [UIColor colorWithRed:76.0f/255.0f green:75.0f/255.0f blue:76.0f/255.0f alpha:1.0f];
        pageControl.currentPage = 0;
        [self addSubview:pageControl];
        
    }
    
    return self;
}


/*********************************************************************
 Function description:销毁对象
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(void)dealloc
{
    [displaySrollView release];
    [pageControl release];
    [super dealloc];
}

@end
