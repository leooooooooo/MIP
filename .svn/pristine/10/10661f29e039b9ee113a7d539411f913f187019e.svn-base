//
//  NewsCenterLevelOneCell.m
//  NewsCenter
//
//  Created by wanghao on 14-3-13.
//
//

#import "NewsCenterLevelOneCell.h"

@implementation NewsCenterLevelOneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y + 10, self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height);
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.bounds = CGRectMake(10,5,40,40);
    self.imageView.frame = CGRectMake(10,5,40,40);
    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
    self.accessoryView.frame = CGRectMake(230, 20, 10, 13);
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 60;
    self.textLabel.frame = tmpFrame;
    
    tmpFrame = self.detailTextLabel.frame;
    tmpFrame.origin.x = 60;
    self.detailTextLabel.frame = tmpFrame;
}

@end
