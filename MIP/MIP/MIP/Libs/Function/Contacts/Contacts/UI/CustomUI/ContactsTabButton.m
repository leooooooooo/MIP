//
//  TabButton.m
//  Contacts
//
//  Created by lu_sicong on 2014/03/16.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "ContactsTabButton.h"

#define SeparatorWidth          0

#define ButtonCount             2
#define ButtonTitles            [NSArray arrayWithObjects:@"员工通讯录",@"机构通讯录", nil]

#define BackGroundImage         [UIImage imageNamed:@"title_qh_1.png" imageBundle:contactsBundle]
#define StateOnImage            [UIImage imageNamed:@"title_qh_2.png" imageBundle:contactsBundle]
#define StateOffTextColor       [UIColor colorWithRed:148/255.0 green:164/255.0 blue:177/255.0 alpha:1.0]
#define StateOnTextColor        [UIColor whiteColor]

#define BaseButtonTag           1000

@interface ContactsTabSubButton : UIButton
{
    BOOL m_btnState;
}

@property (nonatomic) BOOL btnState;

@end

@implementation ContactsTabSubButton

@synthesize btnState = m_btnState;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setBackgroundImage:StateOnImage forState:UIControlStateNormal];
        [self setTitleColor:StateOnTextColor forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    return self;
}

- (void) setBtnState:(BOOL)btnState
{
    m_btnState = btnState;
    
    if (m_btnState) {
        [self setBackgroundImage:StateOnImage forState:UIControlStateNormal];
        [self setTitleColor:StateOnTextColor forState:UIControlStateNormal];
    }
    else
    {
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setTitleColor:StateOffTextColor forState:UIControlStateNormal];
    }
}

@end

@implementation ContactsTabButton

@synthesize delegate = m_delegate;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self setImage:BackGroundImage];
        self.userInteractionEnabled = YES;
        
        NSArray *buttonTitlesArray = ButtonTitles;
        
        CGFloat btnWidth = (frame.size.width - SeparatorWidth) / ButtonCount - SeparatorWidth;
        CGFloat btnHeight = frame.size.height - SeparatorWidth;
        
        NSInteger btnIndex = 0;
        for (NSString *btnTitle in buttonTitlesArray) {
            
            ContactsTabSubButton *tmpBtn = [[ContactsTabSubButton alloc] initWithFrame:CGRectMake(SeparatorWidth + (btnWidth + SeparatorWidth) * btnIndex, SeparatorWidth, btnWidth, btnHeight)];
            
            tmpBtn.btnState = (btnIndex == 0);
            
            if (btnIndex == 0) {
                m_selectedBtn = tmpBtn;
            }
            
            [tmpBtn setTitle:btnTitle forState:UIControlStateNormal];
            
            tmpBtn.tag = (BaseButtonTag + btnIndex++);
            
            [tmpBtn addTarget:self action:@selector(clickTagButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:tmpBtn];
        }
    }
    
    return self;
}


- (void) clickTagButton:(id)sender
{
    ContactsTabSubButton *clickedBtn = (ContactsTabSubButton *)sender;
    if (clickedBtn.btnState != YES) {
        clickedBtn.btnState = YES;
        ((ContactsTabSubButton *)m_selectedBtn).btnState = NO;
        m_selectedBtn = clickedBtn;
    }
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(clickTagButtonWithBtnTag:)]) {
        [m_delegate clickTagButtonWithBtnTag:(clickedBtn.tag - BaseButtonTag)];
    }
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


