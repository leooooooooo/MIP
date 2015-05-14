//
//  ContactsBaseView.m
//  Contacts
//
//  Created by lu_sicong on 2014/04/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//


#import "ContactsBaseView.h"
#import "InsetTextField.h"

#define FrameWidth              frame.size.width
#define FrameHeight             frame.size.height

#define TitleBgViewFrame        CGRectMake(0, 20, FrameWidth, 53.5)
#define TitleBgViewImage        [UIImage imageNamed:@"title.png" imageBundle:contactsBundle]

#define BackButtonFrame         CGRectMake(5, 5, 60, 39.5)
#define BackButtonBgImage       [UIImage imageNamed:@"t_back.png" imageBundle:contactsBundle]

#define FilterButtonFrame       CGRectMake(255, 7, 55, 35)
#define FilterButtonBgImage     [UIImage imageNamed:@"t_bg.png" imageBundle:mainBundle]

#define TabButtonFrame          CGRectMake(75, 5, 170, 39.5)

#define SearchBarTextImage      [UIImage imageNamed:@"search_bg.png" imageBundle:contactsBundle]
#define SearchBarTextFrame      CGRectMake(0, 70, 320, 45)
#define SearchBarTextFont       [UIFont boldSystemFontOfSize:15]

#define SearchResultViewFrame   CGRectMake(0, 70, 320, 45)
#define SearchResultBgColor     [UIColor colorWithRed:117/255.0 green:144/255.0 blue:173/255.0 alpha:1.0]
#define SearchResultTextFrame   CGRectMake(70, 0, 240, 45)
#define SearchResultBtnBgImage  [UIImage imageNamed:@"button_q.png" imageBundle:contactsBundle]
#define SearchResultBtnFrame    CGRectMake(240, 10, 60, 25)
#define SearchResultTextFont    [UIFont systemFontOfSize:12]
#define SearchResultTextColor   [UIColor colorWithHex:@"3c557f"]

#define SubContentViewFrame     CGRectMake(0, 50 + 45 + 20, FrameWidth, FrameHeight - 50 - 45)

@implementation ContactsBaseView

@synthesize delegate = m_delegate;
@synthesize filterBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        m_headerBgView = [[UIImageView alloc] initWithImage:TitleBgViewImage];
        m_headerBgView.frame = TitleBgViewFrame;
        m_headerBgView.userInteractionEnabled = YES;
        [self addSubview:m_headerBgView];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = BackButtonFrame;
        [backBtn setBackgroundImage:BackButtonBgImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [m_headerBgView addSubview:backBtn];
        
        filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        filterBtn.frame = FilterButtonFrame;
        [filterBtn setBackgroundImage:FilterButtonBgImage forState:UIControlStateNormal];
        [filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [filterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        filterBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [filterBtn addTarget:self action:@selector(filterCompany) forControlEvents:UIControlEventTouchUpInside];
        filterBtn.hidden = YES;
        [m_headerBgView addSubview:filterBtn];
        
        m_searchText = [[InsetTextField alloc] initWithFrame:SearchBarTextFrame];
        m_searchText.background = [SearchBarTextImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        m_searchText.placeholder = @"请输入关键字搜索";
        m_searchText.font = SearchBarTextFont;
        m_searchText.inset = CGPointMake(50, 0);
        m_searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
        m_searchText.clearButtonInset = CGPointMake(10, 0);
        m_searchText.returnKeyType = UIReturnKeySearch;
        m_searchText.delegate = self;
        
        
        [self addSubview:m_searchText];
        
        m_searchResultView = [[UIView alloc] initWithFrame:SearchResultViewFrame];
        m_searchResultView.backgroundColor = SearchResultBgColor;
        m_searchResultText = [[UILabel alloc] initWithFrame:SearchResultTextFrame];
        m_searchResultText.backgroundColor = [UIColor clearColor];
        m_searchResultText.textColor = SearchResultTextColor;
        [m_searchResultView addSubview:m_searchResultText];
        UIButton *searchResultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchResultBtn.frame = SearchResultBtnFrame;
        [searchResultBtn setBackgroundImage:[SearchResultBtnBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        
        [searchResultBtn setTitle:@"退出搜索" forState:UIControlStateNormal];
        [searchResultBtn setTitleColor:SearchResultTextColor forState:UIControlStateNormal];
        searchResultBtn.titleLabel.font = SearchResultTextFont;
        
        [searchResultBtn addTarget:self action:@selector(clearSearch)
                  forControlEvents:UIControlEventTouchUpInside];
        [m_searchResultView addSubview:searchResultBtn];
        m_searchResultView.hidden = YES;
        
        [self addSubview:m_searchResultView];
        
        m_contentView = [[UIView alloc] initWithFrame:SubContentViewFrame];
        [self addSubview:m_contentView];
        
        [self bringSubviewToFront:m_headerBgView];
        
    }
    return self;
}

- (void) dealloc
{
    [m_searchText release];
    
    [m_contentView release];
    
    [m_searchResultView release];
    
    [m_searchResultText release];
    
    [m_headerBgView release];
    
    [super dealloc];
}

- (void) setSubView:(UIView *)subView
{
    [m_contentView addSubview:subView];
}

- (void) backButtonClick
{
    [self clearSearch];
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(backBtnClick)]) {
        [m_delegate backBtnClick];
    }
}

- (void) filterCompany
{
//    [self clearSearch];
    
    m_searchResultView.hidden = YES;
    m_searchResultText.text = @"";
    m_searchText.text = @"";
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(filterCompanyClick)]) {
        [m_delegate filterCompanyClick];
    }
}

- (void) searchContactsByKey
{
    [m_searchText resignFirstResponder];
    
    NSString *sKey = m_searchText.text;
    
    if (sKey && sKey.length > 0) {
        
        m_searchResultView.hidden = NO;
        m_searchResultText.text = [NSString stringWithFormat:@"搜索关键字：%@", m_searchText.text];
        
        if (m_delegate && [m_delegate respondsToSelector:@selector(search:)]) {
            [m_delegate search:m_searchText.text];
        }
        
    }
    else {
        [self showAlert:@"没有输入关键字！" andMsg:@"请输入关键字"];
    }
}

- (void) showAlert : (NSString *) title andMsg : (NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self
                                          cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void) clearSearch
{
    m_searchResultView.hidden = YES;
    m_searchResultText.text = @"";
    m_searchText.text = @"";
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(search:)]) {
        [m_delegate search:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == m_searchText) {
        [self searchContactsByKey];
    }
    return YES;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

