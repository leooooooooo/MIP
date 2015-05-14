//
//  FunctionListCell.m
//  Main
//
//  Created by kangqijun on 14-4-15.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "FunctionListCell.h"

@implementation FunctionListCell

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
    
    self.imageView.bounds = CGRectMake(15,5,40,40);
    self.imageView.frame = CGRectMake(15,5,40,40);
    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
    self.accessoryView.frame = CGRectMake(300, 20, 10, 13);
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 70;
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
