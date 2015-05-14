/********************************************************************
 Author: li_xiangai
 Class description:DisplayViewController
 *******************************************************/
#import "DisplayViewController.h"
#import "UIImage+CustomExtensions.h"

@interface DisplayViewController (PrivateMethods)
-(void)loadScrollViewWithPage:(int)page;
@end

@implementation DisplayViewController
@synthesize pageViewArray;

/*********************************************************************
 Function description: Implement loadView to create a view hierarchy programmatically, without using a nib。
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (void)loadView
{
    _displayView = [[DisplayView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    self.view = _displayView;
}
/*********************************************************************
 Function description:加载视图
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _displayView.displaySrollView.delegate = self;
    [_displayView.displaySrollView setContentSize:CGSizeMake(self.view.frame.size.width*pageViewArray.count, self.view.frame.size.height - 18)];
    _displayView.pageControl.delegate = self;
    _displayView.pageControl.numberOfPages = pageViewArray.count;
    _displayView.pageControl.currentPage=0;
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
	
}


#pragma mark scrollview delegate
/*********************************************************************
 Function description:scrollView 滚动时调用
 Parameter: scrollView
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    //根据当前page，加载imageview
    CGFloat pageWidth = _displayView.displaySrollView.frame.size.width;
    int page = floor((_displayView.displaySrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _displayView.pageControl.currentPage = page;
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];

}

#pragma mark -
#pragma mark PageControlDelegate Menthods
/*********************************************************************
 Function description:pageControl代理，pagecontrol改变时调用
 Parameter: pageControl
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (void)pageControlPageDidChange:(PageControl *)pageControl
{
    int page = _displayView.pageControl.currentPage;
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = _displayView.displaySrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [_displayView.displaySrollView scrollRectToVisible:frame animated:YES];

}


#pragma mark 
/*********************************************************************
 Function description:ScrollView加载图片
 Parameter: page
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0 || page >= pageViewArray.count)
        return;
    UIImageView *imageView = [pageViewArray objectAtIndex:page];
    
    // add the imageview  to the scroll view
    if (imageView.superview == nil )
    {
        //UIInterfaceOrientationLandscape
        CGRect frame = _displayView.displaySrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        imageView.frame = frame;
        [_displayView.displaySrollView addSubview:imageView];
        
        //add button to last imageview
        if (page == pageViewArray.count-1)
        {
            UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width*(page+1)-142.0-10, frame.size.height-53, 142.0f, 53.0f)];
            [backButton setBackgroundImage:[UIImage imageWithContentsOfFile:@"startUse" imageBundle:@"Login"] forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(backToLoginView) forControlEvents:UIControlEventTouchUpInside];
            [_displayView.displaySrollView addSubview:backButton];
            [backButton release];

        }
   
    }
}
/*********************************************************************
 Function description:返回登录动画
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
-(void)backToLoginView
{
    [UIView beginAnimations:@"" context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.view setAlpha:0.0];
    [UIView commitAnimations];
    [self performSelector:@selector(delayRemoveView) withObject:nil afterDelay:0.5];
}

/*********************************************************************
 Function description:返回登录界面时，移出视图和控制器
 Parameter: N/A
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/
- (void)delayRemoveView
{
    [self.view removeFromSuperview];
    
    if ([self parentViewController])
    {
        [self removeFromParentViewController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_displayView release];
    [pageViewArray release];
    [super dealloc];

}

@end
