//
//  ClearFileCell.m
//  Setting
//
//  Created by lixiangai on 14-1-26.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "ClearFileCell.h"

@implementation ClearFileCell
@synthesize fileTpyeLable,totalSize,selectedButtn,selectedCell,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        //文件类型
        fileTpyeLable = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 137, 40)];
        fileTpyeLable.backgroundColor = [UIColor clearColor];
        fileTpyeLable.textColor = [UIColor blackColor];
        fileTpyeLable.font = [UIFont systemFontOfSize:18];
        [self addSubview:fileTpyeLable];
        [fileTpyeLable release];
        
        //文件总大小
        totalSize = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 70, 40)];
        totalSize.backgroundColor = [UIColor clearColor];
        totalSize.textColor = [UIColor blackColor];
        totalSize.textAlignment = UITextAlignmentRight;
        totalSize.font = [UIFont systemFontOfSize:18];
        [self addSubview:totalSize];
        
        selectedButtn = [[UIButton alloc] init];
        selectedButtn.frame = CGRectMake(245, 12, 16, 16);
        [selectedButtn setBackgroundColor:[UIColor clearColor]];
        [selectedButtn setBackgroundImage:[UIImage imageNamed:@"file_unselected.png" imageBundle:settingBundle] forState:UIControlStateNormal];
        [selectedButtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectedButtn];
        [selectedButtn release];
        selectedCell = NO;
        
    }
    return self;
}

-(void)selectedAction:(UIButton *)btn
{
    selectedCell = !selectedCell;
    [selectedButtn setBackgroundImage:[UIImage imageNamed:@"file_unselected.png" imageBundle:settingBundle] forState:UIControlStateNormal];
    if (selectedCell)
    {
       [selectedButtn setBackgroundImage:[UIImage imageNamed:@"file_selected.png" imageBundle:settingBundle] forState:UIControlStateNormal]; 
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedCell:)])
    {
        [delegate selectedCell:self];
    }
   
}

-(void)setTheSelectedState:(BOOL)state
{
    if (state)
    {
        [selectedButtn setBackgroundImage:[UIImage imageNamed:@"file_selected.png" imageBundle:settingBundle] forState:UIControlStateNormal];

    }
    else
    {
      [selectedButtn setBackgroundImage:[UIImage imageNamed:@"file_unselected.png" imageBundle:settingBundle] forState:UIControlStateNormal];
    }
}



@end
