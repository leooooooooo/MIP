//
//  NewsCenterLevelTwoCell.m
//  NewsCenter
//
//  Created by wanghao on 14-3-16.
//
//

#import "NewsCenterLevelTwoCell.h"

@implementation NewsCenterLevelTwoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y + 5, self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height);
    
    self.imageView.bounds = CGRectMake(8,(TableCellHeight - 40) / 2,40,40);
    self.imageView.frame = CGRectMake(8,(TableCellHeight - 40) / 2,40,40);
    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
    self.accessoryView.frame = CGRectMake(300, (TableCellHeight - 13) / 2, 10, 13);
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 60;
//    tmpFrame.origin.y = 5;    //行高45
    tmpFrame.origin.y = 8;
    tmpFrame.size.width = 235;
    self.textLabel.frame = tmpFrame;
    
    tmpFrame = self.detailTextLabel.frame;
    tmpFrame.origin.x = 60;
//    tmpFrame.origin.y = 25;   //行高45
    tmpFrame.origin.y = 28;
    self.detailTextLabel.frame = tmpFrame;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
