//
//  NewsCenterLevelTwoViewController.h
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import <UIKit/UIKit.h>

#import "BaseScrollViewController.h"

#import "NewsCenterLevelTwoView.h"

#import "NewsCenterLevelTwoTableViewController.h"

#import "NewsCenterCategory.h"

typedef enum{
    hotNews = 0,
    allNews = 1
}
NewsClickIndex;


@interface NewsCenterLevelTwoViewController : BaseScrollViewController<NewsCenterDcumentLevelTwoViewDelegate,NewsCenterLevelTwoTableViewDelegate,UITextFieldDelegate>
{
    NewsCenterLevelTwoView    *newsCenterLevelTwoView;
    
    NewsCenterLevelTwoTableViewController *newsCenterLevelTwoTableViewController;
    
    NewsClickIndex     newsClickIndex;
}

@property(nonatomic,assign) NewsClickIndex     newsClickIndex;
@property(nonatomic,retain) NewsCenterLevelTwoView    *newsCenterLevelTwoView;

- (void)updateNewsCenterDocumentWithCategory:(NewsCenterCategory *)entity;

//搜索结果
- (void)searchNewsCenterResultCount:(int)_count;

//根据category展示是否由table标签
- (void)changeToShowSegmentedControl;
- (void)changeToHideSegmentedControl;

//关闭
- (void)closeDocTwoLevelData:(id)sender;

- (id)initWithCategory:(NewsCenterCategory *)category;

@end
