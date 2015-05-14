//
//  ClearFileCell.h
//  Setting
//
//  Created by lixiangai on 14-1-26.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ClearFileCellDelegate;

@interface ClearFileCell : UITableViewCell
{
    UILabel *fileTpyeLable;
    UILabel *totalSize;
    UIButton *selectedButtn;
    BOOL selectedCell;
    id<ClearFileCellDelegate> delegate;


}

@property(nonatomic,retain)UILabel *fileTpyeLable;
@property(nonatomic,retain)UILabel *totalSize;
@property(nonatomic,retain)UIButton *selectedButtn;
@property(nonatomic,assign)BOOL selectedCell;
@property(nonatomic,assign)  id<ClearFileCellDelegate> delegate;

-(void)setTheSelectedState:(BOOL)state;
@end
@protocol ClearFileCellDelegate <NSObject>
@optional

-(void)selectedCell:(ClearFileCell*)cell;

@end