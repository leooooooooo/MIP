//
//  ClearFileView.h
//  Setting
//
//  Created by lixiangai on 14-1-26.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClearFileCell.h"
#import "ClearFileCell.h"

@protocol ClearFileViewDelegate <NSObject>
@optional

-(void)clearOver;

@end

@interface ClearFileView : UIView<UITableViewDataSource,UITableViewDelegate,ClearFileCellDelegate>
{
    UIButton *_selectedAllButton;
    UITableView *_selecteFileTable;
    NSMutableArray *fileTypeArrary;
    NSMutableDictionary *fileDictionary;
    NSMutableArray *filesizeArray;
    NSMutableArray *pdfArray;
    NSMutableArray *otherArray;
    NSMutableArray *jpgArray;
    NSMutableArray *txtArray;
    double pdfSize ;
    double txtSize ;
    double jpgSize ;
    double otherSize;

    BOOL allSelected;
    
    id<ClearFileViewDelegate> _delegate;

}
@property(nonatomic,assign)id<ClearFileViewDelegate> _delegate;
- (id)initWithFrame:(CGRect)frame delegate:(id)theDelegate;

@end
