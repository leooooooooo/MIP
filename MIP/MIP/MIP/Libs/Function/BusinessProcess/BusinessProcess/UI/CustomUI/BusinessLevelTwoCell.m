//
//  BusinessLevelTwoCell.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/02.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessLevelTwoCell.h"

#define BackGroundColor     [UIColor clearColor]
#define TextColor           [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1.0]
#define SeparatorColor      [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1.0]
#define TextFont            [UIFont systemFontOfSize:14]

#define TagBase             2048

@implementation BusinessLevelTwoCell

@synthesize customBtnView = m_customBtnView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        m_customBtnView = [[UIView alloc] initWithFrame:CGRectZero];
        
        m_customBtnView.backgroundColor = BackGroundColor;
        m_customBtnView.layer.borderColor = [SeparatorColor CGColor];
        m_customBtnView.layer.borderWidth = 1;
        
        [self.contentView addSubview:m_customBtnView];
    }
    return self;
}

- (void) setFrameWithWidthList : (NSArray *) widthList
{
    CGFloat originX = 0;
    NSInteger index = 0;
    
    for (NSString *strWidth in widthList)
    {
        CGFloat tmpWidth = [strWidth floatValue];
        UIView *tmpView = nil;
        
        CGRect frame = CGRectMake(originX,
                                  -1,
                                  tmpWidth + 1,
                                  CellHeight + 1);
        
        if (index == [widthList count] - 1) {
            
            [m_customBtnView setFrame:frame];

        }else {
            
            tmpView = [self addTextLabel];
            tmpView.frame = frame;
            tmpView.tag = TagBase + index++;
            originX += tmpWidth;
            
        }
    }
}

- (void) addText : (NSArray *)textList
{
    NSInteger index = 0;
    
    for (NSString *tmpStrText in textList) {
        UILabel *tmpLabel = (UILabel *)[self.contentView viewWithTag:(TagBase + index++)];
        tmpLabel.text = tmpStrText;
    }
}

- (UILabel *) addTextLabel
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.textColor = TextColor;
    label.backgroundColor = BackGroundColor;
    label.layer.borderColor = [SeparatorColor CGColor];
    label.layer.borderWidth = 1;
    label.font = TextFont;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    [self.contentView addSubview:label];
    return label;
}



@end
