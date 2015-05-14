//
//  NewsCenterLevelTwoView.m
//  NewsCenter
//
//  Created by wanghao on 14-3-12.
//
//

#import "NewsCenterLevelTwoView.h"

#import "UIColor+CustomExtensions.h"

#define kSegmentedControlNormalColor                        [UIColor colorWithRed:209/255.0 green:225/255.0 blue:240/255.0 alpha:1.0]
#define kSegmentedControlSelectedColor                      [UIColor colorWithRed:84/255.0 green:165/255.0 blue:242/255.0 alpha:1.0]

@implementation NewsCenterLevelTwoView
@synthesize segmentedControl;

@synthesize filtrateBtn, closeBtn, searchBtn, backSearchBtn, searchTextField, m_delegate;

@synthesize filtrateDataArr;

@synthesize filtrateStr;

@synthesize backBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, 54)];
        navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png" imageBundle:mainBundle];
        [self addSubview:navBarImg];
        [navBarImg release];
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(5, 25, 60, 40);
        [backBtn setBackgroundImage:[UIImage imageNamed:@"t_back.png" imageBundle:mainBundle] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor colorWithHex:@"3c557f"] forState:UIControlStateNormal];
        [self addSubview:backBtn];
        
        segmenteBGView = [[UIImageView alloc] initWithFrame:CGRectMake(72, 23, 176, 45)];
        segmenteBGView.image = [UIImage imageNamed:@"segmented_bg_style1.png" imageBundle:publicResourceBundle];
        segmenteBGView.backgroundColor = [UIColor clearColor];
        [self addSubview:segmenteBGView];
        [segmenteBGView release];
        
        //选项栏视图
        segmentedControl = [[CustomSegmentedControl alloc] initWithFrame:CGRectMake(75, 25, 170, 40)];
        
//        segmentedControl.backgroundImage = [UIImage imageWithContentsOfFile:@"segmented_bg_style1.png" imageBundle:publicResourceBundle];
        segmentedControl.sliderImage = [UIImage imageWithContentsOfFile:@"segmented_slider_style1.png" imageBundle:publicResourceBundle];
        
        UIButton *button = [segmentedControl insertButton];
        [button setTitle:@"今日关注" forState:UIControlStateNormal];
//        button.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        button = [segmentedControl insertButton];
        [button setTitle:@"全部新闻" forState:UIControlStateNormal];
//        button.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self addSubview:segmentedControl];
        
        UIImageView *textFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, frame.size.width, 45)];
        textFieldBg.image = [UIImage imageNamed:@"search_bg.png" imageBundle:newsCenterBundle];
        [self addSubview:textFieldBg];
        [textFieldBg release];
        
        searchTextField = [[InsetTextField alloc] initWithFrame:CGRectMake(45, 70, frame.size.width-45, 45)];
        searchTextField.placeholder = @"请输入关键字搜索";
        searchTextField.clearButtonInset = CGPointMake(10, 0);
        searchTextField.font = [UIFont systemFontOfSize:15];
        searchTextField.backgroundColor = [UIColor clearColor];
        [searchTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        searchTextField.returnKeyType = UIReturnKeyGo;
        [self addSubview:searchTextField];
        
//        backSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        backSearchBtn.frame = CGRectMake(frame.size.width-40, 85, 15, 15);
//        [backSearchBtn setBackgroundImage:[UIImage imageNamed:@"search_cancel.png" imageBundle:newsCenterBundle] forState:UIControlStateNormal];
//        [self addSubview:backSearchBtn];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, 50)];
        titleLab.textAlignment = UITextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont boldSystemFontOfSize:24];
        titleLab.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLab];
        [titleLab release];
        
    }
    return self;
}

- (void)loadNewsWithCategory:(NewsCenterCategory *)category
{    
    titleLab.text = category.title;
    /*
    if ([category.code isEqualToString:@"XWXX"])
    {
        titleLab.hidden = YES;
        
        segmenteBGView.hidden = NO;
        segmentedControl.hidden = NO;
    }
    else
    {
        titleLab.hidden = NO;
        
        segmenteBGView.hidden = YES;
        segmentedControl.hidden = YES;
    }
    */
    titleLab.hidden = NO;
    
    segmenteBGView.hidden = YES;
    segmentedControl.hidden = YES;
}

//显示筛选弹出框
- (void)showFiltrateViewWith:(NSString *)filters
{
    if (filters == nil || [filters isEqualToString:@""])
    {
        UIAlertView *warnAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"无筛选条件！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        
        [warnAlert show];
        [warnAlert release];
        
        return;
    }
    
    self.filtrateDataArr = [filtrateStr componentsSeparatedByString:@","];
    
    arrowBgImage.image = [UIImage imageNamed:@"arrow_up.png" imageBundle:newsCenterBundle];
    
    UIView *subView = [self createContentView];
    popListView = [[CustomPopListView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    popListView.m_delegate = self;
    [popListView loadContentViewWith:subView withPosionView:filtrateBtn];
    
    CGRect rect = subView.frame;
    rect.origin.y = rect.origin.y - 2;
    subView.frame = rect;
    
    [popListView release];
    [subView release];
}


//生成弹出框内容视图
- (UIView *)createContentView
{
    float height = [filtrateDataArr count]*40;
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, height)];
    
    for (int i=0; i<[filtrateDataArr count]; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"funnelButton_bg.png" imageBundle:newsCenterBundle] forState:UIControlStateNormal];
        [btn setTitle:[filtrateDataArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:@"3c557f"] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 2;
        btn.titleLabel.textAlignment = UITextAlignmentCenter;
        btn.tag = i;
        btn.frame = CGRectMake(0, 38*i, 120, 40);
        [btn addTarget:self action:@selector(chooseTishFilter:) forControlEvents:UIControlEventTouchUpInside];
        [subView addSubview:btn];
        
    }
    
    return subView;
}


- (void)chooseTishFilter:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    [popListView closePopListView];
    
    NSString *title = [filtrateDataArr objectAtIndex:btn.tag];
    
    searchResultView.hidden = NO;
    searchInputView.hidden = YES;
    
    if (m_delegate)
    {
        [m_delegate filterNewsCenterDcumentWith:title];
    }
}

//显示搜索视图
- (void)showSearchInputView
{
    searchResultView.hidden = YES;
    searchInputView.hidden = NO;
    
    searchResultLab.text = @"";
    searchNumLab.text = @"";
    
    [searchTextField resignFirstResponder];
}

//显示搜索结果视图
- (void)showSearchResultViewWithKeyword:(NSString *)_keyString count:(int)_count
{
    searchInputView.hidden = YES;
    searchResultView.hidden = NO;
    
    searchResultLab.text = [NSString stringWithFormat:@"%@",_keyString];
    searchNumLab.text = [NSString stringWithFormat:@"%d",_count];
}


#pragma mark - CustomPopListViewDelegate
- (void)removePopListView
{
    arrowBgImage.image = [UIImage imageNamed:@"arrow_down.png" imageBundle:newsCenterBundle];
}


- (void)changeToHideSegmentedControlView
{
    CGRect rect = searchInputView.frame;
    rect.origin.y = 5;
    searchInputView.frame = rect;
    
    CGRect searchRect = searchBtn.frame;
    searchRect.origin.x = 430;
    searchBtn.frame = searchRect;
    
    searchResultView.frame = rect;
    
    segmentedControl.hidden = YES;
    segmenteBGView.hidden = YES;
    
    searchInputView.hidden = NO;
    searchResultView.hidden = YES;
}

- (void)changeToShowSegmentedControlView
{
    CGRect rect = searchInputView.frame;
    rect.origin.y = 55;
    searchInputView.frame = rect;
    
    CGRect searchRect = searchBtn.frame;
    searchRect.origin.x = 530;
    searchBtn.frame = searchRect;
    
    searchResultView.frame = rect;
    
    segmentedControl.hidden = NO;
    
    searchInputView.hidden = NO;
    searchResultView.hidden = YES;
    
    [segmentedControl setdefaultSelectButtonIndex:0];
}

- (void)hiddenFiltrateView
{
    filtrateBtnBg.hidden = YES;
    funnelBg.hidden = YES;
    arrowBgImage.hidden = YES;
    filtrateBtn.hidden = YES;
}

- (void)showFiltrateView
{
    filtrateBtnBg.hidden = NO;
    funnelBg.hidden = NO;
    arrowBgImage.hidden = NO;
    filtrateBtn.hidden = NO;
}

- (void)dealloc {
    
    [searchInputView release];
    [searchResultView release];
    [searchResultLab release];
    [searchNumLab release];
    [arrowBgImage release];
    [searchTextField release];
    [segmentedControl release];
    segmentedControl = nil;
    [filtrateStr release];
    [filtrateBtnBg release];
    [funnelBg release];
    
    [super dealloc];
}

@end
