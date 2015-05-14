//
//  AppTypeCell.m
//  MyAppCenter
//
//  Created by mengxianglei on 2014/04/15.
//  Copyright (c) 2014年 mengxianglei. All rights reserved.
//

#import "AppTypeCell.h"

#define AppCountFrame               CGRectMake(240, 0, 30, 50)
#define AppCountTextFont            [UIFont systemFontOfSize:18]
#define AppCountTextColor           [UIColor colorWithRed:150/255.0 green:162/255.0 blue:174/255.0 alpha:1.0]
@implementation AppTypeCell
@synthesize appCountLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        appCountLabel = [[UILabel alloc] initWithFrame:AppCountFrame];
        [appCountLabel setFont:AppCountTextFont];
        [appCountLabel setTextColor:AppCountTextColor];
        appCountLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:appCountLabel];
        
        appCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.bounds = CGRectMake(10,5,40,40);
    self.imageView.frame = CGRectMake(10,5,40,40);
    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 60;
    self.textLabel.frame = tmpFrame;
    
    tmpFrame = self.detailTextLabel.frame;
    tmpFrame.origin.x = 60;
    self.detailTextLabel.frame = tmpFrame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
