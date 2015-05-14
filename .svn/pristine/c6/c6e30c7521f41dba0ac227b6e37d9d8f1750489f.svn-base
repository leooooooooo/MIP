//
//  DisplayComponent.m
/********************************************************************
 Author: li_xiangai
 Class description:DisplayComponent
 *******************************************************/
#import "DisplayComponent.h"

#import "LoginViewController.h"
#import "LoginView.h"

#import "DisplayView.h"

#import "DisplayViewController.h"

@implementation DisplayComponent

/*********************************************************************
 Function description:帮助按钮点击事件
 Parameter: sender
 Return value: N/A
 Author: li_xiangai
 Remark: override
 *********************************************************************/

- (id)initWithComposite:(id)composite {
    
    self = [super initWithComposite:composite];
    
    if (self) {
        
        _loginViewController = (LoginViewController *)composite;
        _loginView = _loginViewController->_loginView;

        [_loginView.helpButton addTarget:self action:@selector(helpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
    
}

- (void)helpButtonClicked:(id)sender
{
     //图片名数组
    NSArray *array = [[NSArray alloc] initWithObjects:@"help_1",@"help_2",@"help_3",@"help_4",@"help_5", nil];
    
    DisplayViewController *displayController = [[DisplayViewController alloc] init];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    CGRect rect = CGRectMake(0, 0, 1024, 748-18);

    //图片视图数组
    for (int i = 0; i < array.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[array objectAtIndex:i] imageBundle:@"Login"]];
         imageView.frame = rect;
        [imageArray addObject:imageView];
        [imageView release];
      
    }
    displayController.pageViewArray = imageArray;
    [imageArray release];
    [array release];
    
    //动画加载图片展示视图
    [_loginViewController.view addSubview:displayController.view];
    [_loginViewController addChildViewController:displayController];
    [displayController release];
    
    [displayController.view setAlpha:0.0];
    [UIView beginAnimations:@"" context:NULL];
    [UIView setAnimationDuration:0.5];
    [displayController.view setAlpha:1.0];
    [UIView commitAnimations];
      
}

@end
