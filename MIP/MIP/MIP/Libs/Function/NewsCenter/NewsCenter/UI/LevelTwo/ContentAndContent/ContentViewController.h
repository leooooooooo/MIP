//
//  ContentViewController.h
//  NewsCenter
//
//  Created by wanghao on 14-3-19.
//
//

#import <UIKit/UIKit.h>

@protocol ContentViewControllerDelegate <NSObject>

- (void)backToViewController;

@end

@interface ContentViewController : UIViewController{
    UIWebView *contentWebView;
    UILabel *titleLabel;
    UILabel *authorLabel;
    UILabel *sourceLabel;
    
    id<ContentViewControllerDelegate> contentDelegate;
}
@property(nonatomic, retain)UIWebView *contentWebView;
@property(nonatomic, retain)UILabel *titleLabel;
@property(nonatomic, retain)UILabel *authorLabel;
@property(nonatomic, retain)UILabel *sourceLabel;

@property(nonatomic, assign)id<ContentViewControllerDelegate> contentDelegate;

@end
