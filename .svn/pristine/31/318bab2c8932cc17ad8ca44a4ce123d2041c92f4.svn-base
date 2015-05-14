//
//  BusinessLevelOneCell.m
//  BusinessProcess
//
//  Created by lu_sicong on 2014/04/01.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BusinessLevelOneCell.h"

@implementation BusinessLevelOneCell

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
