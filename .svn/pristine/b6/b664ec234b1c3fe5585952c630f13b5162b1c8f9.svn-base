//
//  SignInView.m
//  Main
//
//  Created by lu_sicong on 2014/04/14.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "SignInView.h"

#define TopFrameBgColor     [UIColor colorWithRed:89/255.0 green:115/255.0 blue:146/255.0 alpha:1.0]
#define BottomFrameBgColor  [UIColor colorWithRed:244/255.0 green:249/255.0 blue:255/255.0 alpha:1.0]

#define SelectedTextColor   [UIColor colorWithRed:83/255.0 green:159/255.0 blue:254/255.0 alpha:1.0]

#define CurTimeFormat       @"yyyy-MM-dd  HH:mm"

@implementation SignInView

@synthesize delegate = m_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 105)];
        topView.backgroundColor = TopFrameBgColor;
        [self addSubview:topView];
        
        UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *signInIcon = [UIImage imageNamed:@"sign.png" imageBundle:mainBundle];
        [signInBtn setBackgroundImage:signInIcon forState:UIControlStateNormal];
        signInBtn.frame = CGRectMake(15, 30, signInIcon.size.width, signInIcon.size.height);
        [topView addSubview:signInBtn];
        [signInBtn addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *positionTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 230, 14)];
        positionTitle.text = @"我现在的位置在：";
        positionTitle.font = [UIFont boldSystemFontOfSize:12];
        positionTitle.backgroundColor = [UIColor clearColor];
        positionTitle.textColor = [UIColor colorWithRed:215/255.0 green:229/255.0 blue:246/255.0 alpha:1.0];
        [topView addSubview:positionTitle];
        [positionTitle release];
        
        UIImageView *positionBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_t.png" imageBundle:mainBundle]];
        positionBgView.frame = CGRectMake(72, 36, positionBgView.image.size.width, positionBgView.image.size.height);
        [topView addSubview:positionBgView];
        
        m_currentPosition = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 210, 18)];
        m_currentPosition.font = [UIFont boldSystemFontOfSize:12];
        m_currentPosition.numberOfLines=0;
        m_currentPosition.textColor = SelectedTextColor;
        m_currentPosition.text = @"";
        m_currentPosition.backgroundColor = [UIColor clearColor];
        
        [positionBgView addSubview:m_currentPosition];
        
        [positionBgView release];
        
        m_currentTime = [[UILabel alloc] initWithFrame:CGRectMake(80, 83, 230, 14)];
        m_currentTime.font = [UIFont systemFontOfSize:12];
        m_currentTime.textColor = [UIColor colorWithRed:215/255.0 green:229/255.0 blue:246/255.0 alpha:1.0];
        m_currentTime.text = [self getCurTime];
        m_currentTime.backgroundColor = [UIColor clearColor];
        
        [topView addSubview:m_currentTime];
        
        [topView release];
        
        m_tableView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, frame.size.width, frame.size.height - 105)];
        m_tableView.backgroundColor = BottomFrameBgColor;
        [self addSubview:m_tableView];
        
        m_timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkAndUpdateTime) userInfo:nil repeats:YES];
    }
    return self;
}

- (void) signIn
{
    if (m_delegate && [m_delegate respondsToSelector:@selector(signIn)]) {
        [m_delegate signIn];
    }
}

- (void) checkAndUpdateTime
{
    NSString *curTime = [self getCurTime];
    if (![curTime isEqualToString:m_currentTime.text]) {
        m_currentTime.text = curTime;
    }
}

- (NSString *) getCurTime
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:CurTimeFormat];
    NSString *tmpDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return tmpDateStr;
}

- (void) setTableView : (UITableView *)tableView
{
    [m_tableView addSubview:tableView];
}

- (void)setCurrentPosition:(NSString *)currentPosition
{
    if (currentPosition && currentPosition.length > 0) {
        m_currentPosition.text = currentPosition;
    }else {
        m_currentPosition.text = @"";
    }
}

- (NSString *)currentPosition
{
    return m_currentPosition.text;
}

- (void)dealloc
{
    [m_currentPosition release];
    [m_currentTime release];
    [m_tableView release];
    [super dealloc];
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
