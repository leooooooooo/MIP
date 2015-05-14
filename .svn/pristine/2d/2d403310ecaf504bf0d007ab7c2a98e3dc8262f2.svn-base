//
//  WeiboButton.m
//  Main
//
//  Created by lu_sicong on 2014/05/10.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "WeiboButton.h"

@implementation WeiboButton

@synthesize newsArr = m_newsArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        m_btnTitle.frame = CGRectMake(35, frame.size.height - 38, frame.size.width, 20);
        m_btnTitle.textAlignment = UITextAlignmentLeft;
    }
    return self;
}

- (void) setNewsArr:(NSArray *)newsArr
{
    m_newsArr = newsArr;
    
    NSString *title = [m_newsArr firstObject];
    if (isValid(title) && title.length > 0) {
        NSString *strTitle = [NSString stringWithFormat:@"%@(%@)",self.strBtnTitle,title];
        self.strBtnTitle = strTitle;
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
