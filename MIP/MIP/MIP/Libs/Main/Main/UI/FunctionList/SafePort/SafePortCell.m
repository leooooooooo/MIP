//
//  SafePortCell.m
//  Main
//
//  Created by kangqijun on 14-4-26.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "SafePortCell.h"

@implementation SafePortCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
