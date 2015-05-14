//
//  NoteViewController.h
//  CommonlyUsedTool
//
//  Created by wanghao on 14-3-28.
//  Copyright (c) 2014年 wanghao. All rights reserved.
//

#import "BaseViewController.h"
#import "NoteView.h"
#import "PDFToolViewController.h"

@interface NoteViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate,UITextFieldDelegate,PDFToolDelegate>{
    NoteView            *noteView;
    
    UITableView         *categoryTableView;
    UITableView         *itemTableView;
    
}

@end
